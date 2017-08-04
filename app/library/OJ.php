<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: OJ.php 2015/12/18 10:59 $
 */
namespace YZOI;

class OJ
{
    public static $language = array(
        '0' => 'C',
        '1' => 'C++',
        '2' => 'Pascal',
        '3' => 'Java',
        '4' => 'Python'
    );

    public static $result = array(
        '4'  => 'AC',
        '5'  => 'PE',
        '6'  => 'WA',
        '7'  => 'TLE',
        '8'  => 'MLE',
        '9'  => 'OLE',
        '10' => 'RE',
        '11' => 'CE'
    );

    public static $status = array(
        "4"  => "Accepted",
        "5"  => "Presentation Error",
        "6"  => "Wrong Answer",
        "7"  => "Time Limit Exceed",
        "8"  => "Memory Limit Exceed",
        "9"  => "Output Limit Exceed",
        "10" => "Runtime Error",
        "11" => "Compile Error",
        "12" => "Compile OK",
        "13" => "Test Running Done",
        "0"  => "Pending",
        "1"  => "Pending Rejudging",
        "2"  => "Compiling",
        "3"  => "Running &amp; Judging"
    );

    public static $labelcolor = array(
        "4"  => "success",
        "5"  => "danger",
        "6"  => "info",
        "7"  => "danger",
        "8"  => "danger",
        "9"  => "danger",
        "10" => "danger",
        "11" => "danger",
        "12" => "warning",
        "13" => "primary",
        "0"  => "default",
        "1"  => "default",
        "2"  => "warning",
        "3"  => "warning"
    );

    public static $tagcolor = array(
        "", //0
        "label-success", //1~9
        "label-primary", //10~19
        "label-info", //20~29
        "label-warning", //30-39
        "label-danger"  //40-9999
    );

    public static $topic_flag = array(
        'share'     => '分享',
        'question'  => '问答',
        'solution'  => '解题报告',
        'tutorial'  => '教程'
    );
}