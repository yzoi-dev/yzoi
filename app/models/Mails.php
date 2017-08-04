<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Mails.php 2016-03-04 17:20 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Mails extends Model
{
    const LIST_PER_PAGE = 50;
    const SHOW_PER_PAGE = 50;

    public $id;

    public $flag;

    public $to_user;
    public $from_user;
    public $content;
    public $unread;
    public $in_date;

    public function initialize()
    {
        //$this->hasOne('');
    }

    public static function findMailListByOwnerId($user_id)
    {
        // 两次joinusers表，感觉没有if函数的效率高
        /*
        $sql = "SELECT
                    `mails`.*,
                    `tu`.`name` as tu_name,
                    `tu`.`avatar` as tu_avatar,
                    `fu`.`name` as fu_name,
                    `fu`.`avatar` as fu_avatar
                FROM `mails`
                INNER JOIN `users` as `tu` ON `tu`.`id` = `mails`.`to_user`
                INNER JOIN `users` as `fu` ON `fu`.`id` = `mails`.`from_user`
                WHERE `mails`.`parent` = 0 AND
                      `mails`.`is_delete` = 0 AND
                      (`mails`.`from_user` = $user_id OR `mails`.`to_user` = $user_id)
                ORDER BY `mails`.`in_date` DESC
        ";*/

        //group by不能实现组内排序，造成读到的都是最老（第一条）的私信
        /**
        $sql = "SELECT
                    `mails`.*,
                    `users`.`id` as display_id,
                    `users`.`name`,
                    `users`.`avatar`,
                    MAX(`mails`.`in_date`) as maxdate
                FROM `mails`
                INNER JOIN `users`ON
                    IF(`mails`.`to_user` = $user_id, `mails`.`from_user`, `mails`.`to_user`) = `users`.`id`
                WHERE `mails`.`from_user` = $user_id OR `mails`.`to_user` = $user_id
                GROUP BY `mails`.`flag` HAVING `mails`.`in_date` = maxdate
                ORDER BY `mails`.`in_date` DESC
        "; */
        // 用子查询实现组内排序
        $sql = "SELECT
                    `mails`.*,
                    `users`.`id` as display_id,
                    `users`.`name`,
                    `users`.`avatar`
                FROM (SELECT * FROM `mails`
                        WHERE `mails`.`from_user` = $user_id OR `mails`.`to_user` = $user_id
                        ORDER BY `mails`.`in_date` DESC ) as mails
                INNER JOIN `users`ON
                    IF(`mails`.`to_user` = $user_id, `mails`.`from_user`, `mails`.`to_user`) = `users`.`id`
                GROUP BY `mails`.`flag`
                ORDER BY `mails`.`in_date` DESC
        ";

        $mails = new Mails();

        return new Resultset(null, $mails, $mails->getReadConnection()->query($sql));
    }

    public static function findChatsByOwnerId($user_id)
    {
        $sql = "SELECT
                    `mails`.*,
                    `users`.`id` as display_id,
                    `users`.`name`,
                    `users`.`avatar`
                FROM `mails`
                INNER JOIN `users`ON
                    IF(`mails`.`to_user` = $user_id, `mails`.`from_user`, `mails`.`to_user`) = `users`.`id`
                WHERE `mails`.`is_delete` = 0 AND
                      (`mails`.`from_user` = $user_id OR `mails`.`to_user` = $user_id)
                ORDER BY `mails`.`in_date` ASC
        ";

        $mails = new Mails();

        return new Resultset(null, $mails, $mails->getReadConnection()->query($sql));
    }
}