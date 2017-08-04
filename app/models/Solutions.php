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

class Solutions Extends Model
{
    const FRONT_PER_PAGE = 20;

    const STATUS_PENDING         = 0;
    const STATUS_PENDING_REJUDGE = 1;
    const STATUS_COMPLIE         = 2;
    const STATUS_REJUDGING       = 3;
    const STATUS_AC              = 4;
    const STATUS_PE              = 5;
    const STATUS_WA              = 6;
    const STATUS_TLE             = 7;
    const STATUS_MLE             = 8;
    const STATUS_OLE             = 9;
    const STATUS_RE              = 10;
    const STATUS_CE              = 11;
    const STATUS_COMPILE_OK      = 12;
    const STATUS_TEST_RUN        = 13;
    const SOLUTION_PUBLIC        = 'Y';

    public $id;

    public $problems_id;

    public $users_id;

    public $time;

    public $memory;

    public $result;

    public $language;

    public $ip;

    public $contests_id;

    public $cnum;

    public $code_length;

    public $judgetime;

    public $score;

    public $is_public;

    public function initialize()
    {
        $this->judgetime = time();
        $this->is_public = 'N';
    }

    /**
     * 找到所有Solutions，关联users_id和problems_id
     *
     * @return Resultset
     */
    public static function findAllSolutionsBySql($filter = null)
    {
        $sql = "SELECT
                    `solutions`.*,
                    `users`.name,
                    `users`.avatar,
                    p.title
                FROM
                    `solutions`
                INNER JOIN `users` ON `users`.id = `solutions`.users_id
                INNER JOIN problems p ON p.id = `solutions`.problems_id
                WHERE `solutions`.id IS NOT NULL";

        if (is_array($filter)) {
            // 有题号，但不是比赛中的题号
            if (! isset($filter['cid']) && isset($filter['pid']))
                $sql .= " AND `solutions`.problems_id = '" . $filter['pid'] . "'";

            if (isset($filter['cid'])) {
                $sql .= " AND `solutions`.contests_id = '" . $filter['cid'] . "'";
                //比赛中才有题号
                if (isset($filter['pid']))
                    $sql .= " AND `solutions`.cnum = '" . $filter['pid'] . "'";
            }/* else {
                $sql .=  " AND `solutions`.contests_id IS NULL ";
            }*/

            if (isset($filter['ulang']))
                $sql .= " AND `solutions`.language = '" . $filter['ulang'] . "'";

            if (isset($filter['result']))
                $sql .= " AND `solutions`.result = '" . $filter['result'] . "'";

            if (isset($filter['uname']))
                $sql .= " AND `users`.name = '" . $filter['uname'] . "'";
        }

        if (count($filter) == 0) {
            $sql .=  " AND `solutions`.contests_id IS NULL ";
        }

        $sql .= " ORDER BY `solutions`.id DESC";

        $solutions = new Solutions();

        return new Resultset(null, $solutions, $solutions->getReadConnection()->query($sql));
    }

    public static function find_best_solutions_for_problem($problem_id, $limit = 50)
    {
        // 相同用户只选一个最好的
        $sql = "SELECT
                    s.id,
                    s.users_id,
                    COUNT(*) as attempt,
                    s.time,
                    s.memory,
                    s.language,
                    s.code_length,
                    s.is_public,
                    u.name,
                    u.nick,
                    u.avatar
                FROM
                    `solutions` s
                INNER JOIN users u ON u.id = s.users_id
                WHERE s.problems_id = $problem_id AND s.result = 4
                GROUP BY s.id,
                    s.users_id,
                    s.time,
                    s.memory,
                    s.language,
                    s.code_length,
                    s.is_public
                ORDER BY s.time, s.memory
                LIMIT $limit";

        $solutions = new Solutions();

        return new Resultset(null, $solutions, $solutions->getReadConnection()->query($sql));
    }

    /**
     * 找一条Solutions记录，关联users_id和problems_id
     *
     * @param $solution_id
     * @return bool|Model\Resultset\ModelInterface|\Phalcon\Mvc\ModelInterface
     */
    public static function findFirstBySql($solution_id)
    {
        $sql = "SELECT
                    s.*,
                    u.name,
                    u.avatar,
                    u.nick,
                    u.school,
                    p.title,
                    cl.infor as compiles,
                    sc.source as sourcecode,
                    r.infor as runtimes
                FROM
                    `solutions` s
                INNER JOIN users u ON u.id = s.users_id
                INNER JOIN problems p ON p.id = s.problems_id
                LEFT JOIN compile_infos cl ON cl.solutions_id = $solution_id
                LEFT JOIN source_codes sc ON sc.solutions_id = $solution_id
                LEFT JOIN runtime_infos r ON r.solutions_id = $solution_id
                WHERE s.id = $solution_id
                ";

        $solution = new Solutions();

        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));
        return $result[0];
    }

    /**
     * 用户ac题目ID列表
     *
     * @param $user_id
     * @return array
     */
    public static function user_solved_problems($user_id)
    {
        $sql = "SELECT
                  DISTINCT problems_id
                  FROM `solutions`
                  WHERE users_id = $user_id
                    AND result = " . self::STATUS_AC;

        $solution = new Solutions();

        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        $rlist = array();
        foreach ($result as $p)
            array_push($rlist, $p->problems_id);

        return $rlist;
    }

    /**
     * 用户submit题目ID列表
     *
     * @param $user_id
     * @return array
     */
    public static function user_tried_problems($user_id)
    {
        $sql = "SELECT
                  DISTINCT problems_id
                  FROM `solutions`
                  WHERE users_id = $user_id";

        $solution = new Solutions();

        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        $rlist = array();
        foreach ($result as $p)
            array_push($rlist, $p->problems_id);

        return $rlist;
    }

    /**
     * 用户提交数量
     *
     * @param $user_id
     * @return bool|Model\Resultset\ModelInterface|\Phalcon\Mvc\ModelInterface
     */
    public static function number_of_submit_totoal_for_user($user_id)
    {
        $sql = "SELECT
                    COUNT(`id`) as total
                FROM `solutions`
                WHERE `solutions`.`users_id` = $user_id
        ";

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        return $result[0]->total;
    }

    /**
     * 用户AC次数（同一题可能重复AC）
     *
     * @param $user_id
     * @return bool|Model\Resultset\ModelInterface|\Phalcon\Mvc\ModelInterface
     */
    public static function number_of_solution_accept_for_user($user_id)
    {
        $sql = "SELECT
                    COUNT(`id`) as total
                FROM `solutions`
                WHERE `solutions`.`users_id` = $user_id
                    AND `solutions`.`result` = " . self::STATUS_AC ;

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        return $result[0]->total;
    }

    /**
     * 用户AC题数（同一题多次重复AC，只算1题）
     *
     * @param $user_id
     * @return bool|Model\Resultset\ModelInterface|\Phalcon\Mvc\ModelInterface
     */
    public static function number_of_problem_accept_for_user($user_id)
    {
        $sql = "SELECT
                    COUNT(DISTINCT(`problems_id`)) as total
                FROM `solutions`
                WHERE `solutions`.`users_id` = $user_id
                    AND `solutions`.`result` = " . self::STATUS_AC ;

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        return $result[0]->total;
    }

    public function user_can_access(Users $user)
    {
        if ( ! $user) return false;

        //0=pending, 1=complier etc.
        if ($this->result < 4) return false;

        if ($user->is_ultraman()) return true;

        if ($this->is_public == Solutions::SOLUTION_PUBLIC) return true;

        //if ($user->has_permission('c'.$this->id)) return true;
        if ($this->users_id == $user->id) return true;

        return false;
    }

    public function user_can_modify(Users $user)
    {
        if ( ! $user) return false;

        $access = $this->user_can_access($user);

        if (($access && $this->users_id == $user->id) ||
            ($access && $user->is_ultraman()))
            return true;

        return false;
    }

    public static function statistic_for_problem($problem_id)
    {
        $filter = array(
            'problems_id' => $problem_id
        );

        $data = array();
        $data['total'] = self::count_for_problem($filter);
        $data['submit_user'] = self::count_distinct_user($filter);

        $filter['result'] = self::STATUS_AC;
        $data['ac_user'] = self::count_distinct_user($filter);

        $data['more'] = array();
        $status = array(
            self::STATUS_AC,
            self::STATUS_PE,
            self::STATUS_WA,
            self::STATUS_TLE,
            self::STATUS_MLE,
            self::STATUS_OLE,
            self::STATUS_RE,
            self::STATUS_CE,
        );
        foreach($status as $st)
        {
            $filter['result'] = $st;
            $data['more'][$st] = self::count_for_problem($filter);
        }

        return $data;
    }

    public static function count_for_problem($filter = array())
    {
        $sql = "SELECT
                    COUNT(`id`) as total
                FROM `solutions`
        ";

        $i = 0; $total = count($filter);
        if ($total) {
            $sql .= ' WHERE ';
            foreach ($filter as $col => $value) {
                $i++;

                $sql .= $col . " = '" . $value . "' ";

                if ($i < $total) $sql .= " AND ";
            }
        }

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        return $result[0]->total;
    }

    public static function count_distinct_user($filter = array())
    {
        $sql = "SELECT
                    COUNT(DISTINCT (`users_id`)) as total
                FROM `solutions`
        ";

        $i = 0; $total = count($filter);
        if ($total) {
            $sql .= ' WHERE ';
            foreach ($filter as $col => $value) {
                $i++;

                $sql .= $col . " = '" . $value . "' ";

                if ($i < $total) $sql .= " AND ";
            }
        }

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));

        return $result[0]->total;
    }

    public static function count_submission_statistic($filter = array())
    {
        $sql = "SELECT
                    FROM_UNIXTIME(`judgetime`,'%Y,%c,%e') days,
                    COUNT(`id`) total
                FROM `solutions`
        ";

        $i = 0; $total = count($filter);
        if ($total) {
            $sql .= ' WHERE ';
            foreach ($filter as $col => $value) {
                $i++;

                $sql .= $col . " = '" . $value . "' ";

                if ($i < $total) $sql .= " AND ";
            }
        }

        $sql .= ' GROUP BY days ORDER BY days';

        $solution = new Solutions();
        $result =  new Resultset(null, $solution, $solution->getReadConnection()->query($sql));
        return $result->toArray();
    }

    public function rejudge()
    {
        $this->result = self::STATUS_PENDING_REJUDGE;
        $this->save();
    }

    public static function rejudge_problem($problem_id)
    {
        $sql = "UPDATE `solutions`
                SET `solutions`.`result` = '1'
                WHERE `solutions`.`problems_id` = $problem_id
        ";
        $solutions = new Solutions();

        return $solutions->getReadConnection()->execute($sql);
    }

    public static function find_solutions_for_contest($contest_id, $start_time, $end_time)
    {
        $sql = "SELECT
                    s.*,
                    u.name,
                    u.nick,
                    u.avatar
                FROM
                    `solutions` s
                INNER JOIN users u ON u.id = s.users_id
                WHERE s.`contests_id` = '{$contest_id}' AND s.`judgetime` >= '{$start_time}' AND s.`judgetime` <= '{$end_time}'
                ";

        $solutions = new Solutions();

        return  new Resultset(null, $solutions, $solutions->getReadConnection()->query($sql));
    }

}




















