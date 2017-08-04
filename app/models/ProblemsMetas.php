<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ProblemsMetas.php 2015/11/22 10:40 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class ProblemsMetas extends Model
{
    public $problems_id;

    public $metas_id;

    public function initialize()
    {
        $this->belongsTo("problems_id", "YZOI\Models\Problems", "id", ['alias' => 'problems']);
        $this->belongsTo("metas_id", "YZOI\Models\Metas", "id", ['alias' => 'metas']);
    }
}