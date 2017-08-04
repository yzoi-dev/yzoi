<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Users.php 2015-10-24 13:41 $
 */
namespace YZOI\Models;

use Phalcon\Mvc\Model;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;
use Phalcon\Validation\Validator\Uniqueness as UniquenessValidator;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

class Users Extends Model
{
    const FRONT_PER_PAGE = 50; // 前台每页显示记录数
    const BACK_PER_PAGE = 50; // 后台每页显示记录数

    /**
     * @var integer
     */
    public $id;

    /**
     * @var string
     */
    public $name;

    /**
     * @var string
     */
    public $password;

    /**
     * @var string
     */
    public $email;

    /**
     * @var integer
     */
    public $view_perm;

    /**
     * @var string
     */
    public $nick;

    /**
     * @var string
     */
    public $school;

    /**
     * @var integer
     */
    public $submit;

    /**
     * @var integer
     */
    public $solved;

    /**
     * @var char
     */
    public $active;

    /**
     * @var integer
     */
    public $score;

    /**
     * @var string
     */
    public $ip;

    /**
     * @var integer
     */
    public $create_at;

    /**
     * @var integer
     */
    public $last_login;

    /**
     * @var integer
     */
    public $volume;

    /**
     * @var integer
     */
    public $language;
    public $display_lang = "en";


    protected $solved_problems_list = null;
    protected $trying_problems_list = null;


    public function initialize()
    {
        $this->hasMany('id', 'YZOI\Models\Privileges', 'users_id', ['alias' => 'privilege']);
    }


    /**
     * Before create the user
     */
    public function beforeValidationOnCreate()
    {
        $this->view_perm = 0;
        $this->score = 0;
    }

    public function afterSave()
    {
        //TODO:向用户发送激活邮件
    }

    public function validation()
    {
        $validator = new Validation();

        $validator->add('name', new UniquenessValidator(array(
            'model' => $this,
            'message' => '抱歉，此用户名已被人注册！'
        )));
        $validator->add('email', new EmailValidator(array(
            'model' => $this,
            'message' => '请输入有效的Email地址'
        )));
        $validator->add('email', new UniquenessValidator(array(
            'model' => $this,
            'message' => '抱歉，此Emai已被人注册！'
        )));

        return $this->validate($validator);
    }

    public static function findUsersRanks($number = 0, $offset = 0)
    {
        //$number = ($number > 0) ? intval($number) : intval(self::FRONT_PER_PAGE);
        $sql = "SELECT
                    `users`.id,
                    `users`.name,
                    `users`.nick,
                    `users`.solved,
                    `users`.submit,
                    `users`.avatar
                FROM `users`
                WHERE `users`.`active` = 'Y' and `users`.`id` != 1
                ORDER BY `users`.solved DESC, `users`.submit ASC, `users`.create_at DESC

                ";
        if ($number > 0) {
            $sql .= " LIMIT $number";
        }
        // LIMIT $offset, $number
        $ranks = new Users();
        $result = new Resultset(null, $ranks, $ranks->getReadConnection()->query($sql));

        return $result;
    }

    public static function findUsersRanks_monthly($number = 0, $offset = 0)
    {
        $number = ($number > 0) ? intval($number) : intval(self::FRONT_PER_PAGE);

        $thistime = strtotime(date('Y').'-'.date('m').'-01');

        $sql = "SELECT
                    `users`.`id`,
                    `users`.`name`,
                    `users`.`nick`,
                    `users`.`avatar`,
                    `s`.`solved`,
                    `t`.`submit`
                FROM `users`
                RIGHT JOIN (SELECT
                              COUNT(DISTINCT `solutions`.`problems_id`) solved,
                              `solutions`.`users_id`
                              FROM `solutions`
                              WHERE `solutions`.`judgetime` >= $thistime AND `solutions`.`result`=4
                              GROUP BY `solutions`.`users_id`
                              ORDER BY solved DESC
                              LIMIT $offset, $number) s
                      ON `users`.`id` = `s`.`users_id`
                LEFT JOIN (SELECT
                              COUNT(DISTINCT `solutions`.`problems_id`) submit,
                              `solutions`.`users_id`
                              FROM `solutions`
                              WHERE `solutions`.`judgetime` >= $thistime
                              GROUP BY `solutions`.`users_id`
                              ORDER BY submit DESC
                              LIMIT $offset, $number) t
                      ON `users`.`id` = `t`.`users_id`
                WHERE `users`.`active` = 'Y' and `users`.`id` != 1
                ORDER BY `s`.`solved` DESC, `t`.`submit` DESC
                LIMIT 0,$number
                ";

        $ranks = new Users();
        $result = new Resultset(null, $ranks, $ranks->getReadConnection()->query($sql));

        return $result;
    }

    public static function update_user_solved_submit($user_id)
    {
        $sql="UPDATE `users`
                SET `solved`=(SELECT
                                count(DISTINCT `problems_id`)
                              FROM `solutions`
                              WHERE `users_id`='$user_id' AND `result`='4'),
                    `submit`=(SELECT count(*) FROM `solutions` WHERE `users_id`='$user_id')
                WHERE `id`='$user_id'
              ";

        $user = new Users();
        return $user->getReadConnection()->execute($sql);

    }

    /**
     * 用户ac题目ID列表
     *
     * @return array|null
     */
    public function problems_solved()
    {
        if ($this->solved_problems_list === null) {
            $this->solved_problems_list = Solutions::user_solved_problems($this->id);
        }
        return $this->solved_problems_list;
    }

    /**
     * 用户submit题目ID列表
     *
     * @return array|null
     */
    public function problems_tried()
    {
        if ($this->trying_problems_list === null) {
            $this->trying_problems_list = Solutions::user_tried_problems($this->id);
        }
        return $this->trying_problems_list;
    }

    /**
     * 判断某题是否已经AC
     *
     * @param $problem_id
     * @return bool
     */
    public function is_problem_solved($problem_id)
    {
        $solved_problems = $this->problems_solved();
        return in_array($problem_id, $solved_problems, true);
    }

    /**
     * 判断某题是否还在尝试
     *
     * @param $problem_id
     * @return bool
     */
    public function is_problem_trying($problem_id)
    {
        $trying_problems = $this->problems_tried();
        return in_array($problem_id, $trying_problems, true);
    }

    public function number_of_submit()
    {
        return Solutions::number_of_solution_accept_for_user($this->id);
    }

    public function number_of_problem_accept()
    {
        return Solutions::number_of_problem_accept_for_user($this->id);
    }

    public function update_user_solution_state()
    {
        $this->submit = $this->number_of_submit();
        $this->solved = $this->number_of_problem_accept();
        $this->save();
    }

    public function is_ultraman()
    {
        return $this->has_permission(Privileges::NAME_ADMINISTRATOR) || $this->has_permission(Privileges::NAME_ULTRAMAN);
    }

    public function is_admin()
    {
        return $this->has_permission(Privileges::NAME_ADMINISTRATOR);
    }
	
	public function has_permission($permission, $needit = false)
	{
		foreach ($this->privilege as $perm) {
			if ($perm->name == $permission) {
				if ($needit) return $perm;
				if ($perm->active == 'N') return false;
				return true;
			}
		}
		return false;
	}

    public function countUnreadMails($from_user = null) {
        $query = "to_user = $this->id AND unread = 1";
        if ($from_user) {
            $query .= " AND from_user = $from_user";
        }
        return Mails::find(
            array(
                $query
            )
        )->count();
    }

    public function clearUnreadMails($from_user) {
        $mails = Mails::find(
            array(
                "to_user = $this->id AND from_user = $from_user AND unread = 1"
            )
        );
        foreach ($mails as $mail) {
            $mail->unread = 0;
            $mail->save();
        }
    }
}



































