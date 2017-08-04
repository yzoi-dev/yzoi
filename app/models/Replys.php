<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Replys.php 2015/12/10 22:05 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Replys extends Model
{
    const FRONT_PER_PAGE = 20; // 前台每页显示记录数

    public $id;

    public $topics_id;

    public $users_id;

    public $content;

    public $is_block;

    public $is_best;

    public $vote_count;

    public $datetimes;

    public static function findAllRepliesBySql($topic_id)
    {
        $sql = "SELECT
                    r.*,
                    u.name,
                    u.avatar
                FROM
                    `replys` r
                INNER JOIN users u ON u.id = r.users_id
                WHERE r.topics_id = $topic_id
                ORDER BY r.datetimes
                ";
        $replies = new Replys();

        return new Resultset(null, $replies, $replies->getReadConnection()->query($sql));
    }

    public static function plusVoteCountBySql($reply_id)
    {
        $sql = "UPDATE replys SET
                  vote_count = vote_count+1
                  WHERE id = $reply_id";

        $replies = new Replys();

        return $replies->getReadConnection()->execute($sql);
    }

    public function user_can_modify(Users $user)
    {
        if ($user && $user->is_ultraman()) return true;

        if ($user && $user->id >= $this->users_id) return true;

        return false;
    }
}