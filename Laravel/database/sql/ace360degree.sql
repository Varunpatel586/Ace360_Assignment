-- ============================================================================
-- Ace360degree Enterprise Suite — MySQL schema + demo catalog
-- Open in MySQL Workbench: File > Open SQL Script, then click Execute (lightning).
-- Creates the database, three catalog tables and seeds the 28 demo products.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS `ace360degree` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `ace360degree`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `channels`;
DROP TABLE IF EXISTS `migrations`;

-- ----------------------------------------------------------------------------
-- categories
-- ----------------------------------------------------------------------------
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- products
-- ----------------------------------------------------------------------------
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock` int unsigned NOT NULL DEFAULT 0,
  `low_stock_threshold` int unsigned NOT NULL DEFAULT 10,
  `lead_time_days` smallint unsigned NOT NULL DEFAULT 5,
  `reorder_quantity` int unsigned NOT NULL DEFAULT 50,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_status_index` (`status`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- channels (store channel sync card)
-- ----------------------------------------------------------------------------
CREATE TABLE `channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pos',
  `status_label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Online',
  `status_tone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `sync_percent` tinyint unsigned NOT NULL DEFAULT 100,
  `last_ping_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` smallint unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------------------------------------------------------
-- migrations bookkeeping (so "php artisan migrate" stays in sync with this schema)
-- ----------------------------------------------------------------------------
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`migration`, `batch`) VALUES
  ('0001_01_01_000000_create_users_table', 1),
  ('0001_01_01_000001_create_cache_table', 1),
  ('0001_01_01_000002_create_jobs_table', 1),
  ('2026_11_17_000001_create_categories_table', 1),
  ('2026_11_17_000002_create_products_table', 1),
  ('2026_11_17_000003_create_channels_table', 1);

-- ----------------------------------------------------------------------------
-- demo data: categories
-- ----------------------------------------------------------------------------
INSERT INTO `categories` (`id`, `name`, `slug`, `code`, `sort_order`, `created_at`, `updated_at`) VALUES
  (1, 'Apparel', 'apparel', 'APP', 0, '2026-11-17 14:10:47', '2026-11-17 14:10:47'),
  (2, 'Electronics', 'electronics', 'ELE', 1, '2026-11-17 14:10:47', '2026-11-17 14:10:47'),
  (3, 'Home & Living', 'home-living', 'HOM', 2, '2026-11-17 14:10:47', '2026-11-17 14:10:47'),
  (4, 'Accessories', 'accessories', 'ACC', 3, '2026-11-17 14:10:47', '2026-11-17 14:10:47');

-- ----------------------------------------------------------------------------
-- demo data: products (28 SKUs)
-- ----------------------------------------------------------------------------
INSERT INTO `products` (`id`, `category_id`, `name`, `sku`, `price`, `sale_price`, `stock`, `low_stock_threshold`, `lead_time_days`, `reorder_quantity`, `status`, `description`, `image_path`, `created_at`, `updated_at`) VALUES
  (1, 1, 'Classic Cotton T-Shirt', 'APP-TSH-001', 24.99, NULL, 142, 15, 4, 80, 'active', 'Heavyweight 240 GSM organic cotton tee with a relaxed unisex fit and reinforced collar.', 'images/products/tshirt-box.svg', '2026-11-08 14:16:12', '2026-11-08 14:16:12'),
  (2, 1, 'Slim-Fit Denim Jeans', 'APP-JNS-082', 59.5, NULL, 85, 12, 6, 60, 'active', 'Mid-rise stretch denim with a tapered leg, garment-washed for a lived-in finish.', 'images/products/jeans.svg', '2026-10-18 14:16:12', '2026-10-18 14:16:12'),
  (3, 2, 'Ergonomic Wireless Mouse', 'ELE-MOU-019', 39.99, 34.99, 19, 20, 3, 50, 'active', 'Sculpted 2.4 GHz wireless mouse with silent switches and a 12-month battery life.', 'images/products/mouse.svg', '2026-10-06 14:16:12', '2026-10-06 14:16:12'),
  (4, 3, 'Matte Ceramic Coffee Mug', 'HOM-MUG-104', 14, NULL, 0, 10, 7, 100, 'inactive', 'Stoneware mug with a matte glaze and comfortable oversized handle. 350 ml.', 'images/products/mug.svg', '2026-09-24 14:16:12', '2026-09-24 14:16:12'),
  (5, 3, 'Minimalist LED Desk Lamp', 'HOM-LMP-045', 48, NULL, 64, 12, 5, 40, 'active', 'Dimmable LED task lamp with three colour temperatures and a weighted aluminium base.', 'images/products/lamp.svg', '2026-09-12 14:16:12', '2026-09-12 14:16:12'),
  (6, 2, 'Wireless Noise-Cancelling Headphones', 'ELE-HPH-2024', 199.99, 149.99, 150, 15, 5, 60, 'active', 'High-fidelity 40mm drivers deliver deep acoustic clarity and active 35dB hybrid noise cancellation with 40-hour continuous battery lifespan.', NULL, '2026-07-30 14:16:12', '2026-07-30 14:16:12'),
  (7, 1, 'Merino Wool Crew Sweater', 'APP-SWT-118', 89, NULL, 46, 10, 9, 35, 'active', 'Fine-gauge extra-fine merino knit with a ribbed crew neckline.', NULL, '2026-07-28 14:16:12', '2026-07-28 14:16:12'),
  (8, 1, 'Canvas Field Jacket', 'APP-JKT-221', 129, NULL, 32, 8, 10, 25, 'active', 'Water-repellent 10 oz canvas jacket with four utility pockets.', NULL, '2026-07-26 14:16:12', '2026-07-26 14:16:12'),
  (9, 1, 'Performance Running Shorts', 'APP-SHT-330', 34, NULL, 118, 20, 6, 70, 'active', 'Five-inch inseam training shorts with a zip back pocket and moisture-wicking liner.', NULL, '2026-07-24 14:16:12', '2026-07-24 14:16:12'),
  (10, 1, 'Vintage Wash Denim Jacket', 'APP-JKT-412', 96.5, NULL, 21, 8, 8, 24, 'active', 'Classic trucker silhouette in a stonewashed mid-weight denim.', NULL, '2026-07-22 14:16:12', '2026-07-22 14:16:12'),
  (11, 4, 'Classic Leather Belt', 'ACC-BLT-005', 39, NULL, 74, 15, 7, 40, 'active', 'Full-grain leather belt with a brushed nickel buckle.', NULL, '2026-07-20 14:16:12', '2026-07-20 14:16:12'),
  (12, 3, 'Stainless Travel Tumbler', 'HOM-TMB-072', 27.5, NULL, 96, 15, 5, 60, 'active', 'Double-wall vacuum insulated tumbler that keeps drinks cold for 18 hours.', NULL, '2026-07-18 14:16:12', '2026-07-18 14:16:12'),
  (13, 3, 'Ceramic Planter Set', 'HOM-PLT-118', 42, NULL, 8, 6, 12, 45, 'active', 'Set of three glazed planters with drainage trays in graduated sizes.', NULL, '2026-07-16 14:16:12', '2026-07-16 14:16:12'),
  (14, 3, 'Linen Throw Blanket', 'HOM-THR-233', 64, NULL, 27, 10, 9, 30, 'active', 'Stonewashed French linen throw with a fringed hem, 130 x 170 cm.', NULL, '2026-07-14 14:16:12', '2026-07-14 14:16:12'),
  (15, 3, 'Bamboo Cutting Board', 'HOM-CUT-301', 29, NULL, 55, 10, 4, 40, 'active', 'End-grain bamboo board with a juice groove and side handles.', NULL, '2026-07-12 14:16:12', '2026-07-12 14:16:12'),
  (16, 3, 'Aroma Diffuser', 'HOM-DFR-044', 54, NULL, 0, 10, 11, 35, 'draft', 'Ultrasonic essential oil diffuser with a 300 ml tank and warm light ring.', NULL, '2026-07-10 14:16:12', '2026-07-10 14:16:12'),
  (17, 2, '4K Action Camera', 'ELE-CAM-511', 249, NULL, 12, 10, 14, 20, 'active', '60 fps 4K action camera with electronic stabilisation and a waterproof housing.', NULL, '2026-07-08 14:16:12', '2026-07-08 14:16:12'),
  (18, 2, 'USB-C Fast Charger 65W', 'ELE-CHG-208', 44.99, NULL, 210, 25, 6, 90, 'active', 'Compact GaN charger with two USB-C ports and one USB-A port.', NULL, '2026-07-06 14:16:12', '2026-07-06 14:16:12'),
  (19, 2, 'Mechanical Keyboard', 'ELE-KBD-117', 119, NULL, 38, 10, 8, 30, 'active', 'Hot-swappable 75% keyboard with tactile switches and per-key backlighting.', NULL, '2026-07-04 14:16:12', '2026-07-04 14:16:12'),
  (20, 2, 'Noise Isolating Earbuds', 'ELE-EBD-330', 79, NULL, 0, 10, 10, 40, 'inactive', 'In-ear monitors with memory foam tips and a braided detachable cable.', NULL, '2026-07-02 14:16:12', '2026-07-02 14:16:12'),
  (21, 2, 'Portable SSD 1TB', 'ELE-SSD-064', 129, NULL, 63, 12, 7, 35, 'active', 'Pocket-sized NVMe SSD with 1,050 MB/s transfers and USB-C connectivity.', NULL, '2026-06-30 14:16:12', '2026-06-30 14:16:12'),
  (22, 2, 'Smart Fitness Band', 'ELE-BND-902', 69, NULL, 44, 15, 9, 45, 'active', 'AMOLED fitness tracker with heart-rate,SpO2 and 14-day battery.', NULL, '2026-06-28 14:16:12', '2026-06-28 14:16:12'),
  (23, 4, 'Canvas Tote Bag', 'ACC-TOT-019', 22, NULL, 188, 30, 5, 80, 'active', 'Heavy cotton canvas tote with an internal zip pocket and reinforced handles.', NULL, '2026-06-26 14:16:12', '2026-06-26 14:16:12'),
  (24, 4, 'Minimalist Leather Wallet', 'ACC-WLT-077', 49, NULL, 66, 12, 7, 35, 'active', 'Slim bifold wallet in vegetable-tanned leather with RFID shielding.', NULL, '2026-06-24 14:16:12', '2026-06-24 14:16:12'),
  (25, 4, 'Polarized Sunglasses', 'ACC-SUN-145', 89, NULL, 23, 10, 8, 25, 'active', 'Acetate frames with polarized CR-39 lenses and UV400 protection.', NULL, '2026-06-22 14:16:12', '2026-06-22 14:16:12'),
  (26, 4, 'Wool Beanie', 'ACC-BNE-260', 26, NULL, 91, 20, 6, 50, 'active', 'Rib-knit lambswool beanie with a folded cuff.', NULL, '2026-06-20 14:16:12', '2026-06-20 14:16:12'),
  (27, 4, 'Corduroy Cap', 'ACC-CAP-311', 31, NULL, 0, 10, 9, 30, 'inactive', 'Six-panel corduroy cap with an adjustable brass strap.', NULL, '2026-06-18 14:16:12', '2026-06-18 14:16:12'),
  (28, 1, 'Cotton Lounge Pants', 'APP-PNT-402', 44, NULL, 57, 12, 7, 40, 'draft', 'Brushed cotton jersey pants with an elastic drawcord waist.', NULL, '2026-06-16 14:16:12', '2026-06-16 14:16:12');

-- ----------------------------------------------------------------------------
-- demo data: channels
-- ----------------------------------------------------------------------------
INSERT INTO `channels` (`id`, `name`, `icon`, `status_label`, `status_tone`, `sync_percent`, `last_ping_at`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
  (1, 'Shopify Flagship', 'shopify', '100% Synced', 'success', 100, '2026-11-17 14:14:12', 1, 0, '2026-11-17 14:10:48', '2026-11-17 14:16:12'),
  (2, 'Amazon Marketplace', 'amazon', '100% Synced', 'success', 100, '2026-11-17 14:11:12', 1, 1, '2026-11-17 14:10:48', '2026-11-17 14:16:12'),
  (3, 'POS Terminal Hub (Austin)', 'pos', 'Online', 'success', 100, '2026-11-17 14:16:12', 1, 2, '2026-11-17 14:10:48', '2026-11-17 14:16:12');

SET FOREIGN_KEY_CHECKS = 1;
