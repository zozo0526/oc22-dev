<?php
// Version
define('VERSION', '2.2.0.1b');

// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

// VirtualQMOD
require_once('./vqmod/vqmod.php');
VQMod::bootup();

// VQMODDED Startup
require_once(VQMod::modCheck(DIR_SYSTEM . 'startup.php'));

$application_config = 'catalog';

// Application
require_once(VQMod::modCheck(DIR_SYSTEM . 'framework.php'));