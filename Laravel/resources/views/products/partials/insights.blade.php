@php
    $barColours = ['c-blue', 'c-green', 'c-slate', 'c-gray'];
    $maxPercent = max(1, (float) $breakdown->max('percent'));
@endphp

<section class="insights">
    <article class="panel">
        <div class="panel-head">
            <h2 class="panel-title">Critical Stock Replenishment</h2>
            <span class="badge badge-red">Action<br>Required</span>
        </div>

        <p class="panel-copy">
            {{ $critical->count() }} SKUs have hit safety buffers and require purchase order dispatch to primary vendors.
        </p>

        <div class="divider"></div>

        <div class="replenish-list">
            @forelse ($critical as $item)
                <div class="replenish">
                    <span class="replenish-icon {{ $loop->first ? 'is-alert' : '' }}">
                        <x-icon :name="$loop->first ? 'alert-circle' : 'clipboard-list'" />
                    </span>
                    <div class="replenish-body">
                        <div class="replenish-name">{{ $item->name }}</div>
                        <div class="replenish-meta">
                            {{ $item->sku }} &bull; Lead Time: {{ $item->lead_time_days }} days
                        </div>
                    </div>
                    <span class="reorder-chip">Reorder<br>{{ $item->reorder_quantity }}</span>
                </div>
            @empty
                <p class="panel-copy">All SKUs are above their safety buffers.</p>
            @endforelse
        </div>

        <a href="#" class="panel-link">
            <span>View supplier order pipeline</span>
            <x-icon name="arrow-right" />
        </a>
    </article>

    <article class="panel">
        <div class="panel-head">
            <h2 class="panel-title">Catalog SKU Breakdown</h2>
            <span class="panel-total">Total: {{ number_format($stats['total']) }}</span>
        </div>

        <div class="divider"></div>

        <div class="sku-list">
            @foreach ($breakdown as $row)
                <div class="sku-row">
                    <div class="sku-top">
                        <span>{{ $row['name'] }}</span>
                        <span class="sku-count">{{ number_format($row['count']) }} SKUs ({{ $row['percent'] }}%)</span>
                    </div>
                    <span class="sku-bar">
                        <span class="{{ $barColours[$loop->index % 4] }}"
                              style="width: {{ min(100, round($row['percent'] / $maxPercent * 88, 1)) }}%"></span>
                    </span>
                </div>
            @endforeach
        </div>

        <div class="panel-foot">
            <span>Synchronized with MySQL replica db</span>
            <span class="live"><span class="live-dot"></span>Live</span>
        </div>
    </article>

    <article class="panel">
        <div class="panel-head">
            <h2 class="panel-title">Store Channel Sync</h2>
            <span class="badge badge-green">All Active</span>
        </div>

        <div class="divider"></div>

        <div class="channel-list">
            @foreach ($channels as $channel)
                <div class="channel">
                    <span class="channel-icon"><x-icon :name="$channel->icon" /></span>
                    <div class="channel-body">
                        <div class="channel-name">{{ $channel->name }}</div>
                        <div class="channel-meta">Last ping: {{ $channel->lastPingLabel() }}</div>
                    </div>
                    <span class="channel-status">{{ $channel->status_label }}</span>
                </div>
            @endforeach
        </div>

        <form method="POST" action="{{ route('channels.sync') }}" class="panel-actions">
            @csrf
            <button type="submit" class="btn-ghost">
                <x-icon name="refresh" />
                <span>Trigger Full Sync</span>
            </button>
        </form>
    </article>
</section>
