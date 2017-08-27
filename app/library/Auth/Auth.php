<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: Auth.php 2015/11/13 17:12 $
 */
namespace YZOI\Auth;

use Phalcon\Mvc\User\Component;
use YZOI\Models\Privileges;
use YZOI\Models\Users;

class Auth extends Component
{
    /**
     * Checks the user credentials
     *
     * @param array $credentials
     * @throws Exception
     * @return array $user_info
     */
    public function check($credentials)
    {
        // Check if the user exist
        $user = Users::findFirstByName($credentials['name']);
        if ($user == false) {
            //$this->registerUserThrottling(0);
            throw new Exception("用户名错误！");
        }

        // Check the password
        if (! $this->security->checkHash($credentials['password'], $user->password)) {
            //$this->registerUserThrottling($user->id);
            throw new Exception("密码错误");
        }

        // Check if the user was flagged
        $this->checkUserFlags($user);

        // Register the successful login
        $this->saveSuccessLogin($user);

        // Check if the remember me was selected
        if (isset($credentials['remember'])) {
            $this->createRememberEnviroment($user);
        }

        $this->session->set('yzoi-auth-identity', $user);

//        var_dump($this->session->getId());
//        var_dump($this->session->isStarted());
        return $user->toArray();
    }


    public function saveSuccessLogin(Users $user)
    {
        $user->ip = $this->request->getClientAddress();
        $user->last_login = time();
        $user->score += 10; //TODO:登录奖励分数，要可设设置
        if (!$user->save()) {
            $messages = $user->getMessages();
            throw new Exception($messages[0]);
        }
    }

    /**
     * 记住密码，保留8天cookies
     *
     * @param Users $user
     */
    public function createRememberEnviroment(Users $user)
    {
        $userAgent = $this->request->getUserAgent();
        $token = md5($user->email . $user->password . $userAgent);

        $expire = time() + 86400 * 8;
        $this->cookies->set('RMU', $user->id, $expire);
        $this->cookies->set('RMT', $token, $expire);
    }

    /**
     * Check if the session has a remember me cookie
     *
     * @return bool
     */

    public function hasRememberMe()
    {
        return $this->cookies->has('RMU');
    }

    public function loginWithRememberMe()
    {
        $userId = $this->cookies->get('RMU')->getValue();
        $cookieToken = $this->cookies->get('RMT')->getValue();

        $user = Users::findFirstById($userId);
        if ($user) {

            $userAgent = $this->request->getUserAgent();
            $token = md5($user->email . $user->password . $userAgent);

            if ($cookieToken == $token) {

                // Check if the cookie has not expired
                if ((time() - (86400 * 8)) < $user->last_login) {

                    // Check if the user was flagged
                    $this->checkUserFlags($user);

                    // Register identity
                    $this->session->set('yzoi-auth-identity', $user);

                    // Register the successful login
                    $this->saveSuccessLogin($user);

                    return $this->response->redirect('users');
                } else {
                    $this->remove();
                }
            }
        }

        // Else, please sign in
        //$this->cookies->get('RMU')->delete();
        //$this->cookies->get('RMT')->delete();

        //return $this->response->redirect('users/login');
    }

    public function checkUserFlags(Users $user)
    {
        if ($user->active != 'Y') {
            throw new Exception('The user is inactive');
        }
    }

    public function getIdentity()
    {
        return $this->session->get('yzoi-auth-identity');
    }

    /**
     * Removes the user identity information from session
     */
    public function remove()
    {
        if ($this->cookies->has('RMU')) {
            $this->cookies->get('RMU')->delete();
        }
        if ($this->cookies->has('RMT')) {
            $this->cookies->get('RMT')->delete();
        }

        $this->session->remove('yzoi-auth-identity');
    }

    /**
     * Auths the user by his/her id
     *
     * @param int $id
     * @throws Exception
     */
    /**
    public function authUserById($id)
    {
        $user = Users::findFirstById($id);
        if ($user == false) {
            throw new Exception('The user does not exist');
        }

        $this->checkUserFlags($user);

        $this->session->set('yzoi-auth-identity', $user);
    }
     * */
    
    /**
     * Get the entity related to user in the active identity
     *
     * @return Users
     * @throws Exception
     */
    /*
    public function getUser()
    {
        $identity = $this->session->get('yzoi-auth-identity');
        if (isset($identity['id'])) {

            $user = Users::findFirstById($identity['id']);
            if ($user == false) {
                throw new Exception('The user does not exist');
            }

            return $user;
        }

        return false;
    }
    */

}
