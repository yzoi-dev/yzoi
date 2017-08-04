<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: RegisterForm.php 2015/11/13 20:00 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Check;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\Identical;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Validation\Validator\Confirmation;

class ResetForm extends FormBase
{

    public function initialize()
    {
        parent::initialize();

        // Password
        $password = new Password('password', array(
            'class' => 'form-control',
            'placeholder' => 'Password'
        ));
        $password->addValidators(array(
            new PresenceOf(array(
                'message' => 'The password is required'
            )),
            new StringLength(array(
                'min' => 5,
                'messageMinimum' => 'Password is too short. Minimum 5 characters'
            )),
            new Confirmation(array(
                'message' => 'Password doesn\'t match confirmation',
                'with' => 'confirmPassword'
            ))
        ));
        $this->add($password);

        // Confirm Password
        $confirmPassword = new Password('confirmPassword', array(
            'class' => 'form-control',
            'placeholder' => 'Confirm Password'
        ));
        $confirmPassword->addValidators(array(
            new PresenceOf(array(
                'message' => 'The confirmation password is required'
            ))
        ));
        $this->add($confirmPassword);

    }

}
