<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ProblemsController.php 2015/11/26 15:54 $
 */
namespace YZOI\Controllers;

use YZOI\Common;
use YZOI\Forms\SubmitcodeForm;
use YZOI\Models\Contests;
use YZOI\Models\Metas;
use YZOI\Models\Problems;
use YZOI\Models\ProblemsMetas;
use YZOI\Forms\ProblemsForm;
use \Phalcon\Paginator\Adapter\Model as Paginator;
use YZOI\Models\Solutions;
use YZOI\Models\SourceCodes;
use YZOI\Models\Topics;
use YZOI\Models\Users;
use YZOI\Parser;

class ProblemsController extends ControllerBase
{
    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'list'
        ));
    }

    public function listAction()
    {
        $this->view->title = "题目列表";

        $user = $this->auth->getIdentity();

        $numberPage = $this->request->getQuery("page", "int");

        if (!$numberPage && $user) {
            $numberPage = $user->volume;
        } else if (! $numberPage) {
            $numberPage = 1;
        }

        // 默认1000题一页，把未生效的题也都出来了
        $problems = Problems::find(array('order' => 'id ASC'));

        $paginator = new Paginator(array(
            'data' => $problems,
            'limit' => Problems::FRONT_PER_PAGE,
            'page' => $numberPage
        ));

        // 所有标签列表
        $metas = Metas::find(["order" => "count desc"]);

        $this->view->metas = $metas;
        $this->view->page = $paginator->getPaginate();
    }

    public function categoryAction($id, $is_all = "")
    {
        $numberPage = $this->request->getQuery("page", "int", 1);

        // 默认1000题一页，未生效题也读取了
        $meta = Metas::findFirstById($id);
        if ($is_all == "all") {
            $problems = Problems::findByMetasId($id, "`problems`.active = 'Y'", true);
        } else {
            $problems = Problems::findByMetasId($id, "`problems`.active = 'Y'");
        }


        $paginator = new Paginator(array(
            'data' => $problems,
            'limit' => Problems::FRONT_METAS_PER_PAGE,
            'page' => $numberPage
        ));

        $metas = Metas::find(["order" => "count desc"]);
        $this->view->metas = $metas;

        $this->view->title = "题库分类 - " . $meta->name;
        $this->view->meta = $meta;
        $this->view->page = $paginator->getPaginate();
    }

    public function tagAction($id = null)
    {
        $metas = Metas::find(["order" => "count desc"]);
        $this->view->metas = $metas;

        $this->view->title = "题库标签";

        if (! is_null($id))
        {
            $numberPage = $this->request->getQuery("page", "int", 1);

            $meta = Metas::findFirstById($id);
            $problems = Problems::findByMetasId($id, "`problems`.active = 'Y'");

            $paginator = new Paginator(array(
                'data' => $problems,
                'limit' => Problems::FRONT_METAS_PER_PAGE,
                'page' => $numberPage
            ));

            $this->view->page = $paginator->getPaginate();
            $this->view->title = "题库标签 - " . $meta->name;
            $this->view->meta = $meta;
        }
    }

    public function searchAction()
    {
        if ($this->request->isGet()) {
            $scope = $this->request->getQuery("s", array("trim", "striptags"));
            switch ($scope) {
                case 'sr' :
                    $scopes = 'sources';
                    break;
                case 'ct' :
                    $scopes = 'title'; //本来ct=content，全文搜索暂不支持
                    break;
                case 'src' :
                    $scopes = 'exact-src';
                    break;
                default :
                    $scopes = 'title';
            }

            $word = $this->request->getQuery("w", array("trim", "striptags"));
            if ($word === null || $word == "") {
                // remove searching session
                if ($this->session->has("searching-scope"))
                    $this->session->remove("searching-scope");
                if ($this->session->has("searching-word"))
                    $this->session->remove("searching-word");

                return $this->dispatcher->forward(array(
                    'action' => 'list'
                ));
            }

            // 表单搜索“来源”可以模糊搜索，题目中单击“来源”为精确搜索，c就表示题目中的来源
            if ($scopes == "exact-src") {
                $problems = Problems::find(
                    array(
                        "active = 'Y' AND sources = :word:",
                        "bind" => ["word" => $word],
                        "order" => "id"
                    )
                );
            } else {
                $problems = Problems::find(
                    array(
                        "active = 'Y' AND $scopes LIKE :word:",
                        "bind" => ["word" => "%" . $word . "%"],
                        "order" => "id"
                    )
                );
            }

            $numberPage = $this->request->getQuery("page", "int", 1);

            $paginator = new Paginator(array(
                'data' => $problems,
                'limit' => Problems::FRONT_SEARCH_PER_PAGE,
                'page' => $numberPage
            ));

            $this->view->page = $paginator->getPaginate();
            $this->view->title = "搜索 : " . $word;

            $this->session->set("searching-scope", $scope);
            $this->session->set("searching-word", $word);

        } else {
            return $this->dispatcher->forward(array(
                'action' => 'list'
            ));
        }
    }

    public function showAction($id)
    {
        //未登录的不能看，权限不够的不能看，在未开始/未结束的测试中不能看
        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        if (! $user->is_admin() ) {
            //throw new \Exception("Problem is under contest!");
            $contests_list = Problems::is_in_contest($id);

            if (count($contests_list)>0) {
                $contests_string = "";
                foreach ($contests_list as $item) {
                    $contests_string .= $this->tag->linkTo(array(
                        'contests/show/' . $item->contests_id,
                        $item->contests_id,
                        'target' => '_blank'
                    )) . "&nbsp;&nbsp;";
                }
                $this->flashSession->warning("Access Deny! It's under Contest : " . $contests_string );
                return $this->response->redirect("problems");
            }
        }

        $problem = Problems::findFirstById($id);

        if ( ! $problem->user_can_access($user)) {
            throw new \Exception('Problem Access Deny!');
        }

        $best_solutions = $problem->best_solutions(8);

        if ($user) {
            $entity = new \stdClass();
            //$entity->user_id = $user->id;
            $entity->problem_id = $problem->id;
            $entity->language = $user->language;
            $form = new SubmitcodeForm($entity);

            $this->view->form = $form;
        }

        $this->view->problem = $problem;
        $this->view->best_solutions = $best_solutions;
        $this->view->title = "{$problem->id} : {$problem->title}";

        $parser = new Parser();
        $this->view->parser = $parser;
        $this->view->additionalCss = array(
            'assets/css/katex.min.css'
        );
        $this->view->additionalJS = array(
            'assets/js/katex.min.js',
            'ZeroClipboard/ZeroClipboard.js',
            'bsmd/ace/ace.js',
            'bsmd/ace/ext-static_highlight.js',
            'bsmd/code.js',
            'assets/js/yzoitex.js'
        );

    }

    public function submitcodeAction()
    {
        //未登录的不能看，权限不够的不能看，在未开始/未结束的测试中不能看
        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        if ($this->request->isPost())
        {
            $solution = new Solutions();

            $problem_id = $this->request->getPost("problem_id", array("trim", "int"));
            $ccid       = $this->request->getPost("ccid", array("trim", "int"));
            $cpid       = $this->request->getPost("cpid", array("trim", "int"));
            if ($ccid && ($cpid>=0)) {
                // Contest submission
                $solution->contests_id = $ccid;
                $solution->cnum = $cpid;

                $contest = Contests::findFirstById($ccid);

                if ($contest && $contest->user_can_access($user)) {
                    $problem = $contest->problems(intval($cpid));
                    if ( ! $problem )
                    {
                        throw new \Exception('Problem in Contest can\'t find!');
                    }
                } else {
                    throw new \Exception("Contest Access Deny!");
                }
            } else {
                // Normal Problem submission
                $problem = Problems::findFirstById($problem_id);

                if ( ! $problem || ! $problem->user_can_access($user) )
                {
                    throw new \Exception('Problem Access Deny!');
                }
            }

            $sourcecode = new SourceCodes();
            $sourcecode->source     = $this->request->getPost("sourcecode", array("trim"));

            $solution->users_id     = $user->id;
            $solution->problems_id  = $problem_id;
            $solution->language     = $this->request->getPost("language");
            $solution->judgetime    = time();
            $solution->code_length  = strlen($sourcecode->source);
            $solution->ip           = $this->request->getClientAddress();

            if ($solution->code_length < 10) {
                $this->flashSession->error("代码有问题！");
                return $this->response->redirect("status");
            }

            if ($solution->create()) {
                //$this->flashSession->success("答案提交成功！");

                $sourcecode->solutions_id = $solution->id;
                if ($sourcecode->create())
                    $this->flashSession->success("代码提交成功！");
                else
                    $this->flashSession->error("答案未提交成功！");

                $user->language = $solution->language;
                $user->volume = floor((intval($solution->problems_id)-1000)/100) + 1;
                $user->save();

                if ($ccid) {
                    $this->response->redirect("contests/status?cid=$ccid");
                } else {
                    $this->response->redirect("status");
                }
            } else {
                foreach ($solution->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                return $this->response->redirect("status");
            }

        }
    }

    public function statisticAction($problem_id)
    {
        //未登录的不能看，权限不够的不能看，在未开始/未结束的测试中不能看
        $user = $this->auth->getIdentity();

        if (! $user || ! is_object($user)) {
            $this->flashSession->error("请先登录");
            return $this->response->redirect("users/login");
        }

        $problem = Problems::findFirstById($problem_id);

        if ( ! $problem->user_can_access($user)) {
            throw new \Exception('Problem Access Deny!');
        }

        $solutions = $problem->best_solutions();

        $this->view->title = "题目测评情况";
        $this->view->problem = $problem;
        $this->view->statistic = $problem->statistic();
        $this->view->additionalJS = array(
            'highcharts/highcharts.js'
        );

        $numberPage = $this->request->getQuery("page", "int", 1);

        $paginator = new Paginator(array(
            'data' => $solutions,
            'limit' => 30,
            'page' => $numberPage
        ));


        $this->view->page = $paginator->getPaginate();

    }
}
