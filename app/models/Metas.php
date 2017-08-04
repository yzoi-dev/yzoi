<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Metas.php 2015/11/20 18:43 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;

class Metas extends Model
{
    const TYPE_TAG = "tag";
    const TYPE_CATEGORY = "category";

    public $id;

    public $name;

    public $type;

    public $description;

    public $count;

    public $orders;

    public $parent;

    public function initialize()
    {

        //$this->hasMany("id", "YZOI\Models\ProblemsMetas", "metas_id");
        // 查询meta时，自动关联查询所有=metas_id的problems
        // 比如列出所有meta时都会自动查询，因影响性能而注释了
        //$this->hasManyToMany("id", "YZOI\Models\ProblemsMetas", "metas_id", "problems_id", "YZOI\Models\Problems", "id", ['alias' => 'metas_problems']);
    }

    public static function update_metas_count()
    {
        $sql = "UPDATE `metas`
                INNER JOIN (SELECT COUNT(`problems_metas`.`problems_id`) as pc, `metas_id`
                    FROM `problems_metas`
                    GROUP BY `problems_metas`.`metas_id`
                ) as pm
                ON pm.`metas_id` = `metas`.`id`
                SET `metas`.`count` = pm.pc
        ";
        $metas = new Metas();

        return $metas->getReadConnection()->execute($sql);
    }
}