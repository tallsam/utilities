<?php 
$aliases['site.local'] = array (
  'context_type' => 'site',
  'platform' => '@platform_Site',
  'server' => '@server_master',
  'db_server' => '@server_localhost',
  'uri' => 'site.shogun.com',
  'root' => '/var/aegir/platforms/site',
  'site_path' => '/var/aegir/platforms/site/sites/site.shogun.com',
  'site_enabled' => true,
  'language' => 'en',
  'client_name' => 'admin',
  'aliases' => 
  array (
    0 => 'www.site.shogun.com',
  ),
  'redirection' => '1',
  'profile' => 'site',
  '%dump' => '/var/aegir/backup/dump.sql',
  'command-specific' => array (
    'sql-sync' => array (
      'no-cache' => TRUE,
    ),
  ),
  'path-aliases' => array(
    '%files' => 'sites/sitedir/files',
  ),
);

$aliases['site.prod'] = array(
  'uri' => 'site.com.au',
  'root' => '/home/site/public_html',
  'remote-host' => 'site.com',
  'remote-user' => 'root',
  '%dump' => '/root/site-dump.sql',
  'source-command-specific' => array(
    'sql-sync' => array(
      'skip-tables-list' => 'cache',
    ),
  ),
  'path-aliases' => array(
   '%files' => 'sites/sitedir/files',
  ),
);

$options['shell-aliases']['pull-files'] = '!drush rsync @site.prod:%files/ @site.local:%files';
$options['shell-aliases']['wipe'] = 'cache-clear all -verbose';
