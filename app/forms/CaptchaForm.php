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
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Identical;

class CaptchaForm extends Form
{
    public function initialize()
    {
        $captcha = new Text('captcha', array(
            'class' => 'form-control input-lg',
            'placeholder' => 'Verify Code'
        ));
        $captcha->addValidator(new PresenceOf(array(
            'message' => '验证码未输入'
        )));
        $this->add($captcha);
    }

}