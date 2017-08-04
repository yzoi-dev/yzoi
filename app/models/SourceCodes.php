<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: SourceCodes.php 2015/12/18 10:52 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class SourceCodes Extends Model
{
    public $solutions_id;

    public $source;

    public function getSource()
    {
        return "source_codes";
    }

    public static function insertCodeById($solution_id, $code)
    {
        $sql = "INSERT INTO source_codes VALUES ($solution_id, '$code')";

        $sc = new SourceCodes();

        return $sc->getReadConnection()->execute($sql);
    }

}