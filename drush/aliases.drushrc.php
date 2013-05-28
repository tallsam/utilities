<?php

/**
 * Define sites as follows
 * 
 * $sites['gateway'] => array(
 *  'local_uri' => 'gateway.local.com',
 *  'local_root' => '/home/sam/www/gateway/docroot',
 *  'local_path' => '/home/sam/www/gateway/docroot/sites/default',
 *   'remote_uri' => '',
 *   'remote_root' => '',
 *   'remote_path' => '',
 *   'remote_host' => '',
 *   'remote_user' => REMOTE_USER,
 *   'remote_dump' => '', 
 * );
 */

$sites = array();

if (file_exists('/home/sam/.drush/aliases.inc')) {
  include '/home/sam/.drush/aliases.inc';
}

foreach ($sites as $site_name => $site) {
  $aliases[$site_name] = array (
    'context_type' => 'site',
    'db_server' => 'localhost',
    'uri' => $site_name . '.local.com',
    'root' => $site['local_root'],
    'site_path' => $site['local_path'],
    'site_enabled' => true,
    'language' => 'en',
    'client_name' => 'admin',
    'aliases' =>  
    array (
      0 => 'www.' . $site . '.local.com',
    ),  
    'redirection' => '1',
    'profile' => 'site',
    '%dump' => '/home/sam/www/' . $site_name . '/tmp/dump.sql',
    'command-specific' => array (
      'sql-sync' => array (
        'no-cache' => TRUE,
      ),  
    ),  
    'path-aliases' => array(
      '%files' => $site['local_root'] . '/default/files',
    ),  
  );  
  $aliases[$site_name . '.dev'] = array(
    'uri' => $site['remote_uri'],
    'root' => $site['remote_root'],
    'remote-host' => $site['remote_host'],
    'remote-user' => $site['remote_user'],
    '%dump' => $site['remote_dump'],
    'source-command-specific' => array(
      'sql-sync' => array(
        'skip-tables-list' => 'cache',
      ),
    ),
    'path-aliases' => array(
      '%files' => $site['remote_path'] . '/files',
    ),
  );
}

