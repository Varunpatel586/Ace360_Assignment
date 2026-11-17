<div class="overlay" id="deleteModal" aria-hidden="true">
    <div class="dialog dialog-sm" role="alertdialog" aria-modal="true" aria-labelledby="deleteDialogTitle">
        <div class="del-header">
            <x-icon name="alert-triangle" />
            <span>Destructive Action</span>
            <button type="button" class="dialog-close" data-modal-close aria-label="Close dialog">
                <x-icon name="x" />
            </button>
        </div>

        <form id="deleteForm" method="POST" action="" data-delete-form
              data-bulk-url="{{ route('products.bulk') }}" data-mode="single">
            @csrf
            @method('DELETE')

            <div class="del-body">
                <div class="del-title-row">
                    <span class="del-icon"><x-icon name="trash" /></span>
                    <div>
                        <h2 class="del-title" id="deleteDialogTitle">Delete '<span data-del-name>this product</span>'?</h2>
                        <p class="del-text">
                            Are you sure you want to delete this product? SKU: <span data-del-sku>&mdash;</span>.
                            This action will permanently remove the item from your MySQL database catalog and cancel
                            any pending store links. This action cannot be undone.
                        </p>
                    </div>
                </div>

                <div class="del-product" data-del-preview>
                    <span class="thumb">
                        <img src="" alt="" data-del-image hidden>
                        <span class="thumb-fallback" data-del-initials></span>
                    </span>
                    <div class="del-product-body">
                        <div class="del-product-name" data-del-product-name></div>
                        <div class="del-product-meta">
                            Category: <span data-del-category></span> &bull; Current Stock:
                            <span data-del-stock></span> units
                        </div>
                        <div class="del-product-meta">Database ID: <span data-del-id></span></div>
                    </div>
                    <span class="del-price" data-del-price></span>
                </div>

                <label class="del-confirm">
                    <input type="checkbox" class="check" data-del-confirm>
                    <span class="del-confirm-text">
                        <strong>I understand that this action is irreversible.</strong>
                        <span>Catalog sync across Amazon, Shopify, and in-store POS will be stopped immediately.</span>
                    </span>
                </label>
            </div>

            <div class="del-foot">
                <span class="del-lock"><x-icon name="lock" /><span>Requires Merchandiser Admin Role</span></span>
                <div class="foot-actions">
                    <button type="button" class="btn-ghost" data-modal-close>Cancel</button>
                    <button type="submit" class="btn-danger" data-del-submit disabled>
                        <x-icon name="trash" />
                        <span>Yes, Delete Product</span>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
