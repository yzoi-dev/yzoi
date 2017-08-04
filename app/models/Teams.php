<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Teams.php 2016/5/6 11:01 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class Teams extends Model
{
    public $users_id;
    public $name;
    public $nick;
    public $avatar;

    public $solved = 0;
    public $time = 0;
    //public $score = 0; //这次测验总分

    protected $problem_list = array();

    public function problem_status($problem_id)
    {
        if (! array_key_exists($problem_id, $this->problem_list))
            return $this->new_problem();

        return $this->problem_list[$problem_id];
    }

    protected  function new_problem()
    {
        return array(
            'accept_at' => 0,
            'wa_count' => 0,
            'score' => 0 //每小题得分
        );
    }

    public function add($problem_id, $time, $result, $score)
    {
        if (! empty($score))
            $score = explode(',', $score);
        else {
            $score[0]=0; $score[1]=1;
        }

        if (! array_key_exists($problem_id, $this->problem_list))
            $this->problem_list[$problem_id] = $this->new_problem();

        $pdata = $this->problem_list[$problem_id];

        if ($pdata['accept_at'] > 0)
            return;

        if ($result != Solutions::STATUS_AC) {
            $pdata['wa_count']++;
            $pdata['score'] = max($pdata['score'], round($score[0]*100/$score[1]));
        } else {
            $pdata['accept_at'] = $time;
            $pdata['score'] = 100;
            $this->solved++;
            $this->time += $time + $pdata['wa_count']*1200;
        }

        $this->problem_list[$problem_id] = $pdata;
    }

}