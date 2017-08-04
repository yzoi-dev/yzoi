<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Topics.php 2015/12/7 20:51 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Topics extends Model
{
    const FRONT_PER_PAGE = 30; // 前台每页显示记录数

    public $id;

    public $flag;

    public $problems_id;

    public $users_id;

    public $title;

    public $content;

    public $reply_count;

    public $view_count;

    public $favorite_count;

    public $vote_count;

    public $orders;

    public $lastreply_id;

    /*public function initialize()
    {
        $this->hasOne('id', "Users", "users_id");
        $this->hasOne('id', "Problems", "problems_id");
    }*/

    /*public function getLastReply() {
        if ($this->lastreply_id) {
            return Replys::findFirst($this->lastreply_id);
        } else {
            return null;
        }
    }*/

    public function getLastReplyInfo() {
        if ($this->lastreply_id) {
            $last_reply = Replys::findFirst($this->lastreply_id);
            $lr_user = Users::findFirst($last_reply->users_id);
            return array(
                "user_id" => $last_reply->users_id,
                "user_name" => $lr_user->name,
                "reply_time" => $last_reply->datetimes);
        } else {
            return null;
        }
    }

    public static function findAllTopicsBySql($flag = null, $pid = null, $limit = 30)
    {
        $sql = "SELECT
                    t.*,
                    u.name,
                    u.avatar,
                    p.title as problems_title
                FROM
                    `topics` t
                INNER JOIN users u ON u.id = t.users_id
                LEFT JOIN problems p ON p.id = t.problems_id
                WHERE t.id IS NOT NULL ";
        if ($flag) {
            $sql .= " AND `t`.`flag` = '$flag' ";
        }
        if ($pid) {
            $sql .= " AND `t`.`problems_id` = '$pid' ";
        }
        $sql .= " ORDER BY t.orders DESC, t.datetimes DESC
                LIMIT $limit";

        $topics = new Topics();

        return new Resultset(null, $topics, $topics->getReadConnection()->query($sql));
    }

    public static function findFirstBySql($conditions = null, $parameters = null)
    {
        $sql = "SELECT
                    topics.*,
                    u.name,
                    u.avatar,
                    p.title as problems_title
                FROM
                    `topics`
                INNER JOIN users u ON u.id = topics.users_id
                LEFT JOIN problems p ON p.id = topics.problems_id
                WHERE $conditions
                ";

        $topics = new Topics();
        $result = new Resultset(null, $topics, $topics->getReadConnection()->query($sql, $parameters));
        return $result[0];
    }

    public static function updateViewCountBySql($topic_id)
    {
        $sql = "UPDATE topics SET view_count = view_count+1 WHERE id = $topic_id";

        $topics = new Topics();

        return $topics->getReadConnection()->execute($sql);
    }

    public static function updateLastReplyBySql($topic_id, $lastreply_id)
    {
        $sql = "UPDATE topics SET
                  reply_count = reply_count+1,
                  lastreply_id = $lastreply_id
                  WHERE id = $topic_id";

        $topics = new Topics();

        return $topics->getReadConnection()->execute($sql);
    }

    public static function plusVoteCountBySql($topic_id)
    {
        $sql = "UPDATE topics SET
                  vote_count = vote_count+1
                  WHERE id = $topic_id";

        $topics = new Topics();

        return $topics->getReadConnection()->execute($sql);
    }

    public function user_can_modify(Users $user)
    {
        if ($user && $user->is_ultraman()) return true;

        if ($user && $user->id == $this->users_id) return true;

        return false;
    }

    /*public function user_can_delete(Users $user) {
        if ($user && $user->is_ultraman())
            return true;
    }*/

}