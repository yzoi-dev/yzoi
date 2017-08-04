<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ReplyForm.php 2015/12/10 22:09 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Validation\Validator\Numericality;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class ReplyForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity)) {
            $id = new Hidden('id');
            $this->add($id);
        }

        $content = new TextArea('content', array(
            'class' => 'form-control thinkermdeditor'
        ));
        $this->add($content);
    }
}