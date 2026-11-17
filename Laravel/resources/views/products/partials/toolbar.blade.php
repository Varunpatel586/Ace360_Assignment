@php
    $status = $filters['status'] ?? '';
    $sort = $filters['sort'] ?? 'latest';
@endphp

<div class="toolbar">
    <div class="toolbar-row">
        <label class="search-wrap">
            <x-icon name="search" class="search-icon" />
            <input class="control" type="search" name="q" form="filterForm" value="{{ $filters['q'] ?? '' }}"
                   placeholder="Filter by SKU or title..." aria-label="Filter products">
        </label>

        <select class="control select-category" name="category" form="filterForm" data-autosubmit aria-label="Filter by category">
            <option value="">All Categories</option>
            @foreach ($categories as $category)
                <option value="{{ $category->id }}" @selected((string) ($filters['category'] ?? '') === (string) $category->id)>
                    {{ $category->name }}
                </option>
            @endforeach
        </select>

        <select class="control select-status" name="status" form="filterForm" data-autosubmit aria-label="Filter by status">
            <option value="">All Status</option>
            <option value="active" @selected($status === 'active')>Active</option>
            <option value="draft" @selected($status === 'draft')>Draft</option>
            <option value="inactive" @selected($status === 'inactive')>Inactive</option>
        </select>

        <div class="toolbar-actions">
            <select class="control bulk-select" name="bulk_action" form="bulkForm" data-bulk-select aria-label="Bulk actions">
                <option value="">Bulk Actions</option>
                <option value="activate">Activate selected</option>
                <option value="deactivate">Deactivate selected</option>
                <option value="delete">Delete selected</option>
            </select>

            <button type="button" class="btn-primary" data-product-add>
                <x-icon name="plus" />
                <span>Add Product</span>
            </button>
        </div>
    </div>

    <div class="toolbar-row">
        <select class="control sort-select" name="sort" form="filterForm" data-autosubmit aria-label="Sort products">
            <option value="latest" @selected($sort === 'latest')>Sort by: Latest</option>
            <option value="oldest" @selected($sort === 'oldest')>Sort by: Oldest</option>
            <option value="name" @selected($sort === 'name')>Sort by: Name A–Z</option>
            <option value="price_low" @selected($sort === 'price_low')>Sort by: Price low to high</option>
            <option value="price_high" @selected($sort === 'price_high')>Sort by: Price high to low</option>
            <option value="stock" @selected($sort === 'stock')>Sort by: Stock level</option>
        </select>
    </div>
</div>
