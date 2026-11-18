<?php
/**
 * 404 template.
 *
 * @package Smilecure
 */

get_header();
?>

<div class="page-hero page-hero--404">
	<div class="container">
		<span class="section-head__eyebrow"><?php esc_html_e( 'Error 404', 'smilecure' ); ?></span>
		<h1><?php esc_html_e( 'Page Not Found', 'smilecure' ); ?></h1>
		<p><?php esc_html_e( 'The page you are looking for may have moved or no longer exists.', 'smilecure' ); ?></p>
		<a class="btn btn--primary" href="<?php echo esc_url( home_url( '/' ) ); ?>">
			<?php esc_html_e( 'Back To Home', 'smilecure' ); ?>
		</a>
	</div>
</div>

<?php
get_footer();
