<?php

//header('Content-Type: application/json; charset=utf-8');

use Phalcon\Loader;
use Phalcon\Mvc\Micro;
use Phalcon\Di\FactoryDefault;
use Phalcon\Http\Response;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

define('BASE_DIR', dirname(__DIR__));
define('APP_DIR', BASE_DIR . '/app');

$config = include 'config.php';


$loader = new Loader();

$loader->registerNamespaces([
    'YZOI\Models'       => $config->application->modelsDir,
    //'YZOI\API'          => APP_DIR . '/api/',
    'YZOI'              => $config->application->libraryDir
]);

$loader->register();

include 'services.php';

$app = new Micro($di);

$app->notFound(
    function () use ($app) {
        echo '404 Not Found';
//        $app->response->setStatusCode(401, 'Unauthorized');
//        $app->response->sendHeaders();

//        $message = 'Nothing to see here. Move along....';
//        $app->response->setContent($message);
//        $app->response->send();
    }
);

$app->post(
    '/auth',
    function () {
        $response = new Response();

        try {
            $payload = $this->request->getJsonRawBody(true);

            $response->setJsonContent($this->auth->check([
                'name' => $payload['name'],
                'password' => $payload['password'],
                'remember' => $payload['remember']
            ]));
        } catch (Exception $e) {
            $response->setStatusCode(401, 'Unauthorized');
            $response->sendHeaders();
            $response->setJsonContent(['error' => $e->getMessage()]);
        }


        return $response;
    }
);

$app->get(
    '/auth/logout',
    function () {
        if ($this->auth->getIdentity()) {
            $this->auth->remove();
        }
    }
);

$app->get(
    '/problems/{page}',
    function ($page) use ($app) {
        $problems = YZOI\Models\Problems::find([
            'columns' => 'id, title, sources, solved, submit',
            'order' => 'id ASC'
        ]);
        $paginator = new PaginatorModel(
            [
                'data'  => $problems,
                'limit' => YZOI\Models\Problems::FRONT_PER_PAGE,
                'page'  => $page,
            ]
        );
        return json_encode($paginator->getPaginate()->items);
    }
);

$app->get(
    '/problems',
    function () {
        return json_encode(YZOI\Models\Problems::find([
            'columns' => 'id, title, sources, solved, submit',
            'order' => 'id ASC'
        ]));
    }
);

$app->get(
    '/problem/{id}',
    function ($id) use ($app) {
        $response = new Response();

        $problem = YZOI\Models\Problems::findFirst($id);

        if (!$problem) {
            $response->setStatusCode(404, 'Not Found');
            $response->sendHeaders();
        } else {
            $response->setJsonContent($problem->jsonSerialize());
        }

        return $response;
    }
);

$app->get(
    '/contests',
    function () {
        return json_encode(YZOI\Models\Contests::find(['active = "Y"', 'order' => 'id DESC']));
    }
);

$app->get(
    '/contests/{page}',
    function ($page) use ($app) {
        $contests = YZOI\Models\Contests::find([
            'active = "Y"',
            'order' => 'id DESC'
        ]);
        $paginator = new PaginatorModel(
            [
                'data'  => $contests,
                'limit' => YZOI\Models\Contests::FRONT_PER_PAGE,
                'page'  => $page,
            ]
        );
        return json_encode($paginator->getPaginate()->items);
    }
);

$app->get(
    '/contest/{id}',
    function ($id) {
        return json_encode(YZOI\Models\Contests::findFirst($id));
    }
);

$app->get(
    '/contest/{id}/problems',
    function ($id) {
        return json_encode(YZOI\Models\ContestsProblems::findProblemsByCId($id));
    }
);

$app->get(
    '/contest/{id}/status',
    function ($id) {
        return json_encode(YZOI\Models\Contests::find($id)->contests_solutions());
    }
);

$app->get(
    '/contest/{id}/ranking',
    function ($id) {
        return json_encode(YZOI\Models\Contests::find($id)->standing());
    }
);

$app->get(
    '/ident',
    function () {
        echo $this->session->get('yzoi-auth-identity')->name;
    }
);

$app->get(
    '/users',
    'YZOI\API\UsersApi::getAll'
//    function () use($app) {
//        //$this->auth->checkUserFlags(new YZOI\Models\Users());
//        return YZOI\API\UsersApi::getAll();
//    }
);

$app->handle();
