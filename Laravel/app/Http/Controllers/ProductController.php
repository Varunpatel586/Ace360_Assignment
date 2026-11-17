<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Channel;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $filters = $request->validate([
            'q' => ['nullable', 'string', 'max:100'],
            'category' => ['nullable', 'integer'],
            'status' => ['nullable', Rule::in(['active', 'draft', 'inactive'])],
            'sort' => ['nullable', Rule::in(['latest', 'oldest', 'name', 'price_low', 'price_high', 'stock'])],
            'per_page' => ['nullable', 'integer', Rule::in([5, 10, 25, 50])],
        ]);

        $query = Product::query()->with('category');

        if (filled($filters['q'] ?? null)) {
            $term = '%'.$filters['q'].'%';
            $query->where(function ($inner) use ($term) {
                $inner->where('name', 'like', $term)->orWhere('sku', 'like', $term);
            });
        }

        if (filled($filters['category'] ?? null)) {
            $query->where('category_id', $filters['category']);
        }

        if (filled($filters['status'] ?? null)) {
            $query->where('status', $filters['status']);
        }

        match ($filters['sort'] ?? 'latest') {
            'oldest' => $query->oldest(),
            'name' => $query->orderBy('name'),
            'price_low' => $query->orderBy('price'),
            'price_high' => $query->orderByDesc('price'),
            'stock' => $query->orderBy('stock'),
            default => $query->latest(),
        };

        $perPage = (int) ($filters['per_page'] ?? 5);

        $products = $query->paginate($perPage)->onEachSide(1)->withQueryString();

        $total = Product::count();
        $active = Product::active()->count();
        $lowStock = Product::lowStock()->count();
        $outOfStock = Product::outOfStock()->count();
        $recent = Product::where('created_at', '>=', now()->subDays(30))->count();

        $stats = [
            'total' => $total,
            'active' => $active,
            'low_stock' => $lowStock,
            'out_of_stock' => $outOfStock,
            'coverage' => $total > 0 ? round($active / $total * 100, 1) : 0,
            'growth' => $total > 0 ? round($recent / $total * 100, 1) : 0,
            'visible' => max(0, $total - $outOfStock),
        ];

        $critical = Product::with('category')
            ->whereColumn('stock', '<=', 'low_stock_threshold')
            ->orderByDesc('stock')
            ->orderBy('id')
            ->take(2)
            ->get();

        $breakdown = Category::withCount('products')
            ->orderByDesc('products_count')
            ->get()
            ->map(fn (Category $category) => [
                'name' => $category->name,
                'count' => $category->products_count,
                'percent' => $total > 0 ? round($category->products_count / $total * 100, 1) : 0,
            ]);

        $channels = Channel::orderBy('sort_order')->get();

        return view('products.index', compact(
            'products',
            'filters',
            'stats',
            'critical',
            'breakdown',
            'channels'
        ) + [
            'categories' => Category::orderBy('sort_order')->get(),
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate($this->rules());

        if ($request->input('intent') === 'draft') {
            $data['status'] = 'draft';
        }

        $data['sale_price'] = $data['sale_price'] ?? null;
        $data['image_path'] = $this->storeImage($request, $data['sku']);

        Product::create($data);

        return $this->redirectToIndex("Product '{$data['name']}' created successfully");
    }

    public function update(Request $request, Product $product)
    {
        $data = $request->validate($this->rules($product));

        if ($request->input('intent') === 'draft') {
            $data['status'] = 'draft';
        }

        $data['sale_price'] = $data['sale_price'] ?? null;

        $imagePath = $this->storeImage($request, $data['sku']);

        if ($imagePath) {
            $this->deleteImage($product->image_path);
            $data['image_path'] = $imagePath;
        }

        $product->update($data);

        return $this->redirectToIndex("Product '{$product->name}' updated successfully");
    }

    public function destroy(Product $product)
    {
        $name = $product->name;

        $this->deleteImage($product->image_path);
        $product->delete();

        return $this->redirectToIndex("Product '{$name}' deleted successfully");
    }

    public function bulk(Request $request)
    {
        $data = $request->validate([
            'ids' => ['required', 'array'],
            'ids.*' => ['integer', 'exists:products,id'],
            'bulk_action' => ['required', Rule::in(['delete', 'activate', 'deactivate'])],
        ]);

        $products = Product::whereIn('id', $data['ids'])->get();

        if ($data['bulk_action'] === 'delete') {
            $products->each(function (Product $product) {
                $this->deleteImage($product->image_path);
                $product->delete();
            });

            return $this->redirectToIndex($products->count().' products deleted successfully');
        }

        $status = $data['bulk_action'] === 'activate' ? 'active' : 'inactive';
        Product::whereIn('id', $products->pluck('id'))->update(['status' => $status]);

        return $this->redirectToIndex($products->count().' products marked as '.$status);
    }

    /**
     * @return array<string, mixed>
     */
    private function rules(?Product $product = null): array
    {
        return [
            'name' => ['required', 'string', 'max:180'],
            'sku' => ['required', 'string', 'max:60', Rule::unique('products', 'sku')->ignore($product?->id)],
            'category_id' => ['required', 'integer', 'exists:categories,id'],
            'price' => ['required', 'numeric', 'min:0'],
            'sale_price' => ['nullable', 'numeric', 'min:0'],
            'stock' => ['required', 'integer', 'min:0'],
            'low_stock_threshold' => ['nullable', 'integer', 'min:0'],
            'status' => ['required', Rule::in(['active', 'draft', 'inactive'])],
            'description' => ['nullable', 'string', 'max:2000'],
            'image' => ['nullable', 'image', 'max:4096'],
            'product_id' => ['nullable', 'integer'],
            'intent' => ['nullable', 'string'],
        ];
    }

    private function storeImage(Request $request, string $sku): ?string
    {
        if (! $request->hasFile('image')) {
            return null;
        }

        $directory = public_path('images/uploads');

        if (! is_dir($directory)) {
            mkdir($directory, 0755, true);
        }

        $file = $request->file('image');
        $filename = strtolower(preg_replace('/[^a-z0-9]+/i', '-', $sku)).'-'.time().'.'.$file->getClientOriginalExtension();
        $file->move($directory, $filename);

        return 'images/uploads/'.$filename;
    }

    private function deleteImage(?string $path): void
    {
        if (! $path || str_starts_with($path, 'images/products/')) {
            return;
        }

        $fullPath = public_path($path);

        if (is_file($fullPath)) {
            @unlink($fullPath);
        }
    }

    private function redirectToIndex(string $title)
    {
        return redirect()
            ->route('products.index')
            ->with('success', [
                'title' => $title,
                'message' => 'Changes synchronized to multi-channel inventory',
            ]);
    }
}
