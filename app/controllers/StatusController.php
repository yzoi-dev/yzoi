<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: StatusController.php 2015/12/18 12:28 $
 */
namespace YZOI\Controllers;


use YZOI\Forms\StatusForm;
use YZOI\Forms\SubmitcodeForm;
use YZOI\Models\Privileges;
use YZOI\Models\Solutions;
use \Phalcon\Paginator\Adapter\Model as Paginator;
use YZOI\Models\SourceCodes;

class StatusController extends ControllerBase
{
    public function indexAction()
    {
        //echo __('hi', ['asdf'=>'2222asfwea']);

        $pid = $this->request->getQuery("pid",array("trim", "int"));
        $uname = $this->request->getQuery("uname", array("trim", "striptags"));
        $ulang = $this->request->getQuery("ulang", array("trim", "int"));
        $result = $this->request->getQuery("result", array("trim", "int"));

        $filter = array(
            'pid' => $pid,
            'uname' => $uname,
            'ulang' => $ulang,
            'result' => $result
        );
        $filter = $this->clear_data($filter,  array(-1, '', null));
        //var_dump($filter);

        $this->view->title = "测评状态";

        $form = new StatusForm((object)$filter);
        $this->view->form = $form;
        $this->view->codeform = new SubmitcodeForm();

        $status = Solutions::findAllSolutionsBySql($filter);

        $numberPage = $this->request->getQuery("page", "int", 1);

        $paginator = new Paginator(array(
            'data' => $status,
            'limit' => Solutions::FRONT_PER_PAGE,
            'page' => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
        $this->view->filter = $filter;

    }


    public function listAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'index'
        ));
    }

    public function showAction($id)
    {
        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        $solution = Solutions::findFirstBySql($id);

        if (! $user || ! $solution->user_can_access($user)) {
                $this->flashSession->error("Access Deny");
                return $this->response->redirect("status");
        }


        $this->view->title = "$id 的测评详情";

        $this->view->additionalJS = array(
            'bsmd/ace/ace.js',
            'bsmd/ace/ext-static_highlight.js',
            'bsmd/sepcode.js'
        );

        if ($solution) {
            $this->view->solution = $solution;
        }
    }

    public function locksolutionAction()
    {
        $this->view->disable();

        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        if ($this->request->isAjax()) {
            $solution_id = $this->request->getQuery('solution_id', 'int');
            $solution = Solutions::findFirstById($solution_id);

            // 权限不够（不是本人，也不是管理员）
            if ($solution->users_id != $user->id && ! $user->is_ultraman()) {
                $this->flashSession->error("Access Deny");
                return $this->response->redirect("status");
            }

            if ($solution) {
                if ($solution->is_public == 'Y')
                    $solution->is_public = 'N';
                else
                    $solution->is_public = 'Y';

                $solution->update();

                $this->response->setJsonContent($solution->is_public);
                return $this->response;
            }
        }
    }

    public function getcodeAction()
    {
        $this->view->disable();

        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        if ($this->request->isAjax()) {
            $solution_id = $this->request->getQuery('solution_id', 'int');
            $solution = Solutions::findFirstBySql($solution_id);

            // 权限不够（不是本人，也不是管理员）
            if ($solution->users_id != $user->id && ! $user->is_ultraman()) {
                $this->flashSession->error("Access Deny");
                return $this->response->redirect("status");
            }

            if ($solution) {
                $this->response->setContent($solution->sourcecode);
                return $this->response;
            }
        }
    }
}