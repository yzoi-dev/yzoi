<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ContestsController.php 2015/12/13 15:16 $
 */
namespace YZOI\Controllers\Admin;

use YZOI\Forms\ContestsForm;
use YZOI\Models\Contests;
use YZOI\Models\ContestsProblems;
use \Phalcon\Paginator\Adapter\Model as Paginator;

class ContestsController extends ControllerBase
{
    public function initialize()
    {
        return parent::initialize(); // TODO: Change the autogenerated stub
    }

    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'list'
        ));
    }

    public function createAction()
    {
        $this->view->title = "新增作业/测验";

        $form = new ContestsForm();
        $this->view->form = $form;

        if ($this->request->isPost())
        {
            $contest = new Contests();

            $contest->title         = $this->request->getPost("title", array("trim", "striptags"));
            $contest->start_time    = strtotime($this->request->getPost("start_time", array("int")));
            $contest->end_time      = strtotime($this->request->getPost("end_time", array("int")));
            $contest->description   = $this->request->getPost("description");
            $problems_id            = $this->request->getPost("problems_id", array("trim"));

            $success = $contest->create();
            $contest->arrange_problems($problems_id, true);

            if ($success) {
                $this->flashSession->success("创建成功！");
                $this->response->redirect('yzoi7x/contests/list/');
            } else {
                foreach ($contest->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }

        }

    }

    public function editAction($id)
    {
        $this->view->title = "编辑作业/测验";

        $contest = Contests::findFirstById($id);
        $psid = "";
        foreach ($contest->problems() as $p)
            $psid .= $p->problems_id . "; ";
        $contest->problems_id = $psid;

        $this->view->contest = $contest;
        $this->view->form = new ContestsForm($contest);

        if (!$contest) {
            $this->flash->error("Contest does not exist " . $id);
            return $this->dispatcher->forward(
                array(
                    "action" => "list"
                )
            );
        }

        if ($this->request->isPost())
        {
            $contest->title         = $this->request->getPost("title", array("trim", "striptags"));
            $contest->start_time    = strtotime($this->request->getPost("start_time", array("int")));
            $contest->end_time      = strtotime($this->request->getPost("end_time", array("int")));
            $contest->description   = $this->request->getPost("description");
            $modifypid              = $this->request->getPost("modifypid");
            $problems_id            = $this->request->getPost("problems_id", array("trim"));

            $success = $contest->save();
            if ($modifypid == 1)
                $contest->arrange_problems($problems_id);

            if ($success) {
                $this->flash->success("修改成功！");
            } else {
                $this->flash->error($success);
            }
        }
    }

    public function listAction()
    {
        $this->view->title = "作业/测验列表";

        $numberPage = $this->request->getQuery("page", "int", 1);

        $contests = Contests::find();

        $paginator = new Paginator(array(
            'data' => $contests,
            'limit' => Contests::BACK_PER_PAGE,
            'page' => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
    }

    public function statusAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            $cid = $this->request->getQuery('contest_id', 'int');
            $contest = Contests::findFirstById($cid);
            if ($contest) {
                if ($contest->active == 'Y')
                    $contest->active = 'N';
                else
                    $contest->active = 'Y';

                if ($contest->update())
                    $this->response->setJsonContent($contest->active);
                else {
                    $msg = "";
                    foreach ($contest->getMessages() as $message) {
                        $msg .= $message;
                    }
                    $this->response->setJsonContent($msg);
                }

                return $this->response;
            }
        }
    }

    public function privateAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            $cid = $this->request->getQuery('contest_id', 'int');
            $contest = Contests::findFirstById($cid);
            if ($contest) {
                if ($contest->is_private == 'Y') {
                    $contest->is_private = 'N';
                    $msg = 'Public';
                } else {
                    $contest->is_private = 'Y';
                    $msg = 'Private';
                }

                if ($contest->update())
                    $this->response->setJsonContent($msg);
                else {
                    $msg = "";
                    foreach ($contest->getMessages() as $message) {
                        $msg .= $message;
                    }
                    $this->response->setJsonContent($msg);
                }

                return $this->response;
            }
        }
    }
}