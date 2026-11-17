<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Channel extends Model
{
    protected $fillable = [
        'name',
        'icon',
        'status_label',
        'status_tone',
        'sync_percent',
        'last_ping_at',
        'is_active',
        'sort_order',
    ];

    protected $casts = [
        'last_ping_at' => 'datetime',
        'is_active' => 'boolean',
    ];

    public function lastPingLabel(): string
    {
        if (! $this->last_ping_at) {
            return 'Never synced';
        }

        $minutes = (int) $this->last_ping_at->diffInMinutes(now());

        return match (true) {
            $minutes < 1 => 'Just now',
            $minutes < 60 => $minutes.' min'.($minutes === 1 ? '' : 's').' ago',
            $minutes < 1440 => $this->last_ping_at->diffInHours(now()).' hrs ago',
            default => $this->last_ping_at->diffInDays(now()).' days ago',
        };
    }
}
