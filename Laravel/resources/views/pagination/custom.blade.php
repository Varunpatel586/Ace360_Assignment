@if ($paginator->hasPages())
    <nav class="pagination" role="navigation" aria-label="Pagination">
        @if ($paginator->onFirstPage())
            <span class="pg-btn is-disabled">Previous</span>
        @else
            <a class="pg-btn" href="{{ $paginator->previousPageUrl() }}" rel="prev">Previous</a>
        @endif

        @foreach ($elements as $element)
            @if (is_string($element))
                <span class="pg-gap">{{ $element }}</span>
            @endif

            @if (is_array($element))
                @foreach ($element as $page => $url)
                    @if ($page == $paginator->currentPage())
                        <span class="pg-num is-current" aria-current="page">{{ $page }}</span>
                    @else
                        <a class="pg-num" href="{{ $url }}">{{ $page }}</a>
                    @endif
                @endforeach
            @endif
        @endforeach

        @if ($paginator->hasMorePages())
            <a class="pg-btn" href="{{ $paginator->nextPageUrl() }}" rel="next">Next</a>
        @else
            <span class="pg-btn is-disabled">Next</span>
        @endif
    </nav>
@endif
