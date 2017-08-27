
<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: index.php 2015-10-22 16:01 $
 */
use Phalcon\Http\Response;
use Phalcon\Mvc\Application;
use Phalcon\DI\FactoryDefault;
use Phalcon\Logger\Adapter\File as Logger;

error_reporting(E_ALL);
ini_set('display_errors', 'ON');

#PRODUCTION
#DEVELOPMENT
define('ENVIRONMENT', 'DEVELOPMENT');

try {

    define('BASE_DIR', dirname(__DIR__));
    define('APP_DIR', BASE_DIR . '/app');

    // Read the configuration
    $config = include APP_DIR . "/config/config.php";

    // Read auto-loader
    include APP_DIR . "/config/loader.php";

    // Read services
    include APP_DIR . "/config/services.php";

    // Handle the request
    $application = new Application($di);
    echo $application->handle()->getContent();

} catch (Exception $e) {
    if (ENVIRONMENT == 'DEVELOPMENT')
    {
        echo $e->getMessage(), '<br>';
        echo nl2br(htmlentities($e->getTraceAsString()));
    } else {
        $logger = new Logger(BASE_DIR . '/var/logs/error.log');
        $logger->error($e->getMessage());
        $logger->error($e->getTraceAsString());

        $response = new Response();
        $response->redirect('index/e500');
        $response->send();
    }

}