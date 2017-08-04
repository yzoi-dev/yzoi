<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ContestsForm.php 2015/12/13 15:20 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Radio;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\TextArea;

class ContestsForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity->id)) {
            $id = new Hidden('id');
            $this->add($id);

            $entity->start_time = date('Y-m-d H:00:00', $entity->start_time);
            $entity->end_time = date('Y-m-d H:00:00', $entity->end_time);
        }

        //var_dump($entity);

        $title = new Text('title', array(
            'class' => 'form-control'
        ));
        $this->add($title);

        // Radio貌似不成熟
        /**
        $is_private = new Radio('is_private', array(
            'class' => 'px'
        ));
        $this->add($is_private);
         */

        $description = new TextArea('description', array(
            'class' => 'form-control'
        ));
        $this->add($description);

        $start_time = new Text('start_time', array(
            'class' => 'form-control'
        ));
        $start_time->setDefault(date('Y-m-d H:00:00'));//当前时间的整点
        $this->add($start_time);

        $end_time = new Text('end_time', array(
            'class' => 'form-control'
        ));
        $end_time->setDefault(date('Y-m-d H:00:00', time() + 604800));//一周后的整点
        $this->add($end_time);

        // 因为不是contest的成员变量，编辑时没法显示其value

        $problems_id = new Text('problems_id', array(
            'class' => 'form-control'
        ));
        $this->add($problems_id);

    }


}