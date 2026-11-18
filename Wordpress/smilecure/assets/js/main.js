/**
 * Smilecure theme scripts.
 */
(function () {
	'use strict';

	var body = document.body;
	var nav = document.querySelector('.primary-nav');
	var navToggle = document.querySelector('.nav-toggle');
	var navClose = document.querySelector('.nav-close');
	var navOverlay = document.querySelector('.nav-overlay');
	var header = document.querySelector('.site-header');

	function setMenu(open) {
		if (!nav || !navToggle) {
			return;
		}
		nav.classList.toggle('is-open', open);
		body.classList.toggle('menu-open', open);
		navToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
	}

	if (navToggle) {
		navToggle.addEventListener('click', function () {
			setMenu(true);
		});
	}

	if (navClose) {
		navClose.addEventListener('click', function () {
			setMenu(false);
		});
	}

	if (navOverlay) {
		navOverlay.addEventListener('click', function () {
			setMenu(false);
		});
	}

	document.addEventListener('keydown', function (event) {
		if (event.key === 'Escape') {
			setMenu(false);
		}
	});

	if (nav) {
		nav.addEventListener('click', function (event) {
			if (event.target.closest('a')) {
				setMenu(false);
			}
		});
	}

	// Header shadow on scroll.
	if (header) {
		var updateHeader = function () {
			header.classList.toggle('is-scrolled', window.scrollY > 10);
		};
		updateHeader();
		window.addEventListener('scroll', updateHeader, { passive: true });
	}

	// Testimonial slider.
	var slides = Array.prototype.slice.call(document.querySelectorAll('.testimonial'));
	var dots = Array.prototype.slice.call(document.querySelectorAll('.testimonial-dot'));
	var slider = document.querySelector('.testimonial-slider');

	if (slides.length > 1) {
		var current = 0;
		var timer = null;
		var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

		var showSlide = function (index) {
			current = (index + slides.length) % slides.length;
			slides.forEach(function (slide, i) {
				slide.classList.toggle('is-active', i === current);
			});
			dots.forEach(function (dot, i) {
				dot.classList.toggle('is-active', i === current);
				dot.setAttribute('aria-selected', i === current ? 'true' : 'false');
			});
		};

		var startAutoplay = function () {
			if (reduceMotion) {
				return;
			}
			stopAutoplay();
			timer = window.setInterval(function () {
				showSlide(current + 1);
			}, 6000);
		};

		var stopAutoplay = function () {
			if (timer) {
				window.clearInterval(timer);
				timer = null;
			}
		};

		dots.forEach(function (dot) {
			dot.addEventListener('click', function () {
				showSlide(parseInt(dot.getAttribute('data-slide'), 10) || 0);
				startAutoplay();
			});
		});

		if (slider) {
			slider.addEventListener('mouseenter', stopAutoplay);
			slider.addEventListener('mouseleave', startAutoplay);
			slider.addEventListener('focusin', stopAutoplay);
			slider.addEventListener('focusout', startAutoplay);
		}

		showSlide(0);
		startAutoplay();
	}
})();
