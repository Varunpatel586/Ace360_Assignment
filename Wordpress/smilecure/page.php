<?php
/**
 * Static page template.
 *
 * @package Smilecure
 */

get_header();
?>

<div class="page-hero">
	<div class="container">
		<span class="section-head__eyebrow"><?php esc_html_e( 'Smilecure', 'smilecure' ); ?></span>
		<h1><?php the_title(); ?></h1>
	</div>
</div>

<div class="section">
	<div class="container container--narrow">
		<?php
		while ( have_posts() ) :
			the_post();
			?>
			<article <?php post_class( 'entry-content' ); ?>>
				<?php if ( has_post_thumbnail() ) : ?>
					<figure class="entry-content__media"><?php the_post_thumbnail( 'large' ); ?></figure>
				<?php endif; ?>
				<?php the_content(); ?>
			</article>
		<?php endwhile; ?>
	</div>
</div>

<?php
get_footer();
