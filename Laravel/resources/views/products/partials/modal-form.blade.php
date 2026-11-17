@php
    $editingId = old('product_id');
    $formAction = $editingId ? route('products.update', $editingId) : route('products.store');
@endphp

<div class="overlay" id="productModal" aria-hidden="true" @if ($errors->any()) data-open-on-load="1" @endif>
    <div class="dialog" role="dialog" aria-modal="true" aria-labelledby="productModalTitle">
        <div class="dialog-head">
            <div>
                <div class="dialog-title-row">
                    <h2 class="dialog-title" id="productModalTitle" data-modal-title>Add New Product</h2>
                    <span class="version-chip">Draft v1.0</span>
                </div>
                <p class="dialog-sub">Fill in the product details below. Starred fields (*) are mandatory for MySQL catalog sync.</p>
            </div>
            <button type="button" class="dialog-close" data-modal-close aria-label="Close dialog">
                <x-icon name="x" />
            </button>
        </div>

        <form id="productForm" method="POST" action="{{ $formAction }}" enctype="multipart/form-data"
              data-store-url="{{ route('products.store') }}" novalidate>
            @csrf
            @if ($editingId)
                @method('PUT')
            @endif
            <input type="hidden" name="product_id" value="{{ old('product_id') }}">

            <div class="dialog-body">
                <div class="form-grid">
                    <div class="form-row full">
                        <label class="lbl" for="productName">Product Name <span class="req">*</span></label>
                        <input class="input" id="productName" type="text" name="name" value="{{ old('name') }}"
                               placeholder="Wireless Noise-Cancelling Headphones" autocomplete="off">
                        @error('name')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productSku">SKU (Stock Keeping Unit) <span class="req">*</span></label>
                        <div class="input-group">
                            <input class="input" id="productSku" type="text" name="sku" value="{{ old('sku') }}"
                                   placeholder="ELE-HPH-2024" autocomplete="off" data-sku-input>
                            <button type="button" class="btn-soft" data-generate-sku>
                                <x-icon name="refresh" />
                                <span>Generate</span>
                            </button>
                        </div>
                        <p class="helper">Unique alphanumeric identifier used across all warehouses.</p>
                        @error('sku')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productCategory">Category <span class="req">*</span></label>
                        <select class="input" id="productCategory" name="category_id" data-category-input>
                            <option value="">Select a category</option>
                            @foreach ($categories as $category)
                                <option value="{{ $category->id }}" data-code="{{ $category->code }}"
                                    @selected((string) old('category_id') === (string) $category->id)>
                                    {{ $category->name }}
                                </option>
                            @endforeach
                        </select>
                        <p class="helper">Classifies tax rates and marketplace grouping.</p>
                        @error('category_id')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productPrice">Regular Price ($) <span class="req">*</span></label>
                        <div class="prefix">
                            <span>$</span>
                            <input class="input" id="productPrice" type="number" step="0.01" min="0" name="price"
                                   value="{{ old('price') }}" placeholder="199.99">
                        </div>
                        @error('price')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productSalePrice">Sale Price ($) <span class="opt">(Optional)</span></label>
                        <div class="prefix">
                            <span>$</span>
                            <input class="input" id="productSalePrice" type="number" step="0.01" min="0" name="sale_price"
                                   value="{{ old('sale_price') }}" placeholder="149.99">
                        </div>
                        @error('sale_price')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productStock">Stock Quantity <span class="req">*</span></label>
                        <input class="input" id="productStock" type="number" min="0" name="stock"
                               value="{{ old('stock') }}" placeholder="150">
                        @error('stock')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row">
                        <label class="lbl" for="productThreshold">Low Stock Threshold <span class="opt">(Alert Limit)</span></label>
                        <input class="input" id="productThreshold" type="number" min="0" name="low_stock_threshold"
                               value="{{ old('low_stock_threshold') }}" placeholder="15">
                        @error('low_stock_threshold')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row full">
                        <span class="lbl">Product Publication Status <span class="req">*</span></span>
                        <div class="status-grid">
                            <label class="status-option">
                                <input type="radio" name="status" value="active" @checked(old('status', 'active') === 'active')>
                                <span class="st-head"><span class="st-dot tone-active"></span>Active</span>
                                <span class="status-desc">Visible in storefront &amp; POS</span>
                            </label>
                            <label class="status-option">
                                <input type="radio" name="status" value="draft" @checked(old('status') === 'draft')>
                                <span class="st-head"><span class="st-dot tone-draft"></span>Draft</span>
                                <span class="status-desc">Hidden from customer views</span>
                            </label>
                            <label class="status-option">
                                <input type="radio" name="status" value="inactive" @checked(old('status') === 'inactive')>
                                <span class="st-head"><span class="st-dot tone-inactive"></span>Inactive</span>
                                <span class="status-desc">Archived SKU record</span>
                            </label>
                        </div>
                        @error('status')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row full">
                        <div class="lbl-row">
                            <label class="lbl" for="productDescription">Description / Short Summary</label>
                            <span class="lbl-note">&lt;&gt; Markdown &amp; HTML Supported</span>
                        </div>
                        <div class="rich-editor">
                            <div class="rich-toolbar">
                                <div class="rich-icons">
                                    <x-icon name="bold" />
                                    <x-icon name="italic" />
                                    <x-icon name="list" />
                                    <x-icon name="link" />
                                    <x-icon name="image" />
                                </div>
                                <span class="rich-count"><span data-desc-count>{{ mb_strlen(old('description', '')) }}</span> / 2000 chars</span>
                            </div>
                            <textarea class="input" id="productDescription" name="description" maxlength="2000"
                                      data-desc-input placeholder="Describe materials, dimensions and key selling points.">{{ old('description') }}</textarea>
                        </div>
                        @error('description')<p class="field-error">{{ $message }}</p>@enderror
                    </div>

                    <div class="form-row full">
                        <span class="lbl">Product Image Upload Area</span>
                        <div class="uploader">
                            <label class="dropzone" data-dropzone>
                                <x-icon name="upload" />
                                <span class="dz-title">Drag &amp; drop product thumbnail or <u>browse file</u></span>
                                <span class="dz-sub">High resolution square or 4:3 ratio recommended</span>
                                <input type="file" name="image" accept="image/*" data-image-input hidden>
                            </label>
                            <div class="upload-preview" data-image-preview hidden>
                                <img src="" alt="Selected product thumbnail" data-image-preview-img>
                                <button type="button" class="upload-clear" data-image-clear aria-label="Remove image">
                                    <x-icon name="x" />
                                </button>
                            </div>
                        </div>
                        @error('image')<p class="field-error">{{ $message }}</p>@enderror
                    </div>
                </div>
            </div>

            <div class="dialog-foot">
                <span class="autosave"><x-icon name="cloud" /><span>Auto-saved to local memory</span></span>
                <div class="foot-actions">
                    <button type="button" class="btn-ghost" data-modal-close>Cancel</button>
                    <button type="submit" class="btn-ghost" name="intent" value="draft" data-readonly-hide>Save as Draft</button>
                    <button type="submit" class="btn-primary" name="intent" value="publish" data-readonly-hide>
                        <x-icon name="upload" />
                        <span>Save &amp; Publish Product</span>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
