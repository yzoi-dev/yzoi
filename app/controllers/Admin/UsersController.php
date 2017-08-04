<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: UsersController.php 2015-11-27 16:42 $
 */
namespace YZOI\Controllers\Admin;

use YZOI\Common;
use YZOI\Forms\UserForm;
use YZOI\Models\Privileges;
use YZOI\Models\Users;
use \Phalcon\Paginator\Adapter\Model as Paginator;

class UsersController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $current_user = $this->auth->getIdentity();
        if (! $current_user || ! is_object($current_user))
        {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        // 验证是否是超级管理员
        if (! $current_user->is_admin())
        {
            $this->flashSession->error("Access Deny!");
            return $this->response->redirect("users");

            //throw new Exception("Access Deny!");
        }

    }

    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'list'
        ));
    }

    public function listAction()
    {
        $this->view->title = "用户列表";

        $numberPage = $this->request->getQuery("page", "int", 1);

        $users = Users::find();

        $paginator = new Paginator(array(
            'data' => $users,
            'limit' => Users::BACK_PER_PAGE,
            'page' => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
    }

    public function usersolveAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            $user_id = $this->request->getQuery('user_id', 'int');

            $user = Users::update_user_solved_submit($user_id);

            if ($user) {
                $this->response->setContent('OK');
                return $this->response;
            }
        }
    }

    public function editAction($id)
    {
        $user = Users::findFirstById($id);

        $this->view->title = "编辑用户";
        $this->view->user = $user;
        $form = new UserForm($user);
        $this->view->form = $form;

        if ($this->request->isPost()) {
            if ($form->isValid($this->request->getPost()) == false) {
                foreach ($form->getMessages() as $message) {
                    $this->flash->error((string) $message);
                    //var_dump($this->flash);
                }
            } else {
                //$user->name         = $this->request->getPost("name", "alphanum"); //用户名不能编辑
                $user->view_perm    = $this->request->getPost("view_perm", "int");
                $password           = $this->request->getPost('password');
                $repassword         = $this->request->getPost('confirmPassword');
                if (!empty($repassword) && !empty($password) && $password == $repassword)
                    $user->password = $this->security->hash($password);
                $user->email        = $this->request->getPost("email");
                $user->nick         = $this->request->getPost("nick", "striptags");
                $user->school       = $this->request->getPost("school", "striptags");

                $privilege          = $this->request->getPost("privilege");

                // 原先是管理组，现在降级为Guest
                if (empty($privilege) && isset($user->privilege->id))
                {
                    $user_privilege = Privileges::findFirstById($user->privilege->id);

                    // 更新或插入新记录到Privileges表
                    if ($user_privilege->delete() == false) {
                        foreach ($user_privilege->getMessages() as $message) {
                            $this->flash->error((string) $message);
                        }
                    } else {
                        $this->flash->success($user->name . "已被取消管理员资格！");
                    }
                } else if (! empty($privilege)) {
                    // 要修改管理组或提升到管理组
                    if (isset($user->privilege->id)) {
                        $user_privilege = Privileges::findFirstById($user->privilege->id);
                    } else {
                        $user_privilege = new Privileges();
                        $user_privilege->active = 'Y';
                        $user_privilege->users_id = $user->id;
                    }

                    $user_privilege->name = $privilege; //新管理组名
                    $user_privilege->active = 'Y';

                    if ($user_privilege->save() == false) {
                        foreach ($user_privilege->getMessages() as $message) {
                            $this->flash->error((string) $message);
                        }
                    } else {
                        $this->flash->success($user->name . "的管理组资格修改成功！" . $user_privilege->id);
                    }

                    $user->privilege = $user_privilege;
                }

                if ($user->save() == false) {
                    foreach ($user->getMessages() as $message) {
                        $this->flash->error((string) $message);
                    }
                } else {
                    $this->flash->success("更新成功！");
                }
            }
        }
    }
}