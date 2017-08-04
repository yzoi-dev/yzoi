<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ContestsProblems.php 2015/12/13 15:12 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Validator\Uniqueness;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;
use YZOI\Common;

class ContestsProblems extends Model
{
    public $contests_id;

    public $problems_id;

    public $orders;

    private $detail = null;

    public function initialize()
    {
        //$this->belongsTo("problems_id", "YZOI\Models\Problems", "id");
    }

    public function validation()
    {
        $this->validate(new Uniqueness(array(
            "field"   => array('contests_id', 'problems_id'),
            "message" => "This problem already exists in the Contest!"
        )));
        if ($this->validationHasFailed() == true) {
            return false;
        }
    }

    public static function findProblemsByCId($contest_id)
    {
        $sql = "SELECT
                    `contests_problems`.*,
                    `problems`.title
                FROM `contests_problems`
                INNER JOIN `problems` ON `problems`.id = `contests_problems`.problems_id
                WHERE `contests_problems`.contests_id = $contest_id
                ORDER BY `contests_problems`.orders
        ";

        $problems = new ContestsProblems();

        return new Resultset(null, $problems, $problems->getReadConnection()->query($sql));
    }

    public function problem_detail()
    {
        if (is_null($this->detail)) {
            $this->detail = Problems::findFirstById($this->problems_id);
        }
        return $this->detail;
    }

    public function display_order()
    {
        return Common::contest_pid($this->orders);
    }

    public static function empty_contest($contest_id)
    {
        $sql = "DELETE FROM `contests_problems` WHERE `contests_id` = $contest_id";

        $cp = new ContestsProblems();

        return $cp->getReadConnection()->execute($sql);
    }

}