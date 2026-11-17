<section class="stats">
    <article class="stat">
        <div class="stat-main">
            <p class="stat-label">Total Products</p>
            <p class="stat-value">{{ number_format($stats['total']) }}</p>
            <p class="stat-sub is-green">
                <x-icon name="trend-up" />
                <span>{{ $stats['growth'] }}% from last month</span>
            </p>
        </div>
        <span class="stat-icon tone-blue"><x-icon name="clipboard-list" /></span>
    </article>

    <article class="stat">
        <div class="stat-main">
            <p class="stat-label">Active Products</p>
            <p class="stat-value">{{ number_format($stats['active']) }}</p>
            <p class="stat-sub">
                <span class="sub-dot"></span>
                <span>{{ $stats['coverage'] }}% listing coverage</span>
            </p>
        </div>
        <span class="stat-icon tone-green"><x-icon name="check-circle" /></span>
    </article>

    <article class="stat">
        <div class="stat-main">
            <p class="stat-label">Low Stock Alert</p>
            <p class="stat-value is-danger">{{ number_format($stats['low_stock']) }}</p>
            <p class="stat-sub is-danger">
                <x-icon name="alert-triangle" />
                <span>Needs urgent restock</span>
            </p>
        </div>
        <span class="stat-icon tone-red"><x-icon name="cart" /></span>
    </article>

    <article class="stat">
        <div class="stat-main">
            <p class="stat-label">Out of Stock</p>
            <p class="stat-value">{{ number_format($stats['out_of_stock']) }}</p>
            <p class="stat-sub is-muted">
                <x-icon name="clock" />
                <span>Hidden from storefront</span>
            </p>
        </div>
        <span class="stat-icon tone-slate"><x-icon name="cart" /></span>
    </article>
</section>
