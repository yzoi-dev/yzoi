<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Base.php 2016/2/24 18:29 $
 */
namespace YZOI\Controllers;

use \Phalcon\Mvc\Controller;
use \Phalcon\Translate\Adapter\NativeArray;

class Base extends Controller
{
    protected function getTranslation()
    {
        $language = "en";

        require APP_DIR . "/lang/" . $language . "/main.php";

        return new NativeArray(array("content" => $messages));
    }

    public function initialize()
    {
        $this->di->setShared('t', $this->getTranslation());
    }

    /**
     * filter data such as '', null
     *
     * @param       $data array
     * @param array $filters
     *
     * @return array
     */
    protected function clear_data($data, $filters = array('', NULL))
    {
        $ret = array();
        foreach($data as $key => $value)
        {
            if ( ! in_array($value, $filters, true) )
                $ret[$key] = $value;
        }

        return $ret;
    }
}