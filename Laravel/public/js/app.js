/* Ace360degree — product management interactions */
(function () {
    "use strict";

    const $ = (selector, root = document) => root.querySelector(selector);
    const $$ = (selector, root = document) => Array.from(root.querySelectorAll(selector));

    /* ------------------------------------------------------------------ Toast */
    const toast = $("#appToast");

    if (toast) {
        let timer = window.setTimeout(dismissToast, 9000);

        function dismissToast() {
            window.clearTimeout(timer);
            toast.classList.add("is-hiding");
            window.setTimeout(() => toast.remove(), 220);
        }

        $("[data-toast-close]", toast)?.addEventListener("click", dismissToast);
    }

    /* ----------------------------------------------------------------- Modals */
    function openOverlay(overlay) {
        if (!overlay) return;
        overlay.classList.add("is-open");
        overlay.setAttribute("aria-hidden", "false");
        document.body.classList.add("modal-open");
    }

    function closeOverlay(overlay) {
        if (!overlay) return;
        overlay.classList.remove("is-open");
        overlay.setAttribute("aria-hidden", "true");

        if (!$(".overlay.is-open")) {
            document.body.classList.remove("modal-open");
        }
    }

    $$("[data-modal-close]").forEach((button) => {
        button.addEventListener("click", () => closeOverlay(button.closest(".overlay")));
    });

    $$(".overlay").forEach((overlay) => {
        overlay.addEventListener("mousedown", (event) => {
            if (event.target === overlay) closeOverlay(overlay);
        });
    });

    document.addEventListener("keydown", (event) => {
        if (event.key !== "Escape") return;
        $$(".overlay.is-open").forEach(closeOverlay);
    });

    /* --------------------------------------------------------- Product modal */
    const productModal = $("#productModal");
    const productForm = $("#productForm");

    if (productModal && productForm) {
        const modalTitle = $("[data-modal-title]", productModal);
        const nameInput = $("#productName");
        const skuInput = $("#productSku");
        const categoryInput = $("#productCategory");
        const priceInput = $("#productPrice");
        const salePriceInput = $("#productSalePrice");
        const stockInput = $("#productStock");
        const thresholdInput = $("#productThreshold");
        const descInput = $("#productDescription");
        const productIdInput = $('input[name="product_id"]', productForm);
        const descCount = $("[data-desc-count]", productForm);
        const imageInput = $("[data-image-input]", productForm);
        const uploader = $(".uploader", productForm);
        const preview = $("[data-image-preview]", productForm);
        const previewImg = $("[data-image-preview-img]", productForm);
        const dropzone = $("[data-dropzone]", productForm);
        const storeUrl = productForm.dataset.storeUrl;

        function setMethod(verb) {
            let input = $('input[name="_method"]', productForm);

            if (!verb) {
                input?.remove();
                return;
            }

            if (!input) {
                input = document.createElement("input");
                input.type = "hidden";
                input.name = "_method";
                productForm.appendChild(input);
            }

            input.value = verb;
        }

        function setReadonly(readonly) {
            $(".dialog", productModal).classList.toggle("is-readonly", readonly);

            $$("input, select, textarea, button.btn-soft", productForm).forEach((field) => {
                if (field.type === "hidden") return;
                field.disabled = readonly;
            });

            $$("[data-readonly-hide]", productForm).forEach((field) => {
                field.classList.toggle("is-hidden", readonly);
            });

            const cancel = $(".dialog-foot [data-modal-close]", productForm);

            if (cancel) cancel.textContent = readonly ? "Close" : "Cancel";

            const autosave = $(".autosave", productForm);
            if (autosave) autosave.classList.toggle("is-hidden", readonly);
        }

        function updateDescCount() {
            if (descInput && descCount) descCount.textContent = descInput.value.length;
        }

        function showPreview(src) {
            if (!preview || !previewImg) return;
            previewImg.src = src;
            preview.hidden = false;
            uploader?.classList.add("has-preview");
        }

        function clearPreview() {
            if (preview) preview.hidden = true;
            if (previewImg) previewImg.removeAttribute("src");
            uploader?.classList.remove("has-preview");
            if (imageInput) imageInput.value = "";
        }

        function fillForm(data) {
            productForm.reset();
            productIdInput.value = data ? data.id : "";
            nameInput.value = data ? data.name : "";
            skuInput.value = data ? data.sku : "";
            categoryInput.value = data && data.category_id ? String(data.category_id) : "";
            priceInput.value = data ? data.price : "";
            salePriceInput.value = data ? data.sale_price : "";
            stockInput.value = data ? data.stock : "";
            thresholdInput.value = data ? data.low_stock_threshold : "";
            if (descInput) descInput.value = data ? data.description || "" : "";

            const status = data ? data.status : "active";
            const radio = $(`input[name="status"][value="${status}"]`, productForm);
            if (radio) radio.checked = true;
            else $('input[name="status"][value="active"]', productForm).checked = true;

            updateDescCount();
            clearPreview();
            if (data && data.image) showPreview(data.image);

            if (data && data.update_url) {
                productForm.action = data.update_url;
                setMethod("PUT");
            } else {
                productForm.action = storeUrl;
                setMethod(null);
            }
        }

        $$("[data-product-add]").forEach((button) => {
            button.addEventListener("click", () => {
                setReadonly(false);
                modalTitle.textContent = "Add New Product";
                fillForm(null);
                openOverlay(productModal);
                window.setTimeout(() => nameInput.focus(), 60);
            });
        });

        $$("[data-product-edit]").forEach((button) => {
            button.addEventListener("click", () => {
                const data = JSON.parse(button.dataset.productEdit);
                setReadonly(false);
                modalTitle.textContent = "Edit Product";
                fillForm(data);
                openOverlay(productModal);
            });
        });

        $$("[data-product-view]").forEach((button) => {
            button.addEventListener("click", () => {
                const data = JSON.parse(button.dataset.productView);
                modalTitle.textContent = "Product Details";
                fillForm(data);
                setReadonly(true);
                openOverlay(productModal);
            });
        });

        $("[data-generate-sku]", productForm)?.addEventListener("click", () => {
            const code = categoryInput.selectedOptions[0]?.dataset.code || "SKU";
            const letters = "ABCDEFGHJKLMNPQRSTUVWXYZ";
            const alpha = Array.from({ length: 3 }, () => letters[Math.floor(Math.random() * letters.length)]).join("");
            const digits = String(Math.floor(1000 + Math.random() * 9000));
            skuInput.value = `${code}-${alpha}-${digits}`;
        });

        descInput?.addEventListener("input", updateDescCount);
        descInput?.setAttribute("maxlength", "2000");

        $("[data-image-clear]", productForm)?.addEventListener("click", (event) => {
            event.preventDefault();
            clearPreview();
        });

        if (dropzone && imageInput) {
            dropzone.addEventListener("dragover", (event) => {
                event.preventDefault();
                dropzone.classList.add("is-drag");
            });

            dropzone.addEventListener("dragleave", () => dropzone.classList.remove("is-drag"));

            dropzone.addEventListener("drop", (event) => {
                event.preventDefault();
                dropzone.classList.remove("is-drag");

                const file = event.dataTransfer?.files?.[0];
                if (!file) return;

                const transfer = new DataTransfer();
                transfer.items.add(file);
                imageInput.files = transfer.files;
                showPreview(URL.createObjectURL(file));
            });

            imageInput.addEventListener("change", () => {
                const file = imageInput.files?.[0];
                if (file) showPreview(URL.createObjectURL(file));
                else clearPreview();
            });
        }

        /* Reopen the modal after a failed validation round-trip. */
        if (productModal.dataset.openOnLoad === "1") {
            setReadonly(false);
            if (productIdInput.value) {
                modalTitle.textContent = "Edit Product";
                productForm.action = productForm.dataset.storeUrl.replace(/\/$/, "") + "/" + productIdInput.value;
                setMethod("PUT");
            } else {
                modalTitle.textContent = "Add New Product";
            }
            openOverlay(productModal);
        }
    }

    /* ---------------------------------------------------------- Delete modal */
    const deleteModal = $("#deleteModal");
    const deleteForm = $("#deleteForm");

    if (deleteModal && deleteForm) {
        const deleteConfirm = $("[data-del-confirm]", deleteForm);
        const deleteSubmit = $("[data-del-submit]", deleteForm);
        const deletePreviewRow = $("[data-del-preview]", deleteForm);
        const deleteTitle = $(".del-title", deleteForm);
        const deleteText = $(".del-text", deleteForm);
        const deleteName = $("[data-del-name]", deleteForm);
        const deleteSku = $("[data-del-sku]", deleteForm);
        const deleteImage = $("[data-del-image]", deleteForm);
        const deleteInitials = $("[data-del-initials]", deleteForm);
        const deleteProductName = $("[data-del-product-name]", deleteForm);
        const deleteCategory = $("[data-del-category]", deleteForm);
        const deleteStock = $("[data-del-stock]", deleteForm);
        const deleteId = $("[data-del-id]", deleteForm);
        const deletePrice = $("[data-del-price]", deleteForm);
        const bulkUrl = deleteForm.dataset.bulkUrl;
        const defaultText = deleteText.innerHTML;

        function resetDeleteState() {
            deleteConfirm.checked = false;
            deleteSubmit.disabled = true;
            $$('input[name="ids[]"]', deleteForm).forEach((input) => input.remove());
            const bulkAction = $('input[name="bulk_action"]', deleteForm);
            if (bulkAction) bulkAction.remove();
        }

        $$("[data-product-delete]").forEach((button) => {
            button.addEventListener("click", () => {
                const data = JSON.parse(button.dataset.productDelete);
                resetDeleteState();

                deleteForm.action = data.delete_url;
                deleteForm.dataset.mode = "single";

                const method = $('input[name="_method"]', deleteForm);
                if (method) method.value = "DELETE";

                deleteTitle.textContent = `Delete '${data.name}'?`;
                deleteText.innerHTML = defaultText;
                $("[data-del-sku]", deleteForm).textContent = data.sku;
                deletePreviewRow.hidden = false;

                if (data.image) {
                    deleteImage.src = data.image;
                    deleteImage.hidden = false;
                    deleteInitials.classList.add("is-hidden");
                } else {
                    deleteImage.hidden = true;
                    deleteInitials.textContent = data.initials;
                    deleteInitials.classList.remove("is-hidden");
                }

                deleteProductName.textContent = data.name;
                deleteCategory.textContent = data.category;
                deleteStock.textContent = data.stock;
                deleteId.textContent = `#${String(data.id).padStart(5, "0")}-MYSQL`;
                deletePrice.textContent = data.price_display;

                openOverlay(deleteModal);
            });
        });

        deleteConfirm.addEventListener("change", () => {
            deleteSubmit.disabled = !deleteConfirm.checked;
        });

        window.openBulkDelete = function (ids) {
            resetDeleteState();

            deleteForm.action = bulkUrl;
            deleteForm.dataset.mode = "bulk";

            const method = $('input[name="_method"]', deleteForm);
            if (method) method.remove();

            ids.forEach((id) => {
                const input = document.createElement("input");
                input.type = "hidden";
                input.name = "ids[]";
                input.value = id;
                deleteForm.appendChild(input);
            });

            const action = document.createElement("input");
            action.type = "hidden";
            action.name = "bulk_action";
            action.value = "delete";
            deleteForm.appendChild(action);

            deleteTitle.textContent = `Delete ${ids.length} selected product${ids.length === 1 ? "" : "s"}?`;
            deleteText.textContent =
                "This action will permanently remove the selected items from your MySQL database catalog and cancel " +
                "any pending store links. This action cannot be undone.";
            deletePreviewRow.hidden = true;
            deleteName.textContent = "this selection";

            openOverlay(deleteModal);
        };
    }

    /* ------------------------------------------------------------- Bulk bar */
    const bulkForm = $("#bulkForm");
    const bulkSelect = $("[data-bulk-select]");

    if (bulkSelect) {
        bulkSelect.addEventListener("change", () => {
            const value = bulkSelect.value;
            if (!value) return;

            const selected = $$("[data-row-check]:checked");

            if (!selected.length) {
                bulkSelect.value = "";
                return;
            }

            if (value === "delete") {
                window.openBulkDelete?.(selected.map((input) => input.value));
                bulkSelect.value = "";
                return;
            }

            bulkForm?.submit();
        });
    }

    const checkAll = $("[data-check-all]");
    if (checkAll) {
        checkAll.addEventListener("change", () => {
            $$("[data-row-check]").forEach((input) => {
                input.checked = checkAll.checked;
            });
        });
    }

    /* --------------------------------------------------------- Filter submits */
    $$("[data-autosubmit]").forEach((select) => {
        select.addEventListener("change", () => {
            const formId = select.getAttribute("form");
            const form = formId ? document.getElementById(formId) : select.closest("form");
            form?.submit();
        });
    });
})();
