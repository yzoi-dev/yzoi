<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: StatusForm.php 2015/12/18 11:59 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use YZOI\OJ;

class StatusForm extends Form
{
    public function initialize($entity = null)
    {

        if (isset($entity->cid))
        {
            $cid = new Hidden('cid');
            $this->add($cid);
        }

        $pid = new Text('pid', array(
            'class' => 'form-control input-xs-2'
        ));
        $this->add($pid);

        $uname = new Text('uname', array(
            'class' => 'form-control input-xs-3'
        ));
        $this->add($uname);

        $ulang = new Select("ulang",
            OJ::$language,
            array(
                'class' => 'form-control',
                'useEmpty' => true,
                'emptyText' => 'Language'
            )
        );
        $this->add($ulang);

        $result = new Select("result",
            OJ::$status,
            array(
                'class' => 'form-control',
                'useEmpty' => true,
                'emptyText' => 'Choose Result'
            )
        );
        $this->add($result);
    }
}