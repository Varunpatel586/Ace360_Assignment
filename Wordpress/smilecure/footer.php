<?php
/**
 * Site footer.
 *
 * @package Smilecure
 */

$smilecure_contact = smilecure_contact_details();

// Point the legal links at real pages; drop the link when no such page exists.
$smilecure_privacy_url = smilecure_page_url( array( 'privacy-policy', 'privacy' ) );
$smilecure_terms_url   = smilecure_page_url( array( 'terms-conditions', 'terms-and-conditions', 'terms-of-service', 'terms' ) );
?>
</main>

<footer class="site-footer" id="contact">
	<div class="container">
		<div class="footer-grid">
			<div class="footer-col footer-col--brand">
				<a class="brand brand--footer" href="<?php echo esc_url( home_url( '/' ) ); ?>" rel="home">
					<span class="brand__mark"><?php echo smilecure_icon( 'tooth' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
					<span class="brand__name">Smile<span>cure</span></span>
				</a>
				<p><?php esc_html_e( 'Gentle, modern dentistry for the whole family. We combine experienced specialists with the latest technology to keep your smile healthy for life.', 'smilecure' ); ?></p>
				<ul class="footer-contact">
					<li>
						<span class="footer-contact__icon"><?php echo smilecure_icon( 'pin' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<?php echo esc_html( $smilecure_contact['address'] ); ?>
					</li>
					<li>
						<span class="footer-contact__icon"><?php echo smilecure_icon( 'phone' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<a href="tel:<?php echo esc_attr( $smilecure_contact['phone_link'] ); ?>"><?php echo esc_html( $smilecure_contact['phone'] ); ?></a>
					</li>
					<li>
						<span class="footer-contact__icon"><?php echo smilecure_icon( 'mail' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<a href="mailto:<?php echo esc_attr( $smilecure_contact['email'] ); ?>"><?php echo esc_html( $smilecure_contact['email'] ); ?></a>
					</li>
				</ul>
			</div>

			<div class="footer-col">
				<h3><?php esc_html_e( 'Quick Links', 'smilecure' ); ?></h3>
				<ul class="footer-links">
					<li><a href="<?php echo esc_url( home_url( '/#home' ) ); ?>"><?php esc_html_e( 'Home', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#about' ) ); ?>"><?php esc_html_e( 'About Us', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Our Services', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#doctors' ) ); ?>"><?php esc_html_e( 'Our Doctors', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#blog' ) ); ?>"><?php esc_html_e( 'Latest News', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#appointment' ) ); ?>"><?php esc_html_e( 'Appointment', 'smilecure' ); ?></a></li>
				</ul>
			</div>

			<div class="footer-col">
				<h3><?php esc_html_e( 'Our Services', 'smilecure' ); ?></h3>
				<ul class="footer-links">
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Dental Implants', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Teeth Whitening', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Orthodontics', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Root Canal Therapy', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Cosmetic Dentistry', 'smilecure' ); ?></a></li>
					<li><a href="<?php echo esc_url( home_url( '/#services' ) ); ?>"><?php esc_html_e( 'Pediatric Dentistry', 'smilecure' ); ?></a></li>
				</ul>
			</div>

			<div class="footer-col">
				<h3><?php esc_html_e( 'Opening Hours', 'smilecure' ); ?></h3>
				<ul class="footer-hours">
					<li><span><?php esc_html_e( 'Monday - Friday', 'smilecure' ); ?></span><span>8:00 - 21:00</span></li>
					<li><span><?php esc_html_e( 'Saturday', 'smilecure' ); ?></span><span>9:00 - 18:00</span></li>
					<li><span><?php esc_html_e( 'Sunday', 'smilecure' ); ?></span><span><?php esc_html_e( 'Closed', 'smilecure' ); ?></span></li>
				</ul>
				<?php smilecure_socials( 'socials--footer' ); ?>
			</div>
		</div>

		<div class="footer-bottom">
			<p>
				&copy; <?php echo esc_html( date_i18n( 'Y' ) ); ?>
				<?php esc_html_e( 'Smilecure. All rights reserved.', 'smilecure' ); ?>
			</p>
			<ul class="footer-bottom__links">
				<?php if ( $smilecure_privacy_url ) : ?>
					<li><a href="<?php echo esc_url( $smilecure_privacy_url ); ?>"><?php esc_html_e( 'Privacy Policy', 'smilecure' ); ?></a></li>
				<?php endif; ?>
				<?php if ( $smilecure_terms_url ) : ?>
					<li><a href="<?php echo esc_url( $smilecure_terms_url ); ?>"><?php esc_html_e( 'Terms & Conditions', 'smilecure' ); ?></a></li>
				<?php endif; ?>
			</ul>
		</div>
	</div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
