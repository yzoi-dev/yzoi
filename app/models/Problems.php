<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Problems.php 2015/11/15 17:55 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Problems Extends Model
{
    const FRONT_PER_PAGE = 100; // 前台每页显示记录数
    const FRONT_SEARCH_PER_PAGE = 50; // 前台搜索页每页显示记录数
    const FRONT_METAS_PER_PAGE = 50; // 前台分类/标签搜索页每页显示记录数
    const BACK_PER_PAGE = 100; // 后台每页显示记录数
    const PROBLEM_ACTIVE = 'Y';

    public $id;

    public $view_perm;

    public $title;

    public $description;

    public $pdfname;

    public $sample_input;

    public $sample_output;

    public $spj;

    public $hint;

    public $sources;

    public $create_at;

    public $modify_at;

    public $time_limit;

    public $memory_limit;

    public $active;

    public $accepted;

    public $submit;

    public $solved;

    public $difficulty;

    public $vote_count;

    public function initialize()
    {
        //$this->hasMany("id", "YZOI\Models\ProblemsMetas", "problems_id", ['alias' => 'this_problems_metas']);
        $this->hasManyToMany("id", "YZOI\Models\ProblemsMetas", "problems_id", "metas_id", "YZOI\Models\Metas", "id", ['alias' => 'problems_metas']);
    }

    public function data_dir()
    {
        $data_dir = $this->getDI()->get('config')->onlinejudge->data_dir;
        return $data_dir . $this->id;
    }

    /**
     * @param $metas_id 分类id
     * @param string $condition 其他查询条件
     * @param bool|false $including_child 是否包含所有子类，TODO: 目前只能查询到直接孩子结点，无法查询孩子的孩子结点
     * @return Resultset
     */
    public static function findByMetasId($metas_id, $condition = '', $including_child = false)
    {
        //三表联查
        $sql = "SELECT
                    `problems`.id,
                    `problems`.view_perm,
                    `problems`.title,
                    `problems`.spj,
                    `problems`.sources,
                    `problems`.active,
                    `problems`.accepted,
                    `problems`.submit,
                    `problems`.solved,
                    `problems`.difficulty,
                    `problems`.vote_count,
                    `metas`.id as metasid,
                    `metas`.name,
                    `metas`.count
                FROM `problems`
                INNER JOIN `problems_metas` ON `problems_metas`.problems_id = `problems`.id
                INNER JOIN `metas` ON `problems_metas`.metas_id = `metas`.id";
        if ($including_child)
            $sql .= " WHERE `metas`.`id` = $metas_id OR `metas`.parent = $metas_id";
        else
            $sql .= " WHERE `metas`.id = $metas_id";

        if ($condition !== '') {
            $sql .= " AND " . $condition;
        }
        $sql .= "GROUP BY `problems`.`id`,
                     `problems`.view_perm,
                     `problems`.title,
                     `problems`.spj,
                     `problems`.sources,
                     `problems`.active,
                     `problems`.accepted,
                     `problems`.submit,
                     `problems`.solved,
                     `problems`.difficulty,
                     `problems`.vote_count,
                     metasid
                 ORDER BY `problems`.id";

        $problems = new Problems();

        return new Resultset(null, $problems, $problems->getReadConnection()->query($sql));
    }


    public static function plusVoteCountBySql($problem_id, $mark)
    {
        $sql = "UPDATE problems SET
                  difficulty = (difficult * vote_count + $mark) / (vote_count + 1),
                  vote_count = vote_count+1
                  WHERE id = $problem_id";

        $problems = new Problems();

        return $problems->getReadConnection()->execute($sql);
    }

    /**
     * 最大的题目ID
     *
     * @return bool|Model\Resultset\ModelInterface|\Phalcon\Mvc\ModelInterface
     */
    public static function max_problem_id()
    {
        $sql = "SELECT MAX(`problems`.`id`) as maxid FROM `problems` ";

        $problem = new Problems();
        $result = new Resultset(null, $problem, $problem->getReadConnection()->query($sql));
        return $result[0]->maxid;
    }

    /*
    public static function is_in_contest($problem_id)
    {
        $now = time();
        $sql = "SELECT
                    `problems`.`id`
                FROM `problems`
                WHERE `problems`.`id` = $problem_id  AND `problems`.`active`='Y'
                    AND `problems`.`id` NOT IN (SELECT
                                                  cp.`problems_id`
                                                FROM `contests_problems` as cp
                                                WHERE cp.`contests_id` IN (SELECT
                                                                            c.`id` FROM `contests` as c
                                                                          WHERE c.`end_time`>'$now' OR c.`is_private`='Y'))
        ";

        $problems = new Problems();

        $result =  new Resultset(null, $problems, $problems->getReadConnection()->query($sql));

        return $result ? true : false;
    }*/

    public static function is_in_contest($problem_id)
    {
        $now = time();
        $sql = "SELECT
                    `contests_problems`.*
                FROM `contests_problems`
                Inner JOIN `contests` ON `contests`.`id` = `contests_problems`.`contests_id`
                    AND `contests`.`end_time` > \"$now\"
                    AND `contests`.`active` = 'Y'
                WHERE `contests_problems`.`problems_id` = \"$problem_id\"
        ";

        $problems = new Problems();

        $result = new Resultset(null, $problems, $problems->getReadConnection()->query($sql));

        return $result;
    }

    public function user_can_access(Users $user)
    {
        if ($user && $user->is_ultraman()) return true;

        if ($this->active != self::PROBLEM_ACTIVE) return false;

        if ($user && $user->view_perm >= $this->view_perm) return true;

        return false;
    }

    public function statistic()
    {
        return Solutions::statistic_for_problem($this->id);
    }

    public function best_solutions($limit = 50)
    {
        return Solutions::find_best_solutions_for_problem($this->id, $limit);
        //return array();
    }

    public function rejudge()
    {
        return Solutions::rejudge_problem($this->id);
    }

}