<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: SubmitcodeForm.php 2015/12/22 10:58 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Select;
use YZOI\OJ;

class SubmitcodeForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity->ccid)) {
            $ccid = new Hidden('ccid');
            $this->add($ccid);

            $cpid = new Hidden('cpid');
            $this->add($cpid);
        }


        $problem_id = new Text('problem_id', array(
            'class' => 'form-control',
            'readonly' => 'readonly'
        ));
        $this->add($problem_id);

        $language = new Select("language",
            OJ::$language,
            array(
                'class' => 'form-control'
            )
        );
        $this->add($language);

        $sourcecode = new TextArea('sourcecode', array(
            'class' => 'form-control',
            'rows' => 21
        ));
        $this->add($sourcecode);
    }
}