<?php/** * YZOI Online Judge System * * @copyright   Copyright (c) 2010 YZOI * @author      xaero <xaero@msn.cn> * @version     $Id: services.php 2015-10-22 17:35 $ */use Phalcon\DI\FactoryDefault,    Phalcon\Mvc\View,    Phalcon\Mvc\Dispatcher,    Phalcon\Mvc\Url as UrlResolver,    Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter,    Phalcon\Mvc\View\Engine\Volt as VoltEngine,    Phalcon\Mvc\Model\MetaData\Memory as MetaDataAdapter,    Phalcon\Session\Adapter\Files as SessionAdapter,    Phalcon\Cache\Frontend\Output as FrontendCache,    Phalcon\Cache\Frontend\Data as FrontendData,    Phalcon\Cache\Backend\File as BackendCache,    Phalcon\Cache\Backend\Memcache as BackendMemcache,    Phalcon\Crypt,    Phalcon\Security,    Phalcon\Events\Manager as EventsManager,    Phalcon\Translate\Adapter\Gettext,    Phalcon\Http\Response\Cookies;use YZOI\Auth\Auth,    YZOI\Mailer;// The FactoryDefault Dependency Injector automatically register the right services providing a full stack framework$di = new FactoryDefault();$di->set('router', function(){    return require __DIR__ . '/routes.php';}, true);// The URL component is used to generate all kind of urls in the application$di->set('url', function() use ($config) {    $url = new UrlResolver();    $url->setBaseUri($config->application->baseUri);    return $url;}, true);// Setting up the view component/** * * 在模板中注册了全局函数“__” * 用法：{{ __('下标', ['翻译中的变量名' : '翻译中的变量值') }} * 如：{{ __('hi', ['name' : 'Dijkstra') }} * 编译结果 <?php echo __('hi', array('name' => 'Dijkstra'));?> * 编译时$resolvedArgs得到的值：string ''hi', array('asdf' => '2fasdf')' (length=31) * 其中$exprArgs的结果：array (size=2)  0 =>    array (size=3)      'expr' =>        array (size=4)          'type' => int 260          'value' => string 'hi' (length=2)          'file' => string '/var/www/yzoi7x/app/views/index/index.volt' (length=42)          'line' => int 1      'file' => string '/var/www/yzoi7x/app/views/index/index.volt' (length=42)      'line' => int 1  1 =>    array (size=3)      'expr' =>        array (size=4)          'type' => int 360          'left' =>            array (size=1)              ...          'file' => string '/var/www/yzoi7x/app/views/index/index.volt' (length=42)          'line' => int 1      'file' => string '/var/www/yzoi7x/app/views/index/index.volt' (length=42)      'line' => int 1 */$di->set('view', function() use ($config) {    $view = new View();    $view->setViewsDir($config->application->viewsDir);    $view->registerEngines(array(        '.volt' => function($view, $di) use ($config) {            $volt = new VoltEngine($view, $di);            $volt->setOptions(array(                'compiledPath' => $config->application->cacheDir . 'volt/',                'compliedSeparator' => '_'            ));            $volt->getCompiler()->addFunction('__', function ($resolvedArgs, $exprArgs){                return '__(' . $resolvedArgs . ')';            });            return $volt;        },        '.phtml' => 'Phalcon\Mvc\View\Engine\Php' //// Generate Template files uses PHP itself as the template engine    ));    return $view;}, true);// Database connection is created based in the parameters defined in the configuration file$di->set('db', function() use ($config) {    return new DbAdapter(array(        'host' => $config->database->host,        'username' => $config->database->username,        'password' => $config->database->password,        'dbname' => $config->database->dbname,        'charset' => 'utf8'    ));});//临时数据库$di->set('dbOldyzoi', function() {    return new DbAdapter(array(        "host" => "localhost",        "username" => "root",        "password" => "159632",        "dbname" => "yzoi",        'charset' => 'utf8'    ));});$di->set('config', function() use ($config) {   return $config;}, true);// If the configuration specify the use of metadata adapter use it or use memory otherwise$di->set('modelsMetadata', function() use ($config) {    return new MetaDataAdapter(array(        'metaDataDir' => $config->application->cacheDir . 'metaData/'    ));});// Set the views cache service/**$di->set('viewCache', function() use ($config) {// Cache data for one day by default$fontCache = new FrontendCache(["lifetime" => 86400]);// File backend settings$cache = new BackendCache($fontCache, ["cacheDir" => $config->application->cacheDir . 'cache/',]);return $cache;}); */// Set the models cache service/*$di->set('modelsCache', function () {    // Cache for one day    $frontCache = new FrontendData(["lifetime" => 86400]);    // Memcached connection settings    $cache = new BackendMemcache(        $frontCache,        ["servers" => array(array(            "host" => "localhost",            "port" => "11211"        ))]    );    return $cache;});*/$di->setShared('security', function () {    $security = new Security();    // set Work factor (how many times we go through)    $security->setWorkFactor(12); // can be a number from 1-12    // set Default Hash    $security->setDefaultHash(Security::CRYPT_BLOWFISH_Y); // choose default hash    return $security;});/** * Crypt service */$di->set('crypt', function () use ($config) {    $crypt = new Crypt();    $crypt->setKey($config->application->cryptSalt);    return $crypt;});$di->set('cookies', function () {    $cookies = new Cookies();    $cookies->useEncryption(true);    return $cookies;}, true);// Start the session the first time some component request the session service$di->set('session', function () {    $session = new SessionAdapter();    $session->start();    return $session;});// flash css class$di->set('flash', function() {    return new \Phalcon\Flash\Direct(array(        'error' => 'alert alert-danger alert-dark',        'success' => 'alert alert-success alert-dark',        'notice' => 'alert alert-info alert-dark',        'warning' => 'alert alert-dark',    ));});$di->set('flashSession', function() {    return new \Phalcon\Flash\Session(array(        'error' => 'alert alert-danger alert-dark',        'success' => 'alert alert-success alert-dark',        'notice' => 'alert alert-info alert-dark',        'warning' => 'alert alert-dark',    ));});/** * Dispatcher use a default namespace */$di->set('dispatcher', function(){    $dispatcher = new Dispatcher();    $dispatcher->setDefaultNamespace('YZOI\Controllers');/**    $eventsManager = new EventsManager();    $eventsManager->attach("dispatch", function ($event, $dispatcher, $exception) {        //controller or action doesn't exist        $object = $event->getData();        if ($event->getType() == 'beforeException') {            switch ($exception->getCode()) {                case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:                case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:                    $dispatcher->forward([                        'controller' => 'errors',                        'action'     => 'index'                    ]);                    return false;                case Dispatcher::EXCEPTION_CYCLIC_ROUTING:                    $dispatcher->forward([                        'controller' => 'errors',                        'action'     => 'show404'                    ]);                    return false;            }        }    });*/    return $dispatcher;});/** * Custom authentication component */$di->set('auth', function () {    return new Auth();});$di->set('mailer', function () {    return new Mailer();});$di->set('translation', function () use ($di) {    $lang = $di->get('auth')->getIdentity();    $lang = ($lang) ? $lang->display_lang : 'zh';    $lang_dir = $di->get('config')->application->langDir;    $controller = $di->get('router')->getControllerName();    if (! $controller) $controller = 'index';    require $lang_dir . $lang . '/main.php';    $lang_addtional = $lang_dir . $lang . '/' . $controller . '.php';    if (file_exists($lang_addtional))        require $lang_addtional;    $translation = new Phalcon\Translate\Adapter\NativeArray(array(        "content" => $_messages    ));    //var_dump($translation);    return $translation;}, true);/*$di->set('swiftmailer', function() use ($config) {    include $config->application->libraryDir . 'swift_required.php';    $transport = Swift_SmtpTransport::newInstance($config->smtp_host)        ->setUsername($config->smtp_username)        ->setPassword($config->smtp_password);    $mailer = Swift_Mailer::newInstance($transport);    return $mailer;});*//** * Translation function call anywhere * * @param $string * * @return mixed */if (! function_exists('__')) {    function __($string, array $placeholder = null)    {        $translation = \Phalcon\Di::getDefault()->get('translation');        return $translation->_($string, $placeholder);    }}