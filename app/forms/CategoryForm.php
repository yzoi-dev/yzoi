<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: CategoryForm.php 2015/11/20 19:39 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\PresenceOf;

class CategoryForm extends FormBase
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

        $orders = new Text('orders', array(
            'class' => 'form-control'
        ));
        $orders->setDefault(0);
        $orders->setFilters(array('trim', 'int'));
        $orders->addValidator(new PresenceOf(array(
            'message' => '次序必须为整数'
        )));
        $this->add($orders);

        $description = new TextArea('description', array(
            'class' => 'form-control',
            'rows' => 5
        ));
        $this->add($description);

    }

}
