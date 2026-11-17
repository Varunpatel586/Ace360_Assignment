@extends('layouts.app')

@section('title', 'Product List')

@section('content')
    @include('products.partials.stats')

    <section class="card table-card">
        @include('products.partials.toolbar')
        @include('products.partials.table')
        @include('products.partials.footer')
    </section>

    <form id="filterForm" method="GET" action="{{ route('products.index') }}" hidden></form>

    <form id="bulkForm" method="POST" action="{{ route('products.bulk') }}" hidden>
        @csrf
    </form>

    @include('products.partials.insights')
@endsection

@push('modals')
    @include('products.partials.modal-form')
    @include('products.partials.modal-delete')
@endpush
