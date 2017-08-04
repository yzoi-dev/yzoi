<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: UserForm.php 2015-11-27 17:42 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Select;
use Phalcon\Validation\Validator\Confirmation;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;

class UserForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity))
        {
            $id = new Hidden('id');
            $this->add($id);
        }

        $name = new Text('name', array(
            'class' => 'form-control',
            'readonly' => 'readonly'
        ));
        $name->setFilters(array('string', 'trim'));
        $name->addValidators(array(
            new PresenceOf(array(
                'message' => 'The name is required'
            )),
            new StringLength(array(
                'min' => 4,
                'messageMinimum' => 'Username is too short. Minimum 4 characters'
            ))
        ));
        $this->add($name);

        $view_perm = new Text('view_perm', array(
            'class' => 'form-control'
        ));
        $this->add($view_perm);

        // Email
        $email = new Text('email', array(
            'class' => 'form-control'
        ));
        $email->addValidators(array(
            new PresenceOf(array(
                'message' => 'The e-mail is required'
            )),
            new Email(array(
                'message' => 'The e-mail is not valid'
            ))
        ));
        $this->add($email);

        // Password
        $password = new Password('password', array(
            'class' => 'form-control'
        ));
        $this->add($password);

        // Confirm Password
        $confirmPassword = new Password('confirmPassword', array(
            'class' => 'form-control'
        ));
        $this->add($confirmPassword);

        // 学校
        $school = new Text('school', array(
            'class' => 'form-control',
            'placeholder' => '学校名称'
        ));
        $school->addValidators(array(
            new PresenceOf(array(
                'message' => 'The name is required'
            ))
        ));
        $this->add($school);

        // 昵称
        $nick = new Text('nick', array(
            'class' => 'form-control',
            'placeholder' => '用户昵称'
        ));
        $this->add($nick);

        $status = new Select('status', array(
            'deactivity' => 'deactivity',
            'activity' => 'activity'
        ),array(
            'class' => 'form-control',
        ));
        $this->add($status);

    }
}