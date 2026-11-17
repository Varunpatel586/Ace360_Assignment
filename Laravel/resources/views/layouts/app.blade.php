@php
    $filters = $filters ?? [];
@endphp
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Product List') · Ace360degree Enterprise Suite</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}?v={{ filemtime(public_path('css/app.css')) }}">
</head>
<body>
<div class="app">
    <aside class="sidebar">
        <div class="brand">
            <span class="brand-mark">A3</span>
            <span class="brand-text">
                <strong>Ace360degree</strong>
                <span>ENTERPRISE SUITE</span>
            </span>
        </div>

        <nav class="nav">
            @foreach ([
                ['dashboard', 'Dashboard', false],
                ['package', 'Product Management', true],
                ['store', 'Store Management', false],
                ['cart', 'Orders', false],
                ['users', 'Vendor Management', false],
                ['tag', 'Promotions', false],
                ['megaphone', 'Marketing Management', false],
                ['pos', 'POS', false],
            ] as [$icon, $label, $active])
                <a href="{{ $active ? route('products.index') : '#' }}" class="nav-item {{ $active ? 'is-active' : '' }}">
                    <x-icon :name="$icon" />
                    <span>{{ $label }}</span>
                </a>
            @endforeach
        </nav>

        <div class="sidebar-footer">
            <div class="system-status">
                <x-icon name="check-circle" />
                <span>
                    <strong>System Status</strong>
                    <small>All APIs Operational</small>
                </span>
            </div>
            <a href="#" class="logout">
                <x-icon name="logout" />
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <div class="main">
        <header class="topbar">
            <div class="crumbs">
                <a href="{{ route('products.index') }}">Products</a>
                <span class="crumb-sep">/</span>
                <span class="crumb-current">Product List</span>
            </div>

            <form class="search-top" method="GET" action="{{ route('products.index') }}" role="search">
                <x-icon name="search" class="search-icon" />
                <input type="search" name="q" value="{{ $filters['q'] ?? '' }}" placeholder="Search products or SKU..." aria-label="Search products">
            </form>
        </header>

        <main class="content">
            @yield('content')
        </main>
    </div>
</div>

@include('partials.toast')

@stack('modals')

    <script src="{{ asset('js/app.js') }}?v={{ filemtime(public_path('js/app.js')) }}"></script>
</body>
</html>
