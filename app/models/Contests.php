<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Contests.php 2015/12/13 15:10 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class Contests extends Model
{
    const FRONT_PER_PAGE = 50; // 前台每页显示记录数
    const BACK_PER_PAGE = 50; // 后台每页显示记录数

    public $id;

    public $title;

    public $start_time;

    public $end_time;

    public $active;

    public $description;

    public $is_private;

    public $password;

    public $category = 1;

    private $problem_list = null;

    public function initialize()
    {
        // contests表和problems表，通过contests_problems关联，主要是把problems表所有字段都读出来了，太费资源
        /*
        $this->hasManyToMany("id",
                    "YZOI\Models\ContestsProblems",
                    "contests_id", "problems_id",
                    "\YZOI\Models\Problems",
                    "id",
                    ['alias' => 'contestproblems']);
        */
    }

    public function problems($which = null)
    {
        if (is_null($this->problem_list)) {
            $this->problem_list = ContestsProblems::findProblemsByCId($this->id);
        }
        if (is_null($which)) {
            return $this->problem_list;
        }

        $relation = $this->problem_list[intval($which)];
        return $relation->problem_detail();
    }

    public function arrange_problems($problems_id, $new_contest = false)
    {
        //新测验不用删除，编辑时要先删除
		if ($new_contest == false)
			ContestsProblems::empty_contest($this->id);
        //后插入
        $plist = explode(';', $problems_id);
        foreach ($plist as $key => $item) {

            if ($item == '') continue;

            if (! is_numeric($item) || intval($item)< 1000) continue;

            $cp = new ContestsProblems();
            $cp->contests_id = $this->id;
            $cp->problems_id = $item;
            $cp->orders = $key;

            $cp->save();
        }
    }

    /**
     * 用户是否有权限（主要是读取Privileges数据表）
     *
     * @param Users $user
     * @return bool
     */
    public function user_can_access(Users $user)
    {
        if ( ! $user) return false;

        if ($user->is_ultraman()) return true;
        
        if ($this->is_private == 'N') return true;
		
		if ($user->has_permission('c'.$this->id)) return true;
		
		return false;
    }


    /**
     * 手动插入某一场比赛所对应得题目ID，未用！！！，改成arrange_problems()
     *
     * @param $contest_id
     * @param $problems_id
     * @return bool
     */
    public static function insertProblemsIdBySql($contest_id, $problems_id)
    {
        $problems = explode(',', $problems_id);
        $total = count($problems) - 1;

        // sql string 组合
        $sql = "INSERT INTO contests_problems VALUES ";

        foreach ($problems as $key => $pid) {
            $sql .= "( $contest_id, $pid, $key )";
            if ($key < $total)
                $sql .= ", ";
        }

        $cp = new ContestsProblems();

        return $cp->getReadConnection()->execute($sql);

    }

    /**
     * 手动更新某一场比赛所对应得题目ID，未用！！！改成arrange_problems()
     *
     * @param $contest_id
     * @param $problems_id
     * @return bool
     */
    public static function updateProblemsIdBySql($contest_id, $problems_id)
    {
        $problems = explode(',', $problems_id);
        $total = count($problems) - 1;

        $cp = new ContestsProblems();

        // 先删除
        $sql = "DELETE FROM contests_problems WHERE contests_id = $contest_id; ";

        // sql string 组合
        $sql .= "INSERT INTO contests_problems VALUES ";

        foreach ($problems as $key => $pid) {
            $sql .= "( $contest_id, $pid, $key )";
            if ($key < $total)
                $sql .= ", ";
        }

        return $cp->getReadConnection()->execute($sql);
    }

    public function amount_of_problems()
    {
        return count($this->problems());
    }

    protected function contests_solutions()
    {
        return Solutions::find_solutions_for_contest($this->id, $this->start_time, $this->end_time);
    }

    public function standing()
    {
        $solutions = $this->contests_solutions();
        $data = array();
        $start_time = $this->start_time;

        foreach ($solutions as $sss) {
            if (array_key_exists($sss->users_id, $data)) {
                $team = $data[$sss->users_id];
                $team->add($sss->cnum, $sss->judgetime - $start_time, $sss->result, $sss->score);
            } else {
                $team = new Teams();
                $team->users_id = $sss->users_id;
                $team->name = $sss->name;
                $team->avatar = $sss->avatar;
                $team->nick = $sss->nick;

                $team->add($sss->cnum, $sss->judgetime - $start_time, $sss->result, $sss->score);

                $data[$sss->users_id] = $team;
            }
        }

        usort($data, function($a, $b) {
            if ($a->solved > $b->solved)
                return false;
            if ($a->solved == $b->solved)
                if ($a->time < $b->time)
                    return false;

            return true;
        });

        return $data;
    }

}