<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Solutions.php 2015/12/18 10:48 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Solutionoldyzois Extends Model
{
    public $solution_id;

    public $problem_id;

    public $user_id;

    public $time;

    public $memory;

    public $result;

    public $language;

    public function initialize()
    {
        $this->setReadConnectionService('dbOldyzoi');

        //$this->setSource('solution');
    }

    public static function findos($olduser, $problems = null)
    {
        $sql = "SELECT
                    `solution`.*,
                    `source_code`.`source`
                FROM
                    `solution`
                INNER JOIN (SELECT
                                  `solution`.*
                               FROM `solution`
                               WHERE `solution`.`user_id` = '".$olduser."'
                                  AND `solution`.`result` = '4'
                               ORDER BY `solution`.`problem_id` ASC,
                                        `solution`.`time` ASC,
                                        `solution`.`memory` ASC,
                                        `solution`.`code_length` ASC

                    ) s
                    ON s.`solution_id` = `solution`.`solution_id`
                INNER JOIN `source_code` ON `source_code`.`solution_id` = `solution`.`solution_id`
                ";

        if ($problems) {
            $sql .= " WHERE `solution`.`problem_id` IN (" .$problems . ")";
        }
        $sql .= "GROUP BY `solution`.`problem_id`";

        $solutions = new Solutionoldyzois();

        return new Resultset(null, $solutions, $solutions->getReadConnection()->query($sql));
    }

}




















