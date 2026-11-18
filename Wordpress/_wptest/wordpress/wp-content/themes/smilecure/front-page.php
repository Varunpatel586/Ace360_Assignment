<?php
/**
 * Front page: dental clinic landing design.
 *
 * @package Smilecure
 */

get_header();

$smilecure_contact = smilecure_contact_details();
$smilecure_images  = get_template_directory_uri() . '/assets/images';
$smilecure_status  = isset( $_GET['appointment'] ) ? sanitize_key( wp_unslash( $_GET['appointment'] ) ) : '';

$smilecure_services = array(
	array(
		'icon'  => 'implant',
		'title' => __( 'Dental Implants', 'smilecure' ),
		'text'  => __( 'Permanent, natural-looking replacements for missing teeth that restore comfort and confidence.', 'smilecure' ),
	),
	array(
		'icon'  => 'sparkles',
		'title' => __( 'Teeth Whitening', 'smilecure' ),
		'text'  => __( 'Safe, professional whitening treatments that brighten your smile in a single visit.', 'smilecure' ),
	),
	array(
		'icon'  => 'braces',
		'title' => __( 'Orthodontics', 'smilecure' ),
		'text'  => __( 'Clear aligners and modern braces designed to gently straighten teeth at any age.', 'smilecure' ),
	),
	array(
		'icon'  => 'tooth',
		'title' => __( 'Root Canal Therapy', 'smilecure' ),
		'text'  => __( 'Comfort-first endodontic care that relieves pain and saves your natural tooth.', 'smilecure' ),
	),
	array(
		'icon'  => 'shield',
		'title' => __( 'Cosmetic Dentistry', 'smilecure' ),
		'text'  => __( 'Veneers, bonding and smile makeovers tailored to the look you have always wanted.', 'smilecure' ),
	),
	array(
		'icon'  => 'smile',
		'title' => __( 'Pediatric Dentistry', 'smilecure' ),
		'text'  => __( 'Friendly, gentle visits that help children build healthy habits for a lifetime.', 'smilecure' ),
	),
);

$smilecure_advantages = array(
	array(
		'icon'  => 'award',
		'title' => __( 'Modern Equipment', 'smilecure' ),
		'text'  => __( 'Digital imaging and painless technology for faster, more precise treatment.', 'smilecure' ),
	),
	array(
		'icon'  => 'users',
		'title' => __( 'Experienced Team', 'smilecure' ),
		'text'  => __( 'Certified dentists and specialists with years of hands-on clinical experience.', 'smilecure' ),
	),
	array(
		'icon'  => 'wallet',
		'title' => __( 'Affordable Pricing', 'smilecure' ),
		'text'  => __( 'Clear estimates and flexible payment plans, with no hidden surprises.', 'smilecure' ),
	),
	array(
		'icon'  => 'heart',
		'title' => __( 'Trusted Care', 'smilecure' ),
		'text'  => __( 'Thousands of families trust us with their smiles because we listen first.', 'smilecure' ),
	),
);

$smilecure_doctors = array(
	array(
		'image' => 'doctor-1.jpg',
		'name'  => __( 'Dr. James Wilson', 'smilecure' ),
		'role'  => __( 'Dental Surgeon', 'smilecure' ),
	),
	array(
		'image' => 'doctor-2.jpg',
		'name'  => __( 'Dr. Sarah Mitchell', 'smilecure' ),
		'role'  => __( 'Orthodontist', 'smilecure' ),
	),
	array(
		'image' => 'doctor-3.jpg',
		'name'  => __( 'Dr. Michael Brown', 'smilecure' ),
		'role'  => __( 'Implant Specialist', 'smilecure' ),
	),
	array(
		'image' => 'doctor-4.jpg',
		'name'  => __( 'Dr. Emily Carter', 'smilecure' ),
		'role'  => __( 'Pediatric Dentist', 'smilecure' ),
	),
);

$smilecure_testimonials = array(
	array(
		'quote' => __( 'The whole team made me feel completely at ease. My implant looks and feels natural, and I finally enjoy smiling again.', 'smilecure' ),
		'name'  => __( 'Jessica Miller', 'smilecure' ),
		'role'  => __( 'Dental Implant Patient', 'smilecure' ),
		'image' => 'customer.jpg',
	),
	array(
		'quote' => __( 'Booking online was so easy and the clinic was spotless. My children actually look forward to their check-ups now.', 'smilecure' ),
		'name'  => __( 'Amanda Clark', 'smilecure' ),
		'role'  => __( 'Family Patient', 'smilecure' ),
		'image' => 'customer-2.jpg',
	),
	array(
		'quote' => __( 'Professional, gentle and honest about every option. I have recommended Smilecure to my whole family.', 'smilecure' ),
		'name'  => __( 'David Harris', 'smilecure' ),
		'role'  => __( 'Orthodontic Patient', 'smilecure' ),
		'image' => 'customer-3.jpg',
	),
);

$smilecure_news_fallback = array(
	array(
		'image' => 'news-1.jpg',
		'date'  => __( '12 Jan 2026', 'smilecure' ),
		'title' => __( '5 Daily Habits That Keep Your Teeth Healthy', 'smilecure' ),
		'text'  => __( 'Small routines make the biggest difference. Here are five simple habits our dentists recommend every day.', 'smilecure' ),
	),
	array(
		'image' => 'news-2.jpg',
		'date'  => __( '04 Feb 2026', 'smilecure' ),
		'title' => __( 'What To Expect At Your First Dental Visit', 'smilecure' ),
		'text'  => __( 'A calm, friendly walkthrough of your first appointment, from check-up to your personal care plan.', 'smilecure' ),
	),
	array(
		'image' => 'news-3.jpg',
		'date'  => __( '21 Feb 2026', 'smilecure' ),
		'title' => __( 'Clear Aligners vs Traditional Braces', 'smilecure' ),
		'text'  => __( 'Both options straighten teeth beautifully. Compare comfort, visibility and treatment time.', 'smilecure' ),
	),
);

// Latest News cards are filled from the site's real posts, falling back to the
// bundled demo cards (without links) when the site has no published posts yet.
$smilecure_posts      = array();
$smilecure_news_query = new WP_Query(
	array(
		'post_type'           => 'post',
		'post_status'         => 'publish',
		'posts_per_page'      => 3,
		'ignore_sticky_posts' => true,
		'no_found_rows'       => true,
	)
);

if ( $smilecure_news_query->have_posts() ) {
	$smilecure_slide = 0;

	while ( $smilecure_news_query->have_posts() ) {
		$smilecure_news_query->the_post();

		$smilecure_thumbnail = get_the_post_thumbnail_url( get_the_ID(), 'large' );
		if ( ! $smilecure_thumbnail ) {
			$smilecure_thumbnail = $smilecure_images . '/' . $smilecure_news_fallback[ $smilecure_slide % 3 ]['image'];
		}

		$smilecure_posts[] = array(
			'image' => $smilecure_thumbnail,
			'date'  => get_the_date(),
			'title' => get_the_title(),
			'text'  => wp_trim_words( get_the_excerpt(), 22, '...' ),
			'url'   => get_permalink(),
		);

		++$smilecure_slide;
	}

	wp_reset_postdata();
} else {
	foreach ( $smilecure_news_fallback as $smilecure_fallback ) {
		$smilecure_posts[] = array(
			'image' => $smilecure_images . '/' . $smilecure_fallback['image'],
			'date'  => $smilecure_fallback['date'],
			'title' => $smilecure_fallback['title'],
			'text'  => $smilecure_fallback['text'],
			'url'   => '',
		);
	}
}
?>

<section class="hero" id="home">
	<div class="container hero__inner">
		<div class="hero__content">
			<span class="eyebrow">
				<?php echo smilecure_icon( 'tooth' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				<?php esc_html_e( 'Dental Care You Can Trust', 'smilecure' ); ?>
			</span>
			<h1><?php esc_html_e( 'Dental Care For', 'smilecure' ); ?> <span><?php esc_html_e( 'Life', 'smilecure' ); ?></span></h1>
			<p><?php esc_html_e( 'From routine check-ups to complete smile makeovers, our caring team delivers gentle, modern dentistry in a calm and welcoming clinic.', 'smilecure' ); ?></p>
			<div class="hero__actions">
				<a class="btn btn--primary btn--lg" href="#appointment">
					<?php esc_html_e( 'Make Appointment', 'smilecure' ); ?>
					<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				</a>
			</div>
		</div>
	</div>
	<div class="hero__bg" aria-hidden="true"></div>
</section>

<section class="features" aria-label="<?php esc_attr_e( 'Clinic highlights', 'smilecure' ); ?>">
	<div class="container">
		<div class="feature-cards">
			<article class="feature-card feature-card--teal">
				<span class="feature-card__icon"><?php echo smilecure_icon( 'phone' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
				<h2><?php esc_html_e( 'Emergency Care', 'smilecure' ); ?></h2>
				<p><?php esc_html_e( 'Immediate support for dental pain, injuries and urgent oral problems, any day of the week.', 'smilecure' ); ?></p>
				<a class="feature-card__link" href="#appointment">
					<?php esc_html_e( 'Learn More', 'smilecure' ); ?>
					<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				</a>
			</article>

			<article class="feature-card feature-card--orange">
				<span class="feature-card__icon"><?php echo smilecure_icon( 'calendar' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
				<h2><?php esc_html_e( 'Online Appointment', 'smilecure' ); ?></h2>
				<p><?php esc_html_e( 'Reserve your visit in seconds and choose the time that fits your family schedule.', 'smilecure' ); ?></p>
				<a class="feature-card__link" href="#appointment">
					<?php esc_html_e( 'Learn More', 'smilecure' ); ?>
					<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				</a>
			</article>

			<article class="feature-card feature-card--navy">
				<span class="feature-card__icon"><?php echo smilecure_icon( 'stethoscope' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
				<h2><?php esc_html_e( 'Qualified Doctors', 'smilecure' ); ?></h2>
				<p><?php esc_html_e( 'A friendly team of certified specialists focused on gentle, lasting dental care.', 'smilecure' ); ?></p>
				<a class="feature-card__link" href="#doctors">
					<?php esc_html_e( 'Meet The Team', 'smilecure' ); ?>
					<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				</a>
			</article>
		</div>
	</div>
</section>

<section class="section about" id="about">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'About Our Clinic', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Welcome to Smilecure', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Personal care, modern technology and a team that treats you like family.', 'smilecure' ); ?></p>
		</div>

		<div class="about-grid">
			<div class="about-media">
				<img src="<?php echo esc_url( $smilecure_images . '/about.jpg' ); ?>" alt="<?php esc_attr_e( 'Dentist treating a patient at Smilecure clinic', 'smilecure' ); ?>" width="960" height="720" loading="lazy">
				<div class="about-media__badge">
					<span class="about-media__badge-number">15+</span>
					<span class="about-media__badge-text"><?php esc_html_e( 'Years Of Experience', 'smilecure' ); ?></span>
				</div>
			</div>

			<div class="about-content">
				<p class="about-content__lead"><?php esc_html_e( 'For more than 15 years, Smilecure has helped families enjoy healthier teeth and confident smiles through gentle, modern dentistry.', 'smilecure' ); ?></p>
				<p><?php esc_html_e( 'Our clinic brings preventive, restorative and cosmetic dentistry together under one roof. Every treatment plan starts with listening to you, explaining your options clearly and making sure you feel comfortable at every step.', 'smilecure' ); ?></p>

				<ul class="check-list">
					<li><?php echo smilecure_icon( 'check' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?><?php esc_html_e( 'Painless, modern treatments', 'smilecure' ); ?></li>
					<li><?php echo smilecure_icon( 'check' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?><?php esc_html_e( 'Transparent, affordable pricing', 'smilecure' ); ?></li>
					<li><?php echo smilecure_icon( 'check' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?><?php esc_html_e( 'Same-day emergency appointments', 'smilecure' ); ?></li>
					<li><?php echo smilecure_icon( 'check' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?><?php esc_html_e( 'Personalised care for every age', 'smilecure' ); ?></li>
				</ul>

				<a class="btn btn--primary" href="#appointment">
					<?php esc_html_e( 'Make An Appointment', 'smilecure' ); ?>
					<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
				</a>
			</div>
		</div>
	</div>
</section>

<section class="section section--light services" id="services">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'What We Do', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Our Clinic Services', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Complete dental care for every stage of life, delivered with a gentle touch.', 'smilecure' ); ?></p>
		</div>

		<div class="services-grid">
			<?php foreach ( $smilecure_services as $smilecure_service ) : ?>
				<article class="service-card">
					<span class="service-card__icon"><?php echo smilecure_icon( $smilecure_service['icon'] ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
					<h3><?php echo esc_html( $smilecure_service['title'] ); ?></h3>
					<p><?php echo esc_html( $smilecure_service['text'] ); ?></p>
					<a class="link-arrow" href="#appointment">
						<?php esc_html_e( 'Read More', 'smilecure' ); ?>
						<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
					</a>
				</article>
			<?php endforeach; ?>
		</div>
	</div>
</section>

<section class="section advantages" id="advantages">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'Why Choose Us', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Our Advantages', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Everything you need for a calm, confident visit, all in one friendly clinic.', 'smilecure' ); ?></p>
		</div>

		<div class="advantages-grid">
			<?php foreach ( $smilecure_advantages as $smilecure_advantage ) : ?>
				<article class="advantage-card">
					<span class="advantage-card__icon"><?php echo smilecure_icon( $smilecure_advantage['icon'] ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
					<h3><?php echo esc_html( $smilecure_advantage['title'] ); ?></h3>
					<p><?php echo esc_html( $smilecure_advantage['text'] ); ?></p>
				</article>
			<?php endforeach; ?>
		</div>
	</div>
</section>

<section class="stats" aria-label="<?php esc_attr_e( 'Clinic statistics', 'smilecure' ); ?>">
	<div class="container">
		<div class="stats-grid">
			<div class="stat">
				<span class="stat__num" data-count="15">15+</span>
				<span class="stat__label"><?php esc_html_e( 'Years Of Experience', 'smilecure' ); ?></span>
			</div>
			<div class="stat">
				<span class="stat__num" data-count="70">70+</span>
				<span class="stat__label"><?php esc_html_e( 'Expert Doctors', 'smilecure' ); ?></span>
			</div>
			<div class="stat">
				<span class="stat__num" data-count="3850">3850+</span>
				<span class="stat__label"><?php esc_html_e( 'Happy Patients', 'smilecure' ); ?></span>
			</div>
			<div class="stat">
				<span class="stat__num" data-count="1200">1200+</span>
				<span class="stat__label"><?php esc_html_e( 'Successful Treatments', 'smilecure' ); ?></span>
			</div>
		</div>
	</div>
</section>

<section class="section doctors" id="doctors">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'Meet The Team', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Our Expert Doctors', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Specialists who combine clinical excellence with a genuinely caring approach.', 'smilecure' ); ?></p>
		</div>

		<div class="doctors-grid">
			<?php foreach ( $smilecure_doctors as $smilecure_doctor ) : ?>
				<article class="doctor-card">
					<div class="doctor-card__photo">
						<img src="<?php echo esc_url( $smilecure_images . '/' . $smilecure_doctor['image'] ); ?>" alt="<?php echo esc_attr( $smilecure_doctor['name'] ); ?>" width="600" height="800" loading="lazy">
					</div>
					<div class="doctor-card__body">
						<h3><?php echo esc_html( $smilecure_doctor['name'] ); ?></h3>
						<span class="doctor-card__role"><?php echo esc_html( $smilecure_doctor['role'] ); ?></span>
						<div class="doctor-card__socials">
							<a href="https://www.facebook.com/" target="_blank" rel="noopener noreferrer" aria-label="<?php esc_attr_e( 'Facebook', 'smilecure' ); ?>"><?php echo smilecure_icon( 'facebook' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></a>
							<a href="https://twitter.com/" target="_blank" rel="noopener noreferrer" aria-label="<?php esc_attr_e( 'Twitter', 'smilecure' ); ?>"><?php echo smilecure_icon( 'twitter' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></a>
							<a href="https://www.instagram.com/" target="_blank" rel="noopener noreferrer" aria-label="<?php esc_attr_e( 'Instagram', 'smilecure' ); ?>"><?php echo smilecure_icon( 'instagram' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></a>
							<a href="https://www.linkedin.com/" target="_blank" rel="noopener noreferrer" aria-label="<?php esc_attr_e( 'LinkedIn', 'smilecure' ); ?>"><?php echo smilecure_icon( 'linkedin' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></a>
						</div>
					</div>
				</article>
			<?php endforeach; ?>
		</div>
	</div>
</section>

<section class="testimonials" id="testimonials">
	<div class="container">
		<div class="section-head section-head--on-dark">
			<span class="section-head__eyebrow"><?php esc_html_e( 'Testimonials', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Our Happy Customers', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Real stories from patients who love their new smiles.', 'smilecure' ); ?></p>
		</div>

		<div class="testimonial-slider">
			<?php foreach ( $smilecure_testimonials as $smilecure_index => $smilecure_testimonial ) : ?>
				<figure class="testimonial<?php echo 0 === $smilecure_index ? ' is-active' : ''; ?>" data-slide="<?php echo esc_attr( $smilecure_index ); ?>">
					<img class="testimonial__avatar" src="<?php echo esc_url( $smilecure_images . '/' . $smilecure_testimonial['image'] ); ?>" alt="<?php echo esc_attr( $smilecure_testimonial['name'] ); ?>" width="78" height="78" loading="lazy">
					<div class="rating" aria-label="<?php esc_attr_e( 'Rated 5 out of 5', 'smilecure' ); ?>">
						<?php for ( $smilecure_star = 0; $smilecure_star < 5; $smilecure_star++ ) : ?>
							<?php echo smilecure_icon( 'star' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
						<?php endfor; ?>
					</div>
					<blockquote><?php echo esc_html( $smilecure_testimonial['quote'] ); ?></blockquote>
					<figcaption>
						<strong><?php echo esc_html( $smilecure_testimonial['name'] ); ?></strong>
						<span><?php echo esc_html( $smilecure_testimonial['role'] ); ?></span>
					</figcaption>
				</figure>
			<?php endforeach; ?>

			<div class="testimonial-dots" role="tablist" aria-label="<?php esc_attr_e( 'Testimonials', 'smilecure' ); ?>">
				<?php foreach ( $smilecure_testimonials as $smilecure_index => $smilecure_testimonial ) : ?>
					<button type="button" class="testimonial-dot<?php echo 0 === $smilecure_index ? ' is-active' : ''; ?>" data-slide="<?php echo esc_attr( $smilecure_index ); ?>" aria-label="<?php echo esc_attr( sprintf( /* translators: %d: slide number */ __( 'Show testimonial %d', 'smilecure' ), $smilecure_index + 1 ) ); ?>"></button>
				<?php endforeach; ?>
			</div>
		</div>
	</div>
</section>

<section class="section blog" id="blog">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'From Our Blog', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Latest News', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Practical advice and insights from our dental team.', 'smilecure' ); ?></p>
		</div>

		<div class="posts-grid">
			<?php foreach ( $smilecure_posts as $smilecure_post ) : ?>
				<article class="post-card">
					<div class="post-card__media">
						<img src="<?php echo esc_url( $smilecure_post['image'] ); ?>" alt="<?php echo esc_attr( $smilecure_post['title'] ); ?>" width="800" height="500" loading="lazy">
						<span class="post-card__date"><?php echo esc_html( $smilecure_post['date'] ); ?></span>
					</div>
					<div class="post-card__body">
						<div class="post-card__meta"><?php esc_html_e( 'By Smilecure Team', 'smilecure' ); ?></div>
						<h3>
							<?php if ( $smilecure_post['url'] ) : ?>
								<a href="<?php echo esc_url( $smilecure_post['url'] ); ?>"><?php echo esc_html( $smilecure_post['title'] ); ?></a>
							<?php else : ?>
								<?php echo esc_html( $smilecure_post['title'] ); ?>
							<?php endif; ?>
						</h3>
						<p><?php echo esc_html( $smilecure_post['text'] ); ?></p>
						<?php if ( $smilecure_post['url'] ) : ?>
							<a class="link-arrow" href="<?php echo esc_url( $smilecure_post['url'] ); ?>">
								<?php esc_html_e( 'Read More', 'smilecure' ); ?>
								<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
							</a>
						<?php endif; ?>
					</div>
				</article>
			<?php endforeach; ?>
		</div>
	</div>
</section>

<section class="section appointment" id="appointment">
	<div class="container">
		<div class="section-head">
			<span class="section-head__eyebrow"><?php esc_html_e( 'Book A Visit', 'smilecure' ); ?></span>
			<h2><?php esc_html_e( 'Online Appointment', 'smilecure' ); ?></h2>
			<p><?php esc_html_e( 'Tell us when you would like to come in and our team will confirm your appointment.', 'smilecure' ); ?></p>
		</div>

		<div class="appointment-grid">
			<div class="appointment-info">
				<h3><?php esc_html_e( 'A healthier smile is one click away.', 'smilecure' ); ?></h3>
				<p><?php esc_html_e( 'Whether you need a routine check-up or urgent care, we will find a time that works for you. Prefer to talk? Call our friendly reception team.', 'smilecure' ); ?></p>

				<ul class="contact-list">
					<li>
						<span class="contact-list__icon"><?php echo smilecure_icon( 'phone' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<span>
							<small><?php esc_html_e( 'Call Us Anytime', 'smilecure' ); ?></small>
							<a href="tel:<?php echo esc_attr( $smilecure_contact['phone_link'] ); ?>"><?php echo esc_html( $smilecure_contact['phone'] ); ?></a>
						</span>
					</li>
					<li>
						<span class="contact-list__icon"><?php echo smilecure_icon( 'mail' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<span>
							<small><?php esc_html_e( 'Email Us', 'smilecure' ); ?></small>
							<a href="mailto:<?php echo esc_attr( $smilecure_contact['email'] ); ?>"><?php echo esc_html( $smilecure_contact['email'] ); ?></a>
						</span>
					</li>
					<li>
						<span class="contact-list__icon"><?php echo smilecure_icon( 'clock' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?></span>
						<span>
							<small><?php esc_html_e( 'Working Hours', 'smilecure' ); ?></small>
							<span class="contact-list__plain"><?php echo esc_html( $smilecure_contact['hours'] ); ?></span>
						</span>
					</li>
				</ul>
			</div>

			<div class="appointment-form-wrap">
				<?php if ( 'success' === $smilecure_status ) : ?>
					<div class="form-notice form-notice--success" role="status">
						<?php esc_html_e( 'Thank you! Your appointment request has been sent. We will contact you shortly.', 'smilecure' ); ?>
					</div>
				<?php elseif ( 'invalid' === $smilecure_status ) : ?>
					<div class="form-notice form-notice--error" role="alert">
						<?php esc_html_e( 'Please add your name, a valid email address and a phone number.', 'smilecure' ); ?>
					</div>
				<?php elseif ( 'error' === $smilecure_status ) : ?>
					<div class="form-notice form-notice--error" role="alert">
						<?php esc_html_e( 'Sorry, we could not send your request. Please call us directly.', 'smilecure' ); ?>
					</div>
				<?php endif; ?>

				<form class="appointment-form" action="<?php echo esc_url( admin_url( 'admin-post.php' ) ); ?>" method="post">
					<input type="hidden" name="action" value="smilecure_appointment">
					<?php wp_nonce_field( 'smilecure_appointment', 'smilecure_appointment_nonce' ); ?>

					<div class="form-grid">
						<div class="form-field">
							<label for="appointment-name"><?php esc_html_e( 'Full Name', 'smilecure' ); ?></label>
							<input type="text" id="appointment-name" name="name" placeholder="<?php esc_attr_e( 'Your name', 'smilecure' ); ?>" required>
						</div>
						<div class="form-field">
							<label for="appointment-email"><?php esc_html_e( 'Email Address', 'smilecure' ); ?></label>
							<input type="email" id="appointment-email" name="email" placeholder="<?php esc_attr_e( 'you@example.com', 'smilecure' ); ?>" required>
						</div>
						<div class="form-field">
							<label for="appointment-phone"><?php esc_html_e( 'Phone Number', 'smilecure' ); ?></label>
							<input type="tel" id="appointment-phone" name="phone" placeholder="<?php esc_attr_e( '+1 (000) 000-0000', 'smilecure' ); ?>" required>
						</div>
						<div class="form-field">
							<label for="appointment-date"><?php esc_html_e( 'Preferred Date', 'smilecure' ); ?></label>
							<input type="date" id="appointment-date" name="date">
						</div>
						<div class="form-field form-field--full">
							<label for="appointment-department"><?php esc_html_e( 'Department', 'smilecure' ); ?></label>
							<select id="appointment-department" name="department">
								<option value="General Dentistry"><?php esc_html_e( 'General Dentistry', 'smilecure' ); ?></option>
								<option value="Dental Implants"><?php esc_html_e( 'Dental Implants', 'smilecure' ); ?></option>
								<option value="Teeth Whitening"><?php esc_html_e( 'Teeth Whitening', 'smilecure' ); ?></option>
								<option value="Orthodontics"><?php esc_html_e( 'Orthodontics', 'smilecure' ); ?></option>
								<option value="Root Canal Therapy"><?php esc_html_e( 'Root Canal Therapy', 'smilecure' ); ?></option>
								<option value="Pediatric Dentistry"><?php esc_html_e( 'Pediatric Dentistry', 'smilecure' ); ?></option>
							</select>
						</div>
						<div class="form-field form-field--full">
							<label for="appointment-message"><?php esc_html_e( 'Message', 'smilecure' ); ?></label>
							<textarea id="appointment-message" name="message" rows="4" placeholder="<?php esc_attr_e( 'Tell us briefly how we can help', 'smilecure' ); ?>"></textarea>
						</div>
						<div class="form-field form-field--hp" aria-hidden="true">
							<label for="appointment-company"><?php esc_html_e( 'Company', 'smilecure' ); ?></label>
							<input type="text" id="appointment-company" name="company" tabindex="-1" autocomplete="off">
						</div>
					</div>

					<div class="form-actions">
						<button type="submit" class="btn btn--primary btn--lg">
							<?php esc_html_e( 'Book Appointment', 'smilecure' ); ?>
							<?php echo smilecure_icon( 'arrow-right' ); // phpcs:ignore WordPress.Security.EscapeOutput.OutputNotEscaped ?>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<?php
get_footer();
