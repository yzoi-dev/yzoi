<?php/** * YZOI Online Judge System * * @copyright   Copyright (c) 2010 YZOI * @author      xaero <xaero@msn.cn> * @version     $Id: loader.php 2015-10-22 16:19 $ */$loader = new \Phalcon\Loader();// We're a registering a set of directories taken from the configuration file$loader->registerNamespaces(array(    'YZOI\Controllers'  => $config->application->controllersDir,    'YZOI\Models'       => $config->application->modelsDir,    'YZOI\Forms'        => $config->application->formsDir,    'YZOI'              => $config->application->libraryDir));$loader->register();