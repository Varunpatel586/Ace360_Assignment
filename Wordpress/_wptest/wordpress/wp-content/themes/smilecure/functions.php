<?php
/**
 * Smilecure theme functions.
 *
 * @package Smilecure
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

define( 'SMILE_CURE_VERSION', '1.0.0' );

if ( ! function_exists( 'smilecure_setup' ) ) :
	/**
	 * Register theme features.
	 */
	function smilecure_setup() {
		load_theme_textdomain( 'smilecure', get_template_directory() . '/languages' );

		add_theme_support( 'automatic-feed-links' );
		add_theme_support( 'title-tag' );
		add_theme_support( 'post-thumbnails' );
		add_theme_support( 'responsive-embeds' );
		add_theme_support( 'align-wide' );
		add_theme_support(
			'custom-logo',
			array(
				'height'      => 60,
				'width'       => 220,
				'flex-height' => true,
				'flex-width'  => true,
			)
		);
		add_theme_support(
			'html5',
			array( 'search-form', 'comment-form', 'comment-list', 'gallery', 'caption', 'style', 'script' )
		);

		register_nav_menus(
			array(
				'primary' => __( 'Primary Menu', 'smilecure' ),
				'footer'  => __( 'Footer Links', 'smilecure' ),
			)
		);
	}
endif;
add_action( 'after_setup_theme', 'smilecure_setup' );

/**
 * Load theme styles and scripts.
 */
function smilecure_assets() {
	wp_enqueue_style(
		'smilecure-fonts',
		'https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap',
		array(),
		null
	);
	wp_enqueue_style( 'smilecure-style', get_stylesheet_uri(), array(), SMILE_CURE_VERSION );
	wp_enqueue_style( 'smilecure-main', get_template_directory_uri() . '/assets/css/main.css', array( 'smilecure-style' ), SMILE_CURE_VERSION );
	wp_enqueue_script( 'smilecure-main', get_template_directory_uri() . '/assets/js/main.js', array(), SMILE_CURE_VERSION, true );
}
add_action( 'wp_enqueue_scripts', 'smilecure_assets' );

/**
 * Inline SVG icon set.
 *
 * @param string $name  Icon name.
 * @param string $class Extra CSS classes.
 * @return string
 */
function smilecure_icon( $name, $class = '' ) {
	static $icons = null;

	if ( null === $icons ) {
		$icons = array(
			'phone'       => '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.8 19.8 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.12 4.18 2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.13.96.36 1.9.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.91.34 1.85.57 2.81.7A2 2 0 0 1 22 16.92Z"/>',
			'mail'        => '<rect x="2" y="4" width="20" height="16" rx="2"/><path d="m22 6-10 7L2 6"/>',
			'clock'       => '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
			'pin'         => '<path d="M20 10c0 6-8 12-8 12S4 16 4 10a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="2.8"/>',
			'facebook'    => '<path d="M15 21v-7h2.6l.4-3H15V9.2c0-.9.3-1.5 1.6-1.5H18V5.1c-.3 0-1.4-.1-2.6-.1-2.6 0-4.4 1.6-4.4 4.5V11H8.5v3H11v7"/>',
			'twitter'     => '<path d="M22 5.9c-.7.3-1.5.6-2.3.7a4 4 0 0 0 1.8-2.2c-.8.5-1.7.8-2.6 1a4 4 0 0 0-6.9 3.6A11.4 11.4 0 0 1 3.7 4.7a4 4 0 0 0 1.2 5.4c-.6 0-1.2-.2-1.8-.5 0 2 1.4 3.6 3.2 4-.6.2-1.2.2-1.8.1a4 4 0 0 0 3.7 2.8A8 8 0 0 1 2 18.3a11.3 11.3 0 0 0 6.1 1.8c7.4 0 11.4-6.1 11.4-11.4v-.5c.8-.6 1.5-1.3 2-2.1Z"/>',
			'instagram'   => '<rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><path d="M17.5 6.5h.01"/>',
			'linkedin'    => '<path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-4 0v7h-4V8h4v1.5"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/>',
			'tooth'       => '<path d="M12 4.5c-1.9 0-2.7 1-4.2 1S4.9 4.2 4.3 5.6c-.7 1.7-.2 3.7.5 5.3.6 1.5 1 3 1.2 4.6.2 1.7.5 3.9 1.8 3.9 1.2 0 1.3-2 1.5-3.6.3-1.7.7-3 2.2-3s2 1.3 2.2 3c.3 1.7.4 3.6 1.6 3.6 1.3 0 1.6-2.2 1.8-3.9.2-1.6.6-3.1 1.2-4.6.7-1.6 1.2-3.6.5-5.3-.6-1.4-2-1.1-3.5-1.1s-2.3-1-4.2-1Z"/>',
			'calendar'    => '<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M16 3v4M8 3v4M3 11h18"/>',
			'stethoscope' => '<path d="M8 3v6a4 4 0 0 0 8 0V3"/><path d="M6 3h4M14 3h4"/><path d="M12 13v3a4 4 0 0 0 4 4h1a3 3 0 0 0 3-3v-2"/><circle cx="20" cy="12" r="2"/>',
			'shield'      => '<path d="M12 3l7 3v5.5c0 4.4-2.9 8-7 9.5-4.1-1.5-7-5.1-7-9.5V6l7-3Z"/><path d="m9 12 2 2 4-4"/>',
			'sparkles'    => '<path d="M12 3l1.6 4.7L18 9.5l-4.4 1.8L12 16l-1.6-4.7L6 9.5l4.4-1.8L12 3Z"/><path d="M18.5 15l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8.8-2.2Z"/>',
			'braces'      => '<path d="M4 9c1.5 5 4.2 8 8 8s6.5-3 8-8"/><path d="M7 9v2.4M10.3 11.7v3M13.7 11.7v3M17 9v2.4"/>',
			'implant'     => '<path d="M12 8.5c-1.7 0-2.4.9-3.8.9S5.6 8.2 5 9.5c-.6 1.5-.2 3.3.4 4.7.5 1.3.9 2.6 1 4 .2 1.5.4 3.4 1.6 3.4 1.1 0 1.1-1.8 1.4-3.2.2-1.5.6-2.6 1.9-2.6"/><path d="M12 8.5c1.7 0 2.4.9 3.8.9s2.6-1.2 3.2.1c.6 1.5.2 3.3-.4 4.7-.5 1.3-.9 2.6-1 4-.2 1.5-.4 3.4-1.6 3.4-1.1 0-1.1-1.8-1.4-3.2-.2-1.5-.6-2.6-1.9-2.6"/><path d="M12 13.5v7M10 16h4M10 18.5h4"/>',
			'smile'       => '<circle cx="12" cy="12" r="9"/><path d="M8.5 14.5a4.5 4.5 0 0 0 7 0M9 9.5h.01M15 9.5h.01"/>',
			'heart'       => '<path d="M20.8 4.6a5.5 5.5 0 0 0-7.8 0L12 5.7l-1-1.1a5.5 5.5 0 0 0-7.8 7.8l1.1 1L12 21l7.7-7.6 1.1-1a5.5 5.5 0 0 0 0-7.8Z"/>',
			'users'       => '<path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/>',
			'award'       => '<circle cx="12" cy="8" r="6"/><path d="M8.5 13.5 7 22l5-3 5 3-1.5-8.5"/>',
			'wallet'      => '<rect x="3" y="6" width="18" height="14" rx="2"/><path d="M3 10h18M16 15h2"/>',
			'check'       => '<path d="m20 6-11 11-5-5"/>',
			'arrow-right' => '<path d="M4 12h15"/><path d="m13 6 6 6-6 6"/>',
			'arrow-up-right' => '<path d="M7 17 17 7M8 7h9v9"/>',
			'menu'        => '<path d="M4 7h16M4 12h16M4 17h16"/>',
			'close'       => '<path d="M6 6l12 12M18 6 6 18"/>',
			'chevron-left'  => '<path d="m15 5-7 7 7 7"/>',
			'chevron-right' => '<path d="m9 5 7 7-7 7"/>',
			'star'        => '<path d="M12 2.6l2.9 5.9 6.5.9-4.7 4.6 1.1 6.5-5.8-3.1-5.8 3.1 1.1-6.5L2.6 9.4l6.5-.9L12 2.6Z"/>',
			'quote'       => '<path d="M9.6 6C6.5 7.2 4.7 9.8 4.7 13.2V18h6v-6H7.5c.1-1.7 1.1-3 2.9-3.8L9.6 6Zm9.6 0c-3.1 1.2-4.9 3.8-4.9 7.2V18h6v-6h-3.2c.1-1.7 1.1-3 2.9-3.8L19.2 6Z"/>',
		);
	}

	if ( ! isset( $icons[ $name ] ) ) {
		return '';
	}

	$filled = in_array( $name, array( 'star', 'quote' ), true );
	$attrs  = $filled
		? 'fill="currentColor" stroke="none"'
		: 'fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"';

	$classes = 'icon icon--' . $name;
	if ( $class ) {
		$classes .= ' ' . $class;
	}

	return '<svg class="' . esc_attr( $classes ) . '" viewBox="0 0 24 24" width="24" height="24" ' . $attrs . ' aria-hidden="true" focusable="false">' . $icons[ $name ] . '</svg>';
}

/**
 * Clinic contact details used across the templates.
 *
 * @return array
 */
function smilecure_contact_details() {
	return array(
		'phone'      => '+1 (234) 567-890',
		'phone_link' => '+1234567890',
		'email'      => 'info@smilecure.com',
		'address'    => '2464 Royal Ln. Mesa, New Jersey 45463',
		'hours'      => 'Mon - Sat: 8:00 AM - 9:00 PM',
	);
}

/**
 * Permalink of the first published page matching one of the given slugs.
 *
 * Used for links that should only be rendered when real content exists.
 *
 * @param string[] $slugs Candidate page slugs, in order of preference.
 * @return string Permalink, or an empty string when no matching page exists.
 */
function smilecure_page_url( $slugs ) {
	foreach ( (array) $slugs as $slug ) {
		$page = get_page_by_path( $slug );

		if ( $page instanceof WP_Post && 'publish' === $page->post_status ) {
			return get_permalink( $page );
		}
	}

	return '';
}

/**
 * Social links markup.
 *
 * @param string $class Extra CSS classes.
 */
function smilecure_socials( $class = '' ) {
	$networks = array(
		'facebook'  => 'https://www.facebook.com/',
		'twitter'   => 'https://twitter.com/',
		'instagram' => 'https://www.instagram.com/',
		'linkedin'  => 'https://www.linkedin.com/',
	);

	echo '<div class="socials ' . esc_attr( $class ) . '">';
	foreach ( $networks as $network => $url ) {
		printf(
			'<a class="socials__link" href="%1$s" target="_blank" rel="noopener noreferrer" aria-label="%2$s">%3$s</a>',
			esc_url( $url ),
			esc_attr( ucfirst( $network ) ),
			smilecure_icon( $network ) // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped
		);
	}
	echo '</div>';
}

/**
 * Fallback menu used before the user assigns a WordPress menu.
 */
function smilecure_primary_menu_fallback() {
	$items = array(
		array( 'label' => __( 'Home', 'smilecure' ), 'url' => '#home' ),
		array( 'label' => __( 'About Us', 'smilecure' ), 'url' => '#about' ),
		array( 'label' => __( 'Services', 'smilecure' ), 'url' => '#services' ),
		array( 'label' => __( 'Doctors', 'smilecure' ), 'url' => '#doctors' ),
		array( 'label' => __( 'Blog', 'smilecure' ), 'url' => '#blog' ),
		array( 'label' => __( 'Contact', 'smilecure' ), 'url' => '#contact' ),
	);

	echo '<ul id="primary-menu" class="primary-menu">';
	foreach ( $items as $item ) {
		echo '<li><a href="' . esc_url( $item['url'] ) . '">' . esc_html( $item['label'] ) . '</a></li>';
	}
	echo '</ul>';
}

/**
 * Handle the appointment form submission.
 */
function smilecure_handle_appointment() {
	$redirect = wp_get_referer() ? wp_get_referer() : home_url( '/' );

	if (
		! isset( $_POST['smilecure_appointment_nonce'] ) ||
		! wp_verify_nonce(
			sanitize_text_field( wp_unslash( $_POST['smilecure_appointment_nonce'] ) ),
			'smilecure_appointment'
		)
	) {
		wp_safe_redirect( add_query_arg( 'appointment', 'error', $redirect ) . '#appointment' );
		exit;
	}

	// Honeypot: silently accept and drop bot submissions.
	$company = isset( $_POST['company'] ) ? sanitize_text_field( wp_unslash( $_POST['company'] ) ) : '';
	if ( ! empty( $company ) ) {
		wp_safe_redirect( add_query_arg( 'appointment', 'success', $redirect ) . '#appointment' );
		exit;
	}

	$name       = isset( $_POST['name'] ) ? sanitize_text_field( wp_unslash( $_POST['name'] ) ) : '';
	$email      = isset( $_POST['email'] ) ? sanitize_email( wp_unslash( $_POST['email'] ) ) : '';
	$phone      = isset( $_POST['phone'] ) ? sanitize_text_field( wp_unslash( $_POST['phone'] ) ) : '';
	$date       = isset( $_POST['date'] ) ? sanitize_text_field( wp_unslash( $_POST['date'] ) ) : '';
	$department = isset( $_POST['department'] ) ? sanitize_text_field( wp_unslash( $_POST['department'] ) ) : '';
	$message    = isset( $_POST['message'] ) ? sanitize_textarea_field( wp_unslash( $_POST['message'] ) ) : '';

	if ( empty( $name ) || empty( $phone ) || ! is_email( $email ) ) {
		wp_safe_redirect( add_query_arg( 'appointment', 'invalid', $redirect ) . '#appointment' );
		exit;
	}

	$body = array(
		sprintf( /* translators: %s: patient name */ __( 'Name: %s', 'smilecure' ), $name ),
		sprintf( /* translators: %s: patient email */ __( 'Email: %s', 'smilecure' ), $email ),
		sprintf( /* translators: %s: patient phone */ __( 'Phone: %s', 'smilecure' ), $phone ),
		sprintf( /* translators: %s: preferred date */ __( 'Preferred date: %s', 'smilecure' ), $date ),
		sprintf( /* translators: %s: department */ __( 'Department: %s', 'smilecure' ), $department ),
		'',
		__( 'Message:', 'smilecure' ),
		$message,
	);

	$sent = wp_mail(
		get_option( 'admin_email' ),
		sprintf( /* translators: %s: patient name */ __( 'New appointment request from %s', 'smilecure' ), $name ),
		implode( "\n", $body ),
		array(
			'Content-Type: text/plain; charset=UTF-8',
			'Reply-To: ' . $name . ' <' . $email . '>',
		)
	);

	wp_safe_redirect( add_query_arg( 'appointment', $sent ? 'success' : 'error', $redirect ) . '#appointment' );
	exit;
}
add_action( 'admin_post_nopriv_smilecure_appointment', 'smilecure_handle_appointment' );
add_action( 'admin_post_smilecure_appointment', 'smilecure_handle_appointment' );
