<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Channel;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class CatalogSeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            ['name' => 'Apparel', 'code' => 'APP'],
            ['name' => 'Electronics', 'code' => 'ELE'],
            ['name' => 'Home & Living', 'code' => 'HOM'],
            ['name' => 'Accessories', 'code' => 'ACC'],
        ];

        foreach ($categories as $index => $category) {
            Category::updateOrCreate(
                ['slug' => Str::slug($category['name'])],
                $category + ['sort_order' => $index]
            );
        }

        $categoryIds = Category::pluck('id', 'name');

        foreach ($this->products() as $index => $row) {
            $product = Product::updateOrCreate(
                ['sku' => $row['sku']],
                [
                    'name' => $row['name'],
                    'category_id' => $categoryIds[$row['category']] ?? null,
                    'price' => $row['price'],
                    'sale_price' => $row['sale'],
                    'stock' => $row['stock'],
                    'low_stock_threshold' => $row['threshold'],
                    'lead_time_days' => $row['lead'],
                    'reorder_quantity' => $row['reorder'],
                    'status' => $row['status'],
                    'description' => $row['description'],
                    'image_path' => $row['image'] ? 'images/products/'.$row['image'].'.svg' : null,
                ]
            );

            // The five featured SKUs stay newest so they lead the default listing.
            $daysAgo = $index === 0 ? 9 : ($index < 5 ? 18 + $index * 12 : 100 + $index * 2);
            $timestamp = now()->subDays($daysAgo);
            $product->forceFill(['created_at' => $timestamp, 'updated_at' => $timestamp])->save();
        }

        $channels = [
            ['name' => 'Shopify Flagship', 'icon' => 'shopify', 'status_label' => '100% Synced', 'sync_percent' => 100, 'minutes_ago' => 2],
            ['name' => 'Amazon Marketplace', 'icon' => 'amazon', 'status_label' => '100% Synced', 'sync_percent' => 100, 'minutes_ago' => 5],
            ['name' => 'POS Terminal Hub (Austin)', 'icon' => 'pos', 'status_label' => 'Online', 'sync_percent' => 100, 'minutes_ago' => 0],
        ];

        foreach ($channels as $index => $channel) {
            Channel::updateOrCreate(
                ['name' => $channel['name']],
                [
                    'icon' => $channel['icon'],
                    'status_label' => $channel['status_label'],
                    'status_tone' => 'success',
                    'sync_percent' => $channel['sync_percent'],
                    'last_ping_at' => now()->subMinutes($channel['minutes_ago']),
                    'is_active' => true,
                    'sort_order' => $index,
                ]
            );
        }
    }

    /**
     * @return array<int, array<string, mixed>>
     */
    private function products(): array
    {
        return [
            ['name' => 'Classic Cotton T-Shirt', 'sku' => 'APP-TSH-001', 'category' => 'Apparel', 'price' => 24.99, 'sale' => null, 'stock' => 142, 'threshold' => 15, 'status' => 'active', 'image' => 'tshirt-box', 'description' => 'Heavyweight 240 GSM organic cotton tee with a relaxed unisex fit and reinforced collar.', 'lead' => 4, 'reorder' => 80],
            ['name' => 'Slim-Fit Denim Jeans', 'sku' => 'APP-JNS-082', 'category' => 'Apparel', 'price' => 59.50, 'sale' => null, 'stock' => 85, 'threshold' => 12, 'status' => 'active', 'image' => 'jeans', 'description' => 'Mid-rise stretch denim with a tapered leg, garment-washed for a lived-in finish.', 'lead' => 6, 'reorder' => 60],
            ['name' => 'Ergonomic Wireless Mouse', 'sku' => 'ELE-MOU-019', 'category' => 'Electronics', 'price' => 39.99, 'sale' => 34.99, 'stock' => 19, 'threshold' => 20, 'status' => 'active', 'image' => 'mouse', 'description' => 'Sculpted 2.4 GHz wireless mouse with silent switches and a 12-month battery life.', 'lead' => 3, 'reorder' => 50],
            ['name' => 'Matte Ceramic Coffee Mug', 'sku' => 'HOM-MUG-104', 'category' => 'Home & Living', 'price' => 14.00, 'sale' => null, 'stock' => 0, 'threshold' => 10, 'status' => 'inactive', 'image' => 'mug', 'description' => 'Stoneware mug with a matte glaze and comfortable oversized handle. 350 ml.', 'lead' => 7, 'reorder' => 100],
            ['name' => 'Minimalist LED Desk Lamp', 'sku' => 'HOM-LMP-045', 'category' => 'Home & Living', 'price' => 48.00, 'sale' => null, 'stock' => 64, 'threshold' => 12, 'status' => 'active', 'image' => 'lamp', 'description' => 'Dimmable LED task lamp with three colour temperatures and a weighted aluminium base.', 'lead' => 5, 'reorder' => 40],
            ['name' => 'Wireless Noise-Cancelling Headphones', 'sku' => 'ELE-HPH-2024', 'category' => 'Electronics', 'price' => 199.99, 'sale' => 149.99, 'stock' => 150, 'threshold' => 15, 'status' => 'active', 'image' => null, 'description' => 'High-fidelity 40mm drivers deliver deep acoustic clarity and active 35dB hybrid noise cancellation with 40-hour continuous battery lifespan.', 'lead' => 5, 'reorder' => 60],
            ['name' => 'Merino Wool Crew Sweater', 'sku' => 'APP-SWT-118', 'category' => 'Apparel', 'price' => 89.00, 'sale' => null, 'stock' => 46, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => 'Fine-gauge extra-fine merino knit with a ribbed crew neckline.', 'lead' => 9, 'reorder' => 35],
            ['name' => 'Canvas Field Jacket', 'sku' => 'APP-JKT-221', 'category' => 'Apparel', 'price' => 129.00, 'sale' => null, 'stock' => 32, 'threshold' => 8, 'status' => 'active', 'image' => null, 'description' => 'Water-repellent 10 oz canvas jacket with four utility pockets.', 'lead' => 10, 'reorder' => 25],
            ['name' => 'Performance Running Shorts', 'sku' => 'APP-SHT-330', 'category' => 'Apparel', 'price' => 34.00, 'sale' => null, 'stock' => 118, 'threshold' => 20, 'status' => 'active', 'image' => null, 'description' => 'Five-inch inseam training shorts with a zip back pocket and moisture-wicking liner.', 'lead' => 6, 'reorder' => 70],
            ['name' => 'Vintage Wash Denim Jacket', 'sku' => 'APP-JKT-412', 'category' => 'Apparel', 'price' => 96.50, 'sale' => null, 'stock' => 21, 'threshold' => 8, 'status' => 'active', 'image' => null, 'description' => 'Classic trucker silhouette in a stonewashed mid-weight denim.', 'lead' => 8, 'reorder' => 24],
            ['name' => 'Classic Leather Belt', 'sku' => 'ACC-BLT-005', 'category' => 'Accessories', 'price' => 39.00, 'sale' => null, 'stock' => 74, 'threshold' => 15, 'status' => 'active', 'image' => null, 'description' => 'Full-grain leather belt with a brushed nickel buckle.', 'lead' => 7, 'reorder' => 40],
            ['name' => 'Stainless Travel Tumbler', 'sku' => 'HOM-TMB-072', 'category' => 'Home & Living', 'price' => 27.50, 'sale' => null, 'stock' => 96, 'threshold' => 15, 'status' => 'active', 'image' => null, 'description' => 'Double-wall vacuum insulated tumbler that keeps drinks cold for 18 hours.', 'lead' => 5, 'reorder' => 60],
            ['name' => 'Ceramic Planter Set', 'sku' => 'HOM-PLT-118', 'category' => 'Home & Living', 'price' => 42.00, 'sale' => null, 'stock' => 8, 'threshold' => 6, 'status' => 'active', 'image' => null, 'description' => 'Set of three glazed planters with drainage trays in graduated sizes.', 'lead' => 12, 'reorder' => 45],
            ['name' => 'Linen Throw Blanket', 'sku' => 'HOM-THR-233', 'category' => 'Home & Living', 'price' => 64.00, 'sale' => null, 'stock' => 27, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => 'Stonewashed French linen throw with a fringed hem, 130 x 170 cm.', 'lead' => 9, 'reorder' => 30],
            ['name' => 'Bamboo Cutting Board', 'sku' => 'HOM-CUT-301', 'category' => 'Home & Living', 'price' => 29.00, 'sale' => null, 'stock' => 55, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => 'End-grain bamboo board with a juice groove and side handles.', 'lead' => 4, 'reorder' => 40],
            ['name' => 'Aroma Diffuser', 'sku' => 'HOM-DFR-044', 'category' => 'Home & Living', 'price' => 54.00, 'sale' => null, 'stock' => 0, 'threshold' => 10, 'status' => 'draft', 'image' => null, 'description' => 'Ultrasonic essential oil diffuser with a 300 ml tank and warm light ring.', 'lead' => 11, 'reorder' => 35],
            ['name' => '4K Action Camera', 'sku' => 'ELE-CAM-511', 'category' => 'Electronics', 'price' => 249.00, 'sale' => null, 'stock' => 12, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => '60 fps 4K action camera with electronic stabilisation and a waterproof housing.', 'lead' => 14, 'reorder' => 20],
            ['name' => 'USB-C Fast Charger 65W', 'sku' => 'ELE-CHG-208', 'category' => 'Electronics', 'price' => 44.99, 'sale' => null, 'stock' => 210, 'threshold' => 25, 'status' => 'active', 'image' => null, 'description' => 'Compact GaN charger with two USB-C ports and one USB-A port.', 'lead' => 6, 'reorder' => 90],
            ['name' => 'Mechanical Keyboard', 'sku' => 'ELE-KBD-117', 'category' => 'Electronics', 'price' => 119.00, 'sale' => null, 'stock' => 38, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => 'Hot-swappable 75% keyboard with tactile switches and per-key backlighting.', 'lead' => 8, 'reorder' => 30],
            ['name' => 'Noise Isolating Earbuds', 'sku' => 'ELE-EBD-330', 'category' => 'Electronics', 'price' => 79.00, 'sale' => null, 'stock' => 0, 'threshold' => 10, 'status' => 'inactive', 'image' => null, 'description' => 'In-ear monitors with memory foam tips and a braided detachable cable.', 'lead' => 10, 'reorder' => 40],
            ['name' => 'Portable SSD 1TB', 'sku' => 'ELE-SSD-064', 'category' => 'Electronics', 'price' => 129.00, 'sale' => null, 'stock' => 63, 'threshold' => 12, 'status' => 'active', 'image' => null, 'description' => 'Pocket-sized NVMe SSD with 1,050 MB/s transfers and USB-C connectivity.', 'lead' => 7, 'reorder' => 35],
            ['name' => 'Smart Fitness Band', 'sku' => 'ELE-BND-902', 'category' => 'Electronics', 'price' => 69.00, 'sale' => null, 'stock' => 44, 'threshold' => 15, 'status' => 'active', 'image' => null, 'description' => 'AMOLED fitness tracker with heart-rate,SpO2 and 14-day battery.', 'lead' => 9, 'reorder' => 45],
            ['name' => 'Canvas Tote Bag', 'sku' => 'ACC-TOT-019', 'category' => 'Accessories', 'price' => 22.00, 'sale' => null, 'stock' => 188, 'threshold' => 30, 'status' => 'active', 'image' => null, 'description' => 'Heavy cotton canvas tote with an internal zip pocket and reinforced handles.', 'lead' => 5, 'reorder' => 80],
            ['name' => 'Minimalist Leather Wallet', 'sku' => 'ACC-WLT-077', 'category' => 'Accessories', 'price' => 49.00, 'sale' => null, 'stock' => 66, 'threshold' => 12, 'status' => 'active', 'image' => null, 'description' => 'Slim bifold wallet in vegetable-tanned leather with RFID shielding.', 'lead' => 7, 'reorder' => 35],
            ['name' => 'Polarized Sunglasses', 'sku' => 'ACC-SUN-145', 'category' => 'Accessories', 'price' => 89.00, 'sale' => null, 'stock' => 23, 'threshold' => 10, 'status' => 'active', 'image' => null, 'description' => 'Acetate frames with polarized CR-39 lenses and UV400 protection.', 'lead' => 8, 'reorder' => 25],
            ['name' => 'Wool Beanie', 'sku' => 'ACC-BNE-260', 'category' => 'Accessories', 'price' => 26.00, 'sale' => null, 'stock' => 91, 'threshold' => 20, 'status' => 'active', 'image' => null, 'description' => 'Rib-knit lambswool beanie with a folded cuff.', 'lead' => 6, 'reorder' => 50],
            ['name' => 'Corduroy Cap', 'sku' => 'ACC-CAP-311', 'category' => 'Accessories', 'price' => 31.00, 'sale' => null, 'stock' => 0, 'threshold' => 10, 'status' => 'inactive', 'image' => null, 'description' => 'Six-panel corduroy cap with an adjustable brass strap.', 'lead' => 9, 'reorder' => 30],
            ['name' => 'Cotton Lounge Pants', 'sku' => 'APP-PNT-402', 'category' => 'Apparel', 'price' => 44.00, 'sale' => null, 'stock' => 57, 'threshold' => 12, 'status' => 'draft', 'image' => null, 'description' => 'Brushed cotton jersey pants with an elastic drawcord waist.', 'lead' => 7, 'reorder' => 40],
        ];
    }
}
