<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: LoginForm.php 2015/11/13 19:30 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Identical;

class LoginForm extends FormBase
{
    public function initialize()
    {
        parent::initialize();

        // Username
        $username = new Text('name', array(
            'class' => 'form-control input-lg',
            'placeholder' => 'Username'
        ));
        $username->addValidator(new PresenceOf(array(
            'message' => '用户名未输入'
        )));
        $this->add($username);

        // Password
        $password = new Password('password', array(
            'class' => 'form-control input-lg',
            'placeholder' => 'Password'
        ));
        $password->addValidator(new PresenceOf(array(
            'message' => 'The password is required'
        )));
        $password->clear();
        $this->add($password);

        // Remember
        $remember = new Check('remember', array(
            'value' => 'yes'
        ));
        $this->add($remember);
    }

}