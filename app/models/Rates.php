<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Rates.php 2015/12/11 20:56 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Validator\Uniqueness;

class Rates extends Model
{
    const FLAG_TOPIC = "topic";
    const FLAG_REPLY = "reply";
    const FLAG_PROBLEM = "problem";

    public $users_id;

    public $flag;

    public $some_id;

    public function validation()
    {
        $this->validate(new Uniqueness(array(
            "field"   => array('users_id', 'flag', 'some_id'),
            "message" => "You've already voted for this Thread/Problem!"
        )));
        if ($this->validationHasFailed() == true) {
            return false;
        }
    }
}