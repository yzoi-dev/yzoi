<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: TopicsController.php 2015/12/7 20:59 $
 */
namespace YZOI\Controllers;

use YZOI\Forms\ReplyForm;
use YZOI\Forms\TopicForm;
use YZOI\Models\Replys;
use YZOI\Models\Topics;
use \Phalcon\Paginator\Adapter\Model as Paginator;
use YZOI\Parser;

class TopicsController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->view->title = "YZOI社区";

        $this->view->additionalCss = array(
            'bsmd/bsmd.css',
            'assets/css/katex.min.css'
        );
        $this->view->additionalJS = array(
            'assets/js/katex.min.js',
            'bsmd/ace/ace.js',
            'bsmd/ace/ext-static_highlight.js',
            'bsmd/bsmd.js',
            'bsmd/marked.min.js',
            'bsmd/fronteditor.js',
            'assets/js/jquery.validate.js',
            'assets/js/yzoitex.js',
        );
    }

    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'list'
        ));
    }

    public function listAction($flag = null)
    {
        $numberPage = $this->request->getQuery("page", "int", 1);
        $problemId = $this->request->getQuery("pid");

        $topics = Topics::findAllTopicsBySql($flag, $problemId);

        $paginator = new Paginator(array(
            'data' => $topics,
            'limit' => 12,
            'page' => $numberPage
        ));
        $this->view->page = $paginator->getPaginate();
        $this->view->form = new TopicForm();
        $this->view->parser = new Parser();
    }

    public function createAction()
    {
        $user = $this->auth->getIdentity();
        if (!$user && !is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        $this->view->title = "创建新话题";
        $form = new TopicForm();
        $this->view->form = $form;

        if ($this->request->isPost())
        {
            if ($form->isValid($this->request->getPost()) == false)
            {
                foreach ($form->getMessages() as $message) {
                    $this->flash->error((string) $message);
                    //var_dump($this->flash);
                }
            } else {
                $topic = new Topics();

                $topic->users_id    = $user->id;
                $topic->flag        = $this->request->getPost("flag");
                $topic->title       = $this->request->getPost("title", array("trim"));
                $problems_id        = $this->request->getPost("problems_id", "int");
                $topic->content     = $this->request->getPost("content", array("trim"));
                $topic->datetimes   = time();
                $topic->view_count  = 1;

                // 就不判断是不是存在这个题目了
                if ($problems_id != null & $problems_id > 1000)
                    $topic->problems_id = $problems_id;

                if (strlen(trim($topic->content)) < 3) {
                    $this->flashSession->error("无内容！？");
                    return $this->response->redirect("topics/list");
                }


                if ($topic->create() == false) {
                    foreach ($topic->getMessages() as $message) {
                        $this->flash->error((string) $message);
                    }
                } else {
                    $this->flashSession->success("话题创建成功！");
                    $this->response->redirect("topics/show/" . $topic->id);
                }
            }
        }

    }

    public function editAction($type, $id)
    {
        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        switch ($type) {
            case 'topic' :
                $thread = Topics::findFirstById($id);
                $form = new TopicForm($thread);
                break;
            case 'reply' :
                $thread = Replys::findFirstById($id);
                $form = new ReplyForm($thread);
                break;
            default :
                $thread = Replys::findFirstById($id);
                $form = new ReplyForm($thread);
                break;
        }

        if ( ! $thread->user_can_modify($user)) {
            throw new \Exception('Thread Access Deny!');
        }

        $this->view->thread = $thread;
        $this->view->title = "修改话题" . $thread->id;
        $this->view->form = $form;

        if ($this->request->isPost()) {
            if ($form->isValid($this->request->getPost()) == false)
            {
                foreach ($form->getMessages() as $message) {
                    $this->flash->error((string) $message);
                    //var_dump($this->flash);
                }
            } else {
                $thread->flag        = $this->request->getPost("flag");
                $thread->title       = $this->request->getPost("title", array("trim"));
                $problems_id        = $this->request->getPost("problems_id", "int");
                $thread->content     = $this->request->getPost("content", array("trim"));

                // 就不判断是不是存在这个题目了
                if ($problems_id != null & $problems_id > 1000)
                    $thread->problems_id = $problems_id;

                if (strlen(trim($thread->content)) < 3) {
                    $this->flashSession->error("无内容！？");
                    return $this->response->redirect("topics/show/" . $thread->id);
                }

                if ($thread->save() == false) {
                    foreach ($thread->getMessages() as $message) {
                        $this->flash->error((string) $message);
                    }
                } else {
                    $this->flashSession->success("话题修改成功！");
                    if (isset($thread->topics_id))
                        return $this->response->redirect("topics/show/" . $thread->topics_id);
                    else
                        return $this->response->redirect("topics/show/" . $thread->id);
                }
            }
        }
    }

    public function showAction($id)
    {
        $topic = Topics::findFirstBySql('topics.id = ?', array($id));

        $replies = Replys::findAllRepliesBySql($topic->id);
        $numberPage = $this->request->getQuery("page", "int", 1);

        $paginator = new Paginator(array(
            'data' => $replies,
            'limit' => 5,
            'page' => $numberPage
        ));

        $parser = new Parser();
        $this->view->parser = $parser;

        $this->view->page = $paginator->getPaginate();

        $this->view->topic = $topic;
        $form = new ReplyForm();
        $this->view->form = $form;

        if ($this->request->isPost())
        {
            $user = $this->auth->getIdentity();
            if (! $user || ! is_object($user)) {
                $this->flashSession->error("请先登录");
                return $this->response->redirect("users/login");
            }

            if ($form->isValid($this->request->getPost()) == false)
            {
                foreach ($form->getMessages() as $message) {
                    $this->flash->error((string) $message);
                    //var_dump($this->flash);
                }
            } else {
                $reply = new Replys();

                $reply->users_id    = $user->id;
                $reply->topics_id   = $this->request->getPost("topics_id", "int");
                $reply->content     = $this->request->getPost("content", array("trim"));
                $reply->datetimes   = time();

                if (strlen(trim($reply->content)) < 3) {
                    $this->flashSession->error("无内容！？");
                    return $this->response->redirect("topics/show/" . $reply->topics_id);
                }

                if ($reply->create() == false) {
                    foreach ($reply->getMessages() as $message) {
                        $this->flash->error((string) $message);
                    }
                } else {
                    // 还得更新Topic表中的回复数和最后回复时间
                    Topics::updateLastReplyBySql($topic->id, $reply->id);

                    $this->flashSession->success("话题回复成功！");
                    $this->response->redirect("topics/show/" . $reply->topics_id);
                }
            }
        } else {
            // 不是提交，就是浏览话题，浏览数要更新
            if (isset($topic))
                Topics::updateViewCountBySql($topic->id);
        }
    }

    public function deleteAction() {
        /*$replies = Replys::findAllRepliesBySql(14);
        if (count($replies)) {
            foreach ($replies as $rep) {
                echo $rep->id;
                $rep->delete();
            }
        } else {
            echo "yes!";
        }*/
        /*$topics = Topics::find();
        foreach ($topics as $topic) {
            if (is_null($topic->lastreply_id)) {
                $replies = Replys::findAllRepliesBySql($topic->id);
                //echo count($replies);
                //$last_reply = $replies->getLast();
                //echo $last_reply->content;
                //var_dump(is_($replies));
                //echo "\n";
                //$lr_id = end(Replys::findAllRepliesBySql($topic->id))->id;
                if ($replies->count()) {
                    //echo $replies->getLast()->id;
                    $topic->lastreply_id = $replies->getLast()->id;
                    $topic->save();
                }
            }
        }*/
        function _error($object) {
            echo "Sorry, we can't delete the topic right now: \n";

            foreach ($object->getMessages() as $message) {
                echo $message, "\n";
            }
        }

        if ($this->request->isPost()) {
            $user = $this->auth->getIdentity();
            if (! $user || ! is_object($user)) {
                $this->flashSession->error("请先登录");
                return $this->response->redirect("users/login");
            }

            $topic_id = $this->request->getPost("topic_id", array("trim", "int"));

            $topic = Topics::findFirst($topic_id);

            if ($topic != false) {
                $replies = Replys::findAllRepliesBySql($topic_id);
                foreach ($replies as $reply) {
                    if ($reply->delete() == false) {
                        _error($reply);
                    }
                }
                if ($topic->delete() == false) {
                    _error($topic);
                } else {
                    $this->flashSession->success("删除成功！");
                    return $this->response->redirect("topics");
                }
            }
        }
    }

    public function testmdAction()
    {
        $this->view->title = "测试markdown-plus";
        $form = new TopicForm();
        $this->view->form = $form;
    }

    public function thinkmdAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);

        $this->view->title = "测试markdown-plus";
        $form = new TopicForm();
        $this->view->form = $form;


    }

}



























