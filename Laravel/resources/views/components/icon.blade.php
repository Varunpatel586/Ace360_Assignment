@props(['name' => 'package'])

@php
    $paths = [
        'dashboard' => '<rect x="3" y="3" width="7" height="7" rx="1.6"/><rect x="14" y="3" width="7" height="7" rx="1.6"/><rect x="14" y="14" width="7" height="7" rx="1.6"/><rect x="3" y="14" width="7" height="7" rx="1.6"/>',
        'package' => '<path d="M21 8v8a2 2 0 0 1-1 1.73l-7 4a2 2 0 0 1-2 0l-7-4A2 2 0 0 1 3 16V8a2 2 0 0 1 1-1.73l7-4a2 2 0 0 1 2 0l7 4A2 2 0 0 1 21 8Z"/><path d="M3.3 7 12 12l8.7-5"/><path d="M12 22V12"/>',
        'store' => '<path d="m3 9 1.8-5h14.4L21 9"/><path d="M3 9h18"/><path d="M5 9v11h14V9"/><path d="M10 20v-5h4v5"/>',
        'cart' => '<circle cx="9" cy="20" r="1.4"/><circle cx="18" cy="20" r="1.4"/><path d="M2.5 3h2.2l2.6 11.2a2 2 0 0 0 2 1.55h8.2a2 2 0 0 0 2-1.6L21 7H6"/>',
        'users' => '<path d="M16 21v-1.8a4 4 0 0 0-4-4H6.5a4 4 0 0 0-4 4V21"/><circle cx="9.2" cy="7.5" r="3.6"/><path d="M21.5 21v-1.8a4 4 0 0 0-3-3.85"/><path d="M16.2 3.9a3.6 3.6 0 0 1 0 7"/>',
        'tag' => '<path d="M20.6 13.4 13.4 20.6a2 2 0 0 1-2.8 0L2.5 12.5V2.5H12.5l8.1 8.1a2 2 0 0 1 0 2.8Z"/><circle cx="7" cy="7" r="1.4"/>',
        'megaphone' => '<path d="m3 11 18-5v12L3 13v-2Z"/><path d="M8 12.5V19a2 2 0 0 0 4 0v-5.5"/>',
        'pos' => '<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M7 9h5"/><path d="M7 13h3"/><path d="M7 17h3"/><path d="M15 9h2"/><path d="M15 13h2"/><path d="M15 17h2"/>',
        'check-circle' => '<circle cx="12" cy="12" r="9.2"/><path d="m8.4 12.2 2.4 2.4 4.8-5"/>',
        'logout' => '<path d="M9.5 21H5.5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><path d="m16 16.5 4.5-4.5L16 7.5"/><path d="M20.5 12H9.5"/>',
        'search' => '<circle cx="11" cy="11" r="7"/><path d="m20.5 20.5-4.2-4.2"/>',
        'clipboard-list' => '<rect x="8" y="2.5" width="8" height="4" rx="1.3"/><path d="M16 4.5h2.2a2 2 0 0 1 2 2v13a2 2 0 0 1-2 2H5.8a2 2 0 0 1-2-2v-13a2 2 0 0 1 2-2H8"/><path d="M8.2 11h7.6"/><path d="M8.2 15h4.8"/>',
        'trend-up' => '<path d="M4 16.5 9 11l3.5 3L20 7.5"/><path d="M15 7.5h5v5"/>',
        'alert-triangle' => '<path d="M10.3 4 2.8 17a2 2 0 0 0 1.7 3h15a2 2 0 0 0 1.7-3L13.7 4a2 2 0 0 0-3.4 0Z"/><path d="M12 9.5v4"/><path d="M12 17h.01"/>',
        'clock' => '<circle cx="12" cy="12" r="9.2"/><path d="M12 7.5V12l3.2 2"/>',
        'plus' => '<path d="M12 5v14"/><path d="M5 12h14"/>',
        'eye' => '<path d="M2.2 12S6 5.5 12 5.5 21.8 12 21.8 12 18 18.5 12 18.5 2.2 12 2.2 12Z"/><circle cx="12" cy="12" r="3"/>',
        'pencil' => '<path d="M16.6 3.6a2.6 2.6 0 0 1 3.7 3.7L7.6 20.1 3 21.2l1.1-4.6Z"/><path d="m14.8 5.4 3.8 3.8"/>',
        'trash' => '<path d="M3.5 6.5h17"/><path d="M18.5 6.5 17.7 19a2 2 0 0 1-2 1.9H8.3a2 2 0 0 1-2-1.9L5.5 6.5"/><path d="M9.8 11v6"/><path d="M14.2 11v6"/><path d="M9 6.5V4.6a1.6 1.6 0 0 1 1.6-1.6h2.8A1.6 1.6 0 0 1 15 4.6v1.9"/>',
        'chevron-down' => '<path d="m6 9.5 6 6 6-6"/>',
        'chevron-left' => '<path d="m14 6-6 6 6 6"/>',
        'chevron-right' => '<path d="m10 6 6 6-6 6"/>',
        'arrow-right' => '<path d="M4.5 12h14"/><path d="m13 6.5 5.5 5.5L13 17.5"/>',
        'refresh' => '<path d="M20.5 12a8.5 8.5 0 1 1-2.6-6.1"/><path d="M20.5 4v4.5H16"/>',
        'lock' => '<rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
        'alert-circle' => '<circle cx="12" cy="12" r="9.2"/><path d="M12 7.8v5"/><path d="M12 16.2h.01"/>',
        'bold' => '<path d="M7 4.5h6a4 4 0 0 1 0 8H7Z"/><path d="M7 12.5h7a4 4 0 0 1 0 8H7Z"/>',
        'italic' => '<path d="M18 4.5h-7"/><path d="M13 19.5H6"/><path d="M14.5 4.5 9.5 19.5"/>',
        'list' => '<path d="M8.5 6.5H21"/><path d="M8.5 12H21"/><path d="M8.5 17.5H21"/><circle cx="4" cy="6.5" r="1"/><circle cx="4" cy="12" r="1"/><circle cx="4" cy="17.5" r="1"/>',
        'link' => '<path d="M10.2 13.8a4 4 0 0 0 5.7 0l2.4-2.4a4 4 0 0 0-5.7-5.7l-1.3 1.3"/><path d="M13.8 10.2a4 4 0 0 0-5.7 0l-2.4 2.4a4 4 0 0 0 5.7 5.7l1.3-1.3"/>',
        'image' => '<rect x="3" y="4" width="18" height="16" rx="2"/><circle cx="8.6" cy="9.4" r="1.6"/><path d="m20.5 16-4.8-4.8L5 21"/>',
        'upload' => '<path d="M12 16V4.5"/><path d="m7.5 9 4.5-4.5L16.5 9"/><path d="M4 15v3.5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V15"/>',
        'x' => '<path d="m6 6 12 12"/><path d="m18 6-12 12"/>',
        'cloud' => '<path d="M17.5 19.5a4 4 0 0 0 .3-8 6.5 6.5 0 0 0-12.4 1.8A3.8 3.8 0 0 0 6.5 19.5Z"/>',
        'shopify' => '<path d="M5.5 7.5 4 20.5h16L18.5 7.5Z"/><path d="M9 7.5V5.8a3 3 0 0 1 6 0V7.5"/>',
        'amazon' => '<path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/><path d="M3.3 7 12 12l8.7-5"/><path d="M12 22V12"/>',
    ];
@endphp

<svg {{ $attributes->merge(['class' => 'icon']) }} viewBox="0 0 24 24" fill="none" stroke="currentColor"
     stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
    {!! $paths[$name] ?? $paths['package'] !!}
</svg>
