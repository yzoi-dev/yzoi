<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: MailsController.php 2016-03-07 14:47 $
 */
namespace YZOI\Controllers;

use YZOI\Models\Mails;
use YZOI\Models\Users;

class MailsController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize();
    }

    public function indexAction() {
        return $this->response->redirect("mails/inbox");
    }

    public function sendAction() {
        if ($this->request->isPost()) {
            $loginUser = $this->auth->getIdentity();

            $uid = $this->request->getPost("uid", array("int"));
            $username = $this->request->getPost("name", array("trim"));
            $content = $this->request->getPost("content", array("trim", "striptags"));
            $content_len = mb_strlen($content,'UTF-8');

            if (!$uid) {
                $to_user = Users::findFirst(
                    array(
                        "name = '$username'"
                    )
                );
                //"conditions" => "name = ?0",
                //"bind" => [$username],
            }

            if (($to_user || $uid) && ($content_len > 0) && ($content_len <= 250)) {
                $uid = ($uid>0) ? $uid : $to_user->id;
                $newmail = new Mails();
                $newmail->to_user = $uid;
                $newmail->from_user = $loginUser->id;
                $newmail->flag = ($uid < $loginUser->id) ? ($uid . "," . $loginUser->id) : ($loginUser->id . "," . $uid);
                $newmail->content = $content;
                $newmail->in_date = time();

                if ($newmail->create()) {
                    $this->flashSession->success("给" . $username . "的邮件发送成功！");
                } else {
                    foreach ($newmail->getMessages() as $message) {
                        $this->flash->error($message);
                    }
                }
            } else {
                $this->flashSession->error("用户" . $username . "不存在！或者字数不对");
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
            return $this->response->redirect("mails/inbox");
        }
    }


    public function inboxAction() {

        $loginUser = $this->auth->getIdentity();

        if (! is_object($loginUser)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        $this->view->user = $loginUser;

        $maillist = Mails::findMailListByOwnerId($loginUser->id);
        $this->view->maillist = $maillist;
        $this->view->title = "Inbox";

        $this->view->additionalJS = array(
            'assets/js/jquery.validate.js'
        );
    }

    public function viewAction($user_id) {
        $loginUser = $this->auth->getIdentity();

        if (! is_object($loginUser)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        $this->view->user = $loginUser;

        $mails = Mails::find(array(
            "conditions" => "from_user = ?0 and to_user = ?1 or from_user = ?2 and to_user = ?3",
            "bind" => [$loginUser->id, $user_id, $user_id, $loginUser->id],
            "order" => "in_date asc"
        ));
        $chat_user = Users::findFirstById($user_id);
        $this->view->mails = $mails;
        $this->view->chat_user = $chat_user;
        $this->view->title = "与 " . $chat_user->name . " 的邮件";

        $this->view->additionalJS = array(
            'assets/js/jquery.validate.js'
        );

        $loginUser->clearUnreadMails($user_id);
    }

    public function writeAction($username = null) {
        $this->view->title = "Write Mail";
        
        if ($username) {
            $this->view->username = $username;
        }
    }
}