<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: TopicForm.php 2015/12/9 12:18 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Validation\Validator\Numericality;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;
use YZOI\OJ;

class TopicForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity)) {
            $id = new Hidden('id');
            $this->add($id);
        }

        $title = new Text('title', array(
            'class' => 'form-control',
            'placeholder' => '标题（至少3个字节）'
        ));
        $title->setFilters(array('string', 'trim'));
        $title->addValidators(array(
            new PresenceOf(array(
                'message' => '总得写个标题吧！'
            )),
            new StringLength(array(
                'max' => 100,
                'min' => 3,
                'messageMaximum' => 'We don\'t like really long title',
                'messageMinimum' => 'We want more than what you input'
            ))
        ));
        $this->add($title);

        $flag = new Select("flag",
            OJ::$topic_flag,
            array(
                'class' => 'form-control',
                'useEmpty' => true,
                'emptyText' => '主题类型'
            )
        );
        $this->add($flag);

        $problems_id = new Text('problems_id', array(
            'class' => 'form-control',
            'placeholder' => '题目ID'
        ));
        $problems_id->setFilters('trim');
        /*$problems_id->addValidators(array(
            new Numericality(array(
                'message' => '题目ID至少应该是4位数的整数',
            ))
        ));*/
        $this->add($problems_id);

        $content = new TextArea('content', array(
            'class' => 'form-control'
        ));
        $this->add($content);

    }
}