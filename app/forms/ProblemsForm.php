<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ProblemsForm.php 2015-11-17 18:59 $
 */
namespace YZOI\Forms;

use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;


class ProblemsForm extends FormBase
{
    public function initialize($entity = null)
    {
        parent::initialize();

        if (isset($entity)) {
            $id = new Hidden('id');
            $this->add($id);
        }

        $title = new Text('title', array(
            'class' => 'form-control'
        ));
        $this->add($title);

        $description = new TextArea('description', array(
            'class' => 'form-control'
        ));
        $this->add($description);

        $pdfname = new Text('pdfname', array(
            'class' => 'form-control',
            'placeholder' => 'p1234'
        ));
        $this->add($pdfname);

        $sampleInput = new TextArea('sample_input', array(
            'class' => 'form-control',
            'rows' => 10
        ));
        $this->add($sampleInput);

        $sampleOutput = new TextArea('sample_output', array(
            'class' => 'form-control',
            'rows' => 10
        ));
        $this->add($sampleOutput);

        $hint = new TextArea('hint', array(
            'class' => 'form-control',
            'rows' => 9
        ));
        $this->add($hint);

        $timeLimit = new Text('time_limit', array(
            'class' => 'form-control',
        ));
        $timeLimit->setDefault(1); //1 second
        $this->add($timeLimit);

        $memoryLimit = new Text('memory_limit', array(
            'class' => 'form-control',
        ));
        $memoryLimit->setDefault(128); //1 MB
        $this->add($memoryLimit);

        //category, by html
        //tags

        $sources = new TextArea('sources', array(
            'class' => 'form-control'
        ));
        $sources->setDefault("YZOI");
        $this->add($sources);

        $spj = new Check('spj', array(
            'class' => 'px',
            'value' => 1
        ));
        $this->add($spj);

        $view_perm = new Select("view_perm",
            array(
                '1' => '已激活用户',
                '5' => 'YZOIer'
            ),
            array(
                'class' => 'form-control'
            )
        );
        $this->add($view_perm);

    }
}