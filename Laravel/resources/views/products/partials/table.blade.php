@php
    $pillClasses = ['active' => 'success', 'draft' => 'draft', 'inactive' => 'muted'];
@endphp

<div class="table-wrap">
    <table class="data-table">
        <thead>
            <tr>
                <th class="col-check">
                    <input type="checkbox" class="check" data-check-all aria-label="Select all products">
                </th>
                <th class="col-thumb">Thumbnail</th>
                <th>Product Name &amp; SKU</th>
                <th class="col-category">Category</th>
                <th class="col-price">Price</th>
                <th class="col-stock th-right">Inventory / Stock</th>
                <th class="col-status">Status</th>
                <th class="col-actions th-right">Actions</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($products as $product)
                @php
                    $payload = [
                        'id' => $product->id,
                        'name' => $product->name,
                        'sku' => $product->sku,
                        'category_id' => $product->category_id,
                        'category' => $product->category->name ?? 'Uncategorized',
                        'price' => number_format((float) $product->price, 2, '.', ''),
                        'sale_price' => $product->sale_price !== null ? number_format((float) $product->sale_price, 2, '.', '') : '',
                        'stock' => $product->stock,
                        'low_stock_threshold' => $product->low_stock_threshold,
                        'status' => $product->status,
                        'description' => $product->description,
                        'image' => $product->image_path ? asset($product->image_path) : null,
                        'initials' => $product->initials(),
                        'price_display' => $product->formatPrice(),
                        'update_url' => route('products.update', $product),
                        'delete_url' => route('products.destroy', $product),
                    ];
                    $stockClass = $product->stock === 0 ? 'is-empty' : ($product->isLowStock() ? 'is-low' : '');
                @endphp
                <tr>
                    <td class="col-check">
                        <input type="checkbox" class="check" name="ids[]" value="{{ $product->id }}" form="bulkForm"
                               data-row-check aria-label="Select {{ $product->name }}">
                    </td>
                    <td>
                        <span class="thumb">
                            @if ($product->image_path)
                                <img src="{{ asset($product->image_path) }}" alt="{{ $product->name }}">
                            @else
                                <span class="thumb-fallback">{{ $product->initials() }}</span>
                            @endif
                        </span>
                    </td>
                    <td>
                        <div class="product-cell">
                            <div>
                                <div class="product-name">{{ $product->name }}</div>
                                <div class="product-sku">SKU: {{ $product->sku }}</div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="chip">{{ $product->category->name ?? 'Uncategorized' }}</span>
                    </td>
                    <td>
                        <span class="price">{{ $product->formatPrice() }}</span>
                    </td>
                    <td>
                        <div class="stock">
                            <span class="stock-value {{ $stockClass }}">{{ $product->stock }} in stock</span>
                            <span class="stock-bar {{ $stockClass }}">
                                <span style="width: {{ $product->stockLevelPercent() }}%"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <span class="pill {{ $pillClasses[$product->status] ?? 'muted' }}">
                            <span class="dot"></span>{{ ucfirst($product->status) }}
                        </span>
                    </td>
                    <td>
                        <div class="actions">
                            <button type="button" class="icon-btn" title="View {{ $product->name }}"
                                    data-product-view="{{ json_encode($payload) }}">
                                <x-icon name="eye" />
                            </button>
                            <button type="button" class="icon-btn" title="Edit {{ $product->name }}"
                                    data-product-edit="{{ json_encode($payload) }}">
                                <x-icon name="pencil" />
                            </button>
                            <button type="button" class="icon-btn is-danger" title="Delete {{ $product->name }}"
                                    data-product-delete="{{ json_encode($payload) }}">
                                <x-icon name="trash" />
                            </button>
                        </div>
                    </td>
                </tr>
            @empty
                <tr>
                    <td colspan="8" class="empty-cell">No products match the current filters.</td>
                </tr>
            @endforelse
        </tbody>
    </table>
</div>
