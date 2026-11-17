/**
 * URBAN THREADS - Theme JavaScript
 * Minimal interactive functionality
 */

(function () {
  'use strict';

  // Cart drawer
  const cartButton = document.getElementById('cart-icon');
  const cartDrawer = document.getElementById('cart-drawer');
  const cartClose = document.getElementById('cart-close');
  const cartItems = document.getElementById('cart-items');
  const cartTotal = document.getElementById('cart-totals');

  if (cartButton && cartDrawer && cartClose) {
    const openCart = () => {
      cartDrawer.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    };

    const closeCart = () => {
      cartDrawer.classList.remove('is-open');
      document.body.style.overflow = '';
    };

    cartButton.addEventListener('click', openCart);
    cartClose.addEventListener('click', closeCart);

    // Update cart badge from Shopify cart count
    const cartCount = document.getElementById('cart-count');
    if (cartCount) {
      cartButton.innerHTML = `
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="9" cy="21" r="1.5" />
          <circle cx="18" cy="21" r="1.5" />
          <path d="M2 3h3l2.5 11h11L18 5h3a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z" />
        </svg>
        <span id="cart-badge"></span>
      `;
      // Shopify will populate cart-count via checkout.js
    }
  }

  // Wishlist toggle
  document.querySelectorAll('[data-wishlist]').forEach((button) => {
    button.addEventListener('click', function (e) {
      e.preventDefault();
      const productId = this.dataset.productId;
      const svg = this.querySelector('svg');
      const isFilled = this.classList.contains('is-active');

      // Toggle between outline and filled heart
      if (svg) {
        const shouldFill = !isFilled;
        this.classList.toggle('is-active', shouldFill);
        this.setAttribute('data-active', shouldFill);

        if (svg.querySelector('path')) {
          svg.querySelector('path').setAttribute('d', shouldFill ?
            'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z'
            : 'M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78L12 21.35l8.84-8.84a5.5 5.5 0 0 0 0-7.78z');
        }
      }

      // In a real implementation, this would communicate with Shopify
      console.log(`Wishlist toggled for product ${productId}`);
    });
  });

  // Mobile menu toggle
  const mobileMenuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');

  if (mobileMenuButton && mobileMenu) {
    mobileMenuButton.addEventListener('click', () => {
      mobileMenu.classList.toggle('is-visible');
    });

    // Close menu when clicking a link
    mobileMenu.querySelectorAll('a').forEach((link) => {
      link.addEventListener('click', () => {
        mobileMenu.classList.remove('is-visible');
      });
    });
  }

  // Quantity stepper
  document.querySelectorAll('[data-quantity]').forEach((button) => {
    const decrease = button.querySelector('[data-quantity-action="decrease"]');
    const increase = button.querySelector('[data-quantity-action="increase"]');
    const input = button.querySelector('input[type="number"]');

    if (decrease) {
      decrease.addEventListener('click', () => {
        if (input && input.value > 1) {
          input.value = parseInt(input.value) - 1;
        }
      });
    }

    if (increase) {
      increase.addEventListener('click', () => {
        if (input) {
          input.value = parseInt(input.value) + 1;
        }
      });
    }
  });
})();
