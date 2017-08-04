<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: CompileInfos.php 2015/12/24 9:26 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class CompileInfos Extends Model
{
    public $solutions_id;

    public $infor;

    public function getSource()
    {
        return "compile_infos";
    }
}