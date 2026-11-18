<?php
/**
 * Main template fallback.
 *
 * @package Smilecure
 */

get_header();
?>

<div class="page-hero">
	<div class="container">
		<span class="section-head__eyebrow"><?php esc_html_e( 'Smilecure', 'smilecure' ); ?></span>
		<h1>
			<?php
			if ( is_home() && ! is_front_page() ) {
				single_post_title();
			} elseif ( is_search() ) {
				printf( /* translators: %s: search query */ esc_html__( 'Search results for: %s', 'smilecure' ), '<span>' . esc_html( get_search_query() ) . '</span>' );
			} elseif ( is_archive() ) {
				the_archive_title();
			} else {
				esc_html_e( 'Latest News', 'smilecure' );
			}
			?>
		</h1>
	</div>
</div>

<div class="section">
	<div class="container">
		<?php if ( have_posts() ) : ?>
			<div class="posts-grid">
				<?php
				while ( have_posts() ) :
					the_post();
					?>
					<article <?php post_class( 'post-card' ); ?>>
						<?php if ( has_post_thumbnail() ) : ?>
							<a class="post-card__media" href="<?php the_permalink(); ?>">
								<?php the_post_thumbnail( 'large' ); ?>
							</a>
						<?php endif; ?>
						<div class="post-card__body">
							<div class="post-card__meta"><?php echo esc_html( get_the_date() ); ?></div>
							<h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
							<p><?php echo esc_html( wp_trim_words( get_the_excerpt(), 24 ) ); ?></p>
							<a class="link-arrow" href="<?php the_permalink(); ?>">
								<?php esc_html_e( 'Read More', 'smilecure' ); ?>
								<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
							</a>
						</div>
					</article>
				<?php endwhile; ?>
			</div>

			<?php
			the_posts_pagination(
				array(
					'prev_text' => esc_html__( 'Previous', 'smilecure' ),
					'next_text' => esc_html__( 'Next', 'smilecure' ),
				)
			);
			?>
		<?php else : ?>
			<p class="text-center"><?php esc_html_e( 'Nothing found here yet. Please check back soon.', 'smilecure' ); ?></p>
		<?php endif; ?>
	</div>
</div>

<?php
get_footer();
