<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME'));

/** MySQL database username */
define( 'DB_USER', getenv('ADMIN_WP_USER'));

/** MySQL database password */
define( 'DB_PASSWORD', getenv('ADMIN_WP_PASS'));

/** MySQL hostname */
define( 'DB_HOST', getenv('DB_HOST'));

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '');



/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '/)~`m+E# hY0^:Ohq^`Liiefq%+UJa@}kG %53[u=4K+,=E4Z*.[+J6tQLh)FQ>Y');
define('SECURE_AUTH_KEY',  'tNv|*a}!l*_3qa_-mEnsPxpoPZ^]aI19%KNP(1sk|IK|%OK[s%8e*_plpK+q:jk|');
define('LOGGED_IN_KEY',    '@S5c(B-UtN.C:KbfQHZ72]kUW83ZV1c-9k9@=-y`9a/6x]@enPI1lV.$8;MoT`7Y');
define('NONCE_KEY',        '2O7N[|-5,YI{|Jv5UXm_A^4b2rNB x~2klu.bJ}ew# Gn@-32Ww?qZOd5;-<C&@e');
define('AUTH_SALT',        '#2|NI|4HFRVzJ_QBi]LT{<PS[VWrp1+MUz!J$z%N0SWXtkrl`^+?I-3z&+B3;@2/');
define('SECURE_AUTH_SALT', 'EJT;y0}#>NyG$j(`lPP?c<!9+q!zEXBwQsZ8,r7FGfd6i0K_:8^U|$es!j8 /Kcb');
define('LOGGED_IN_SALT',   '*vUTbQpjSMT9JuDzPdxk_U}6Rwi1!IT+Q9uy9j/}%[{EAB%a),kT^(ru;4o=@+M~');
define('NONCE_SALT',       'd;Z}}5u?WTE6Z$&&-P$`U^n$|VT]SP]jAU2*x[#[+O~p:o&6#=RySm,4T}g,pNNW');


/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
