<?php
// Script to generate ab tests for logged in users using sessions
// from the database

// http://2bits.com/articles/using-apachebench-benchmarking-logged-users-automated-approach.html

if ($argc != 4) {
  $prog = basename($argv[0]);
  print "Usage: $prog url concurrency num_requests\n";
  exit(1);
}

$url = $argv[1];
$num_curr = $argv[2];
$num_reqs = $argv[3];

define('DRUPAL_ROOT', getcwd());
require_once './includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);

$result = db_query('SELECT s.sid FROM {sessions} s WHERE s.uid > 1 LIMIT '.$num_curr);
foreach ($result as $row) {
  $cookie = session_name() .'='. $row->sid;
  print "ab -c 1 -n $num_reqs -C $cookie $url &\n";
}

define('DRUPAL_ROOT', getcwd());
require_once './includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);

$result = db_query('SELECT s.sid FROM {sessions} s WHERE s.uid > 1 LIMIT '.$num_curr);
foreach ($result as $row) {
  $cookie = session_name() .'='. $row->sid;
  print "ab -c 1 -n $num_reqs -C $cookie $url &\n";
}
