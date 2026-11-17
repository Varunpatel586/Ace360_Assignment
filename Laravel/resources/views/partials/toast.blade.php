@if (session('success'))
    @php($toast = session('success'))
    <div class="toast" id="appToast" role="status" aria-live="polite">
        <span class="toast-icon"><x-icon name="check-circle" /></span>
        <div class="toast-body">
            <p class="toast-title">{{ is_array($toast) ? ($toast['title'] ?? '') : $toast }}</p>
            @if (is_array($toast) && ! empty($toast['message']))
                <p class="toast-sub">{{ $toast['message'] }}</p>
            @endif
        </div>
        <button type="button" class="toast-close" data-toast-close aria-label="Dismiss notification">
            <x-icon name="x" />
        </button>
    </div>
@endif
