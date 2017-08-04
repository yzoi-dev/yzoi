<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: RatesController.php 2015/12/12 11:10 $
 */
namespace YZOI\Controllers;

use YZOI\Models\Problems;
use YZOI\Models\Rates;
use YZOI\Models\Replys;
use YZOI\Models\Topics;

class RatesController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize();

        $this->view->disable();
    }

    public function indexAction()
    {
        $user = $this->auth->getIdentity();
        if (!$user || !is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        if ($this->request->isAjax())
        {
            $uid = $user->id;
            $sid = $this->request->getQuery("sid", "int");
            $type = $this->request->getQuery("type");
            $mark = $this->request->getQuery("mark");

            $rate = Rates::findFirst(array(
                'conditions' => "users_id = ?0 and flag = ?1 and some_id = ?2",
                'bind' => array(0 => $uid, 1 => $type, 2 => $sid)
            ));

            if ($rate)
            {
                $this->response->setJsonContent(array(
                    'success' => false,
                    'data' => "You've already rated"
                ));
            } else {
                // 添加到rates表
                $rate = new Rates();
                $rate->users_id = $uid;
                $rate->some_id = $sid;
                $rate->flag = $type;

                // 添加到topics/replys/problems表
                switch ($type) {
                    case 'topic' :
                        Topics::plusVoteCountBySql($sid);
                        break;
                    case 'reply' :
                        Replys::plusVoteCountBySql($sid);
                        break;
                    case 'problem' :
                        Problems::plusVoteCountBySql($sid, $mark);
                        break;
                }

                if ($rate->create()) {
                    $this->response->setJsonContent(array(
                        'success' => true,
                        'data' => 'Rated'
                    ));
                } else {
                    $this->response->setJsonContent("Fail");
                }
            }
            return $this->response;
        }
    }
}