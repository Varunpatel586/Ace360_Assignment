<?php
/**
 * Site header.
 *
 * @package Smilecure
 */

$smilecure_contact = smilecure_contact_details();
?>
<!doctype html>
<html <?php language_attributes(); ?>>
<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="profile" href="https://gmpg.org/xfn/11">
	<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<a class="skip-link screen-reader-text" href="#content"><?php esc_html_e( 'Skip to content', 'smilecure' ); ?></a>

<div class="topbar">
	<div class="container topbar__inner">
		<div class="topbar__info">
			<a class="topbar__item" href="tel:<?php echo esc_attr( $smilecure_contact['phone_link'] ); ?>">
				<?php echo smilecure_icon( 'phone' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span><?php echo esc_html( $smilecure_contact['phone'] ); ?></span>
			</a>
			<a class="topbar__item" href="mailto:<?php echo esc_attr( $smilecure_contact['email'] ); ?>">
				<?php echo smilecure_icon( 'mail' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span><?php echo esc_html( $smilecure_contact['email'] ); ?></span>
			</a>
			<span class="topbar__item topbar__hours">
				<?php echo smilecure_icon( 'clock' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<span><?php echo esc_html( $smilecure_contact['hours'] ); ?></span>
			</span>
		</div>
		<div class="topbar__right">
			<?php smilecure_socials( 'socials--top' ); ?>
			<a class="btn btn--primary btn--sm" href="<?php echo esc_url( home_url( '/#appointment' ) ); ?>">
				<?php esc_html_e( 'Book Appointment', 'smilecure' ); ?>
			</a>
		</div>
	</div>
</div>

<header class="site-header" id="site-header">
	<div class="container header__inner">
		<div class="brand">
			<?php if ( has_custom_logo() ) : ?>
				<?php the_custom_logo(); ?>
			<?php else : ?>
				<a class="brand__link" href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home">
					<span class="brand__mark"><?php echo smilecure_icon( 'tooth' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
					<span class="brand__name">Smile<span>cure</span></span>
				</a>
			<?php endif; ?>
		</div>

		<nav class="primary-nav" id="primary-nav" aria-label="<?php esc_attr_e( 'Primary navigation', 'smilecure' ); ?>">
			<button class="nav-close" type="button" aria-label="<?php esc_attr_e( 'Close menu', 'smilecure' ); ?>">
				<?php echo smilecure_icon( 'close' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			</button>
			<?php
			wp_nav_menu(
				array(
					'theme_location' => 'primary',
					'container'      => false,
					'menu_class'     => 'primary-menu',
					'fallback_cb'    => 'smilecure_primary_menu_fallback',
					'depth'          => 1,
				)
			);
			?>
			<div class="primary-nav__mobile-cta">
				<a class="btn btn--primary" href="<?php echo esc_url( home_url( '/#appointment' ) ); ?>">
					<?php esc_html_e( 'Book Appointment', 'smilecure' ); ?>
				</a>
			</div>
		</nav>

		<div class="header__actions">
			<a class="header__phone" href="tel:<?php echo esc_attr( $smilecure_contact['phone_link'] ); ?>">
				<span class="header__phone-icon"><?php echo smilecure_icon( 'phone' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
				<span class="header__phone-text">
					<small><?php esc_html_e( 'Call Us Today', 'smilecure' ); ?></small>
					<strong><?php echo esc_html( $smilecure_contact['phone'] ); ?></strong>
				</span>
			</a>
			<a class="btn btn--primary header__cta" href="<?php echo esc_url( home_url( '/#appointment' ) ); ?>">
				<?php esc_html_e( 'Book Appointment', 'smilecure' ); ?>
				<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			</a>
			<button class="nav-toggle" type="button" aria-label="<?php esc_attr_e( 'Open menu', 'smilecure' ); ?>" aria-controls="primary-nav" aria-expanded="false">
				<?php echo smilecure_icon( 'menu' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
			</button>
		</div>
	</div>
</header>

<div class="nav-overlay" aria-hidden="true"></div>

<main id="content">
