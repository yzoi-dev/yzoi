<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: TagForm.php 2015/11/21 17:58 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Validation\Validator\PresenceOf;

class TagForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity)) {
            $id = new Hidden('id');
            $this->add($id);
        }

        $name = new Text('name', array(
            'class' => 'form-control'
        ));
        $name->setFilters(array('string', 'trim'));
        $name->addValidator(new PresenceOf(array(
            'message' => '名称必须要填写！'
        )));
        $this->add($name);
    }
}