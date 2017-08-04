<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Privileges.php 2015/11/15 13:35 $
 */
namespace YZOI\Models;

use \Phalcon\Mvc\Model;

class Privileges extends Model
{
    const NAME_ADMINISTRATOR = "Administrator";
    const NAME_ULTRAMAN = "Ultraman";

    public $id;

    public $name;

    public $active;

    public $users_id;

    public function initialize()
    {
        $this->belongsTo('users_id', 'YZOI\Models\Users', 'id');
    }

    public static function member_of_contest($contest_id)
    {
        $result = array();
        $contests_list = self::find(array(
            "name = 'c" . $contest_id . "'",
            "order" => "id DESC"
        ));
        foreach ($contests_list as $item) {
            array_push($result, $item->user_id);
        }
        return $result;
    }

}