<?php
/**
 * One-off CLI bootstrap: installs WordPress, activates Smilecure and seeds
 * demo posts/pages so the theme's links can be tested for real.
 */

define( 'WP_INSTALLING', true );
require_once __DIR__ . '/wp-load.php';
require_once ABSPATH . 'wp-admin/includes/upgrade.php';

if ( ! is_blog_installed() ) {
	$result = wp_install( 'Smilecure', 'admin', 'admin@example.com', true, '', 'adminpass123' );
	echo "installed user_id={$result['user_id']}\n";
} else {
	echo "already installed\n";
}

switch_theme( 'smilecure' );
echo 'active theme: ' . get_option( 'stylesheet' ) . "\n";

// Plain permalinks keep the PHP built-in server happy (no rewrite rules).
update_option( 'permalink_structure', '' );
update_option( 'blogdescription', 'Dental Care For Life' );

$posts = array(
	array( '5 Daily Habits That Keep Your Teeth Healthy', 'Small routines make the biggest difference. Here are five simple habits our dentists recommend every day.', '2026-01-12 09:00:00' ),
	array( 'What To Expect At Your First Dental Visit', 'A calm, friendly walkthrough of your first appointment, from check-up to your personal care plan.', '2026-02-04 09:00:00' ),
	array( 'Clear Aligners vs Traditional Braces', 'Both options straighten teeth beautifully. Compare comfort, visibility and treatment time before you decide.', '2026-02-21 09:00:00' ),
);

foreach ( $posts as $post ) {
	if ( get_page_by_title( $post[0], OBJECT, 'post' ) ) {
		continue;
	}

	$id = wp_insert_post(
		array(
			'post_title'   => $post[0],
			'post_excerpt' => $post[1],
			'post_content' => $post[1] . "\n\nThis is placeholder article content created so the Latest News cards link to real posts.",
			'post_status'  => 'publish',
			'post_type'    => 'post',
			'post_date'    => $post[2],
		)
	);
	echo 'post created: ' . $post[0] . ' -> ' . get_permalink( $id ) . "\n";
}

$pages = array(
	array( 'Privacy Policy', 'privacy-policy' ),
	array( 'Terms & Conditions', 'terms-conditions' ),
);

foreach ( $pages as $page ) {
	if ( get_page_by_path( $page[1] ) ) {
		continue;
	}

	$id = wp_insert_post(
		array(
			'post_title'   => $page[0],
			'post_name'    => $page[1],
			'post_content' => 'Placeholder ' . strtolower( $page[0] ) . ' content for the Smilecure demo site.',
			'post_status'  => 'publish',
			'post_type'    => 'page',
		)
	);
	echo 'page created: ' . $page[0] . ' -> ' . get_permalink( $id ) . "\n";
}

echo "done\n";
