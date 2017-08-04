<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: RuntimeInfos.php 2015/12/18 10:52 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class RuntimeInfos Extends Model
{
    public $solutions_id;

    public $infor;

    public function getSource()
    {
        return "runtime_infos";
    }
}