<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Uploader.php 2015/12/5 12:51 $
 */
namespace YZOI;

class Uploader
{
    private $real_name = '';
    private $allow_upload_types = array();	// 允许上传的文件类型
    private $limit_size = 0;	// 最大允许上传的文件大小


    public function __construct( $allow_upload_types = array(), $limit_size = null)
    {
        $this->allow_upload_types = $allow_upload_types;

        if ( $limit_size === null)
            $limit_size = $this->to_bytes(ini_get('upload_max_filesize'));
        $this->limit_size = $limit_size;

        $ini_post_max_size = $this->to_bytes(ini_get('post_max_size'));
        $ini_upload_max_filesize = $this->to_bytes(ini_get('upload_max_filesize'));

        if ($ini_post_max_size < $this->limit_size || $ini_upload_max_filesize < $this->limit_size)
        {
            $require_size = max(1, $this->limit_size / 1024 / 1024) . 'M';
            die("{'error':'Please set the post_max_size and upload_max_filesize in [php.ini], minus value：$require_size'}");
        }

    }

    // 获取文件名: 客户端原文件名
    public function get_file_name()
    {
        // 去掉空格
        return preg_replace('/\s+/u', '_', $_FILES['Filedata']['name']);
    }

    // 获取文件大小，整型数字
    public function get_file_size()
    {
        return $_FILES['Filedata']['size'];
    }

    // 获取文件类型
    public function get_file_type()
    {

        $file_name = strtolower($this->get_file_name());
        $pos = strrpos($file_name, '.');
        if ($pos !== false)
        {
            return substr($file_name, $pos+1);
        } else {
            return '';
        }
    }

    // 获取在服务器上保存的真实文件名
    public function get_real_name()
    {
        return $this->real_name;
    }

    public function save($path)
    {
        return move_uploaded_file($_FILES['Filedata']['tmp_name'], $path);
    }


    private function to_bytes($str) {
        $val = trim($str);
        $last = strtolower($str[strlen($str)-1]);
        switch($last) {
            case 'g': $val *= 1024;
            case 'm': $val *= 1024;
            case 'k': $val *= 1024;
        }
        return $val;
    }


    public function upload( $upload_dir, $username = null )
    {
        if ( !file_exists($upload_dir) )
        {
            mkdir($upload_dir, 0777, true);
        }

        if(!is_writable($upload_dir)) return array('error' => "NOT WRITABLE.");

        $file_size = $this->get_file_size();
        if ($file_size == 0) return array('error' => 'EMPTY FILE');
        if ($file_size > $this->limit_size) return array('error' => 'TOO LARGE');

        $file_type = $this->get_file_type();
        if(count($this->allow_upload_types) && !in_array($file_type, $this->allow_upload_types))
        {
            $types = implode(',', $this->allow_upload_types);
            return array('error' => 'EXTENSION UNACCEPTABLE, ONLY '. $types);
        }

       if (! is_null($username))
       {
           // 临时文件如果用同一个文件名，客户端无法刷新，造成裁剪时的预览图还是原先的老图
           // 因此要用不同的文件名保存，造成的后果是tmp目录下的图片可能会越来越多
           $real_name = $username . '-' . date('Ymd'). '-'. md5(uniqid()). '.' . $file_type;
       } else {
           $real_name = $this->get_file_name();
       }


        $this->real_name = $real_name;

        if( $this->save($upload_dir.$real_name) )
        {
            return array('success'=>true);
        }
        else
        {

            return array('success' => false, 'error'=> 'UPLOAD FAILURE, CANNOT SAVE FILE(S)!');
        }

    }
}
