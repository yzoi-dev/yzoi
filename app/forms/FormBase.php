<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: FormBase.php 2016/4/16 8:54 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Validation\Validator\Identical;

class FormBase extends Form
{
    protected $_csrf;

    public function initialize()
    {
        // CSRF protection
        $csrf = new Hidden($this->getCsrfName());
        //$csrf->clear();
        $csrf->setDefault($this->security->getToken())
            ->addValidator(new Identical([
                'accepted'   => $this->security->checkToken(),
                'message' => 'CSRF forgery detected!'
            ]));
        //var_dump($this->security->getToken());
        $this->add($csrf);
    }

    /**
     * 为了能在相应表单的底部显示提示信息,调用方式和form类似{{ form.messages('password') }}， 看vokuro注册实例
     * Prints messages for a specific element
     */
    public function messages($name)
    {
        if ($this->hasMessagesFor($name)) {
            foreach ($this->getMessagesFor($name) as $message) {
                $this->flash->error($message);
            }
        }
    }

    // Generates CSRF token key
    public function getCsrfName()
    {
        if (empty($this->_csrf)) {
            $this->_csrf = $this->security->getTokenKey();
        }

        return $this->_csrf;
    }
}