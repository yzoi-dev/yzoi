<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Common.php 2015/11/22 17:49 $
 */
namespace YZOI;

class Common
{
    /**
     * 抽取多维数组（对象）的某个元素,组成一个新数组,使这个数组变成一个扁平数组
     * 使用方法:
     * <code>
     * <?php
     * $fruit = array(array('apple' => 2, 'banana' => 3), array('apple' => 10, 'banana' => 12));
     * $banana = YZOI::arrayFlatten($fruit, 'banana');
     * print_r($banana);
     * //outputs: array(0 => 3, 1 => 12);
     * ?>
     * </code>
     *
     * @access public
     * @param object $value 被处理的对象
     * @param string $key 需要抽取的键值
     * @return array
     */
    public static function arrayFlatten($value, $key)
    {
        $result = array();

        if ($value) {
            foreach ($value as $inval) {
                $result[] = $inval->$key;
            }
        }

        return $result;
    }

    /**
     * 将对象转数组
     *
     * @param $obj
     * @return array
     */
    public static function object2Array($obj)
    {
        $result = array();
        foreach ($obj as $key => $value)
        {
            $result[$key] = (array)$value;
        }
        return $result;
    }

    /**
     * 根据分类数组，建立树型结构
     *
     * @param array $list
     * @param int $parent
     * @param int $level
     * @return array
     */
    public static function buildTree(array $list, $parent = 0, $level = 0)
    {
        static $tree = null;
        foreach ($list as $key => $value)
        {
            if ($value['parent'] == $parent)
            {
                $tmp = array();
                $tmp['id'] = $value['id'];
                $tmp['parent'] = $parent;
                $tmp['name'] = $value['name'];
                $tmp['level'] = $level;
                //$tmp['hasChild'] = false;

                $tree[] = $tmp;

                unset($list[$key]);

                $level++;
                static::buildTree($list, $value['id'], $level);
                $level--;
            }
        }
        return $tree;
    }    

    public static function datetimeFormat($time)
    {
        $t = time() - $time;
        $f = array(
            '31536000'  => ' years ago',
            '2592000'   => ' months ago',
            '604800'    => ' weeks ago',
            '86400'     => ' days ago',
            '3600'      => ' hours ago',
            '60'        => ' mintues ago',
            '1'         => ' seconds ago'
        );
        foreach ($f as $k => $v) {
            if (0 != $c = floor($t / (int)$k))
            {
                return $c . $v;
            }
        }
    }

    public static function file_cmp_only_by_name($a, $b) {
        return strcmp($a['filename'], $b['filename']);
    }

    public static function accept_status($problem_id)
    {
        $di = \Phalcon\Di::getDefault();
        $cu = $di['auth']->getIdentity();
        if ($cu) {
            if ($cu->is_problem_solved($problem_id))
                return true;
            if ($cu->is_problem_trying($problem_id))
                return false;
        }
        return null;
    }

    public static function contest_pid($pid)
    {
        return chr(65 + intval($pid));
    }

    public static function convert_contest_time($time)
    {
        $sec    = $time % 60;
        $time   = $time / 60;
        $minute = $time % 60;
        $hour   = $time / 60;

        return sprintf("%02d:%02d:%02d", $hour, $minute, $sec);
    }

    public static function site_uri_prefix($https = 'http://')
    {
        $host = $_SERVER['HTTP_HOST']; //已经自带端口号
        //$port = $_SERVER["SERVER_PORT"];

        //if (intval($port) == 80) $port = "";

        //return $https . $host . $port;
        return $https . $host;
    }

    public static function url_query(array $params = null, $mark = true)
    {
        if (empty($params))
        {
            // No query parameters
            return '';
        }

        // Note: http_build_query returns an empty string for a params array with only NULL values
        $query = http_build_query($params, '', '&');

        // Don't prepend '?' to an empty string
        if ($query === '')
            return '';
        elseif ($query !== '' && $mark)
            return '?' . $query;
        elseif ($query !== '')
            return $query;

    }

    // 用户名、邮箱、手机账号中间字符串以*隐藏，显示头3位
    public static function hide_star($str)
    {
        if (strpos($str, '@')) {
            $email_array = explode("@", $str);
            $prevfix = (strlen($email_array[0]) < 4) ? "" : substr($str, 0, 3); //邮箱前缀
            $count = 0;
            $str = preg_replace('/([\d\w+_-]{0,100})@/', '***@', $str, -1, $count);
            $rs = $prevfix . $str;
        } else {
            $pattern = '/(1[3458]{1}[0-9])[0-9]{4}([0-9]{4})/i';
            if (preg_match($pattern, $str)) {
                $rs = preg_replace($pattern, '$1****$2', $str); // substr_replace($name,'****',3,4);
            } else {
                $rs = substr($str, 0, 3) . "***" . substr($str, -1);
            }
        }

        return $rs;
    }


}














