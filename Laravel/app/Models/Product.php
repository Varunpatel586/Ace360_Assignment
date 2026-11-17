<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'name',
        'sku',
        'price',
        'sale_price',
        'stock',
        'low_stock_threshold',
        'lead_time_days',
        'reorder_quantity',
        'status',
        'description',
        'image_path',
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'sale_price' => 'decimal:2',
        'stock' => 'integer',
        'low_stock_threshold' => 'integer',
        'lead_time_days' => 'integer',
        'reorder_quantity' => 'integer',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function isLowStock(): bool
    {
        return $this->stock > 0 && $this->stock <= $this->low_stock_threshold;
    }

    public function isOutOfStock(): bool
    {
        return $this->stock === 0;
    }

    /**
     * Percentage used by the inventory progress bar in the table.
     */
    public function stockLevelPercent(): int
    {
        return (int) min(100, round($this->stock / 1.8));
    }

    public function formatPrice(): string
    {
        return '$'.number_format((float) $this->price, 2);
    }

    public function initials(): string
    {
        return collect(explode(' ', $this->name))
            ->reject(fn (string $word) => in_array(strtolower($word), ['&', 'the', 'and', '-']))
            ->take(2)
            ->map(fn (string $word) => mb_strtoupper(mb_substr($word, 0, 1)))
            ->implode('');
    }

    public function scopeLowStock(Builder $query): Builder
    {
        return $query->where('stock', '>', 0)->whereColumn('stock', '<=', 'low_stock_threshold');
    }

    public function scopeOutOfStock(Builder $query): Builder
    {
        return $query->where('stock', 0);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', 'active');
    }
}
