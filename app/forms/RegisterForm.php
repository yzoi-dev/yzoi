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

class RegisterForm extends FormBase
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
            'placeholder' => '注册后用户名无法更改'
        ));
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

        // Email
        $email = new Text('email', array(
            'class' => 'form-control',
            'placeholder' => 'Email要接收激活链接'
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

        // old password for modify
        $old_password = new Password('oldpassword', array(
            'class' => 'form-control',
            'placeholder' => 'Old Password'
        ));
        $this->add($old_password);

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

        // Terms
        $terms = new Check('terms', array(
            'class' => 'px',
            'value' => 'yes'
        ));
        $terms->addValidator(new Identical(array(
            'value' => 'yes',
            'message' => 'Terms and conditions must be accepted'
        )));
        $this->add($terms);

        // Display Language
        $display_lang = new Select("display_lang", array(
            "en" => "English",
            "zh" => "简体中文"
        ));
        $this->add($display_lang);

        // CSRF for phalcon 2.0.8
        /**
        $csrf = new Hidden('csrf');
        $csrf->addValidator(new Identical(array(
            'value' => $this->security->getSessionToken(),
            'message' => 'CSRF validation failed'
        )));
        $this->add($csrf);
         * */
    }

}
