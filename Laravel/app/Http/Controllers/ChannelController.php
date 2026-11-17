<?php

namespace App\Http\Controllers;

use App\Models\Channel;

class ChannelController extends Controller
{
    public function sync()
    {
        Channel::query()->update([
            'last_ping_at' => now(),
            'status_label' => '100% Synced',
            'status_tone' => 'success',
        ]);

        return redirect()
            ->route('products.index')
            ->with('success', [
                'title' => 'Store channels synchronized',
                'message' => 'Changes synchronized to multi-channel inventory',
            ]);
    }
}
