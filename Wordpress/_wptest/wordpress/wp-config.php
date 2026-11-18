<?php
/**
 * Local test configuration for the Smilecure theme.
 * Uses the SQLite drop-in, so no MySQL server is required.
 */

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', 'wordpress' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',         'smilecure-local-auth-key-8f3a1c' );
define( 'SECURE_AUTH_KEY',  'smilecure-local-secure-auth-2b7d4e' );
define( 'LOGGED_IN_KEY',    'smilecure-local-logged-in-5c9f0a' );
define( 'NONCE_KEY',        'smilecure-local-nonce-1d6e8b' );
define( 'AUTH_SALT',        'smilecure-local-auth-salt-3a4c9d' );
define( 'SECURE_AUTH_SALT', 'smilecure-local-secure-salt-7b2e5f' );
define( 'LOGGED_IN_SALT',   'smilecure-local-logged-salt-9e1d3a' );
define( 'NONCE_SALT',       'smilecure-local-nonce-salt-4f8b2c' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'WP_HOME', 'http://localhost:8080' );
define( 'WP_SITEURL', 'http://localhost:8080' );
define( 'DISABLE_WP_CRON', true );
define( 'FS_METHOD', 'direct' );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
