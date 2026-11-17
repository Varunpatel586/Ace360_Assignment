@php
    $perPage = (int) ($filters['per_page'] ?? 5);
@endphp

<div class="table-footer">
    <div class="footer-left">
        <span class="result-count">
            Showing {{ $products->firstItem() ?? 0 }} to {{ $products->lastItem() ?? 0 }} of {{ $products->total() }} products
        </span>
        <label class="rows-per">
            <span>Rows per page:</span>
            <select name="per_page" form="filterForm" data-autosubmit aria-label="Rows per page">
                @foreach ([5, 10, 25, 50] as $size)
                    <option value="{{ $size }}" @selected($perPage === $size)>{{ $size }}</option>
                @endforeach
            </select>
        </label>
    </div>

    {{ $products->links() }}
</div>
