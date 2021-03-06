<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: ProblemController.php 2015/11/15 18:05 $
 */
namespace YZOI\Controllers\Admin;

use YZOI\Common;
use YZOI\Models\Metas;
use YZOI\Models\Problems;
use YZOI\Models\ProblemsMetas;
use YZOI\Forms\ProblemsForm;
use \Phalcon\Paginator\Adapter\Model as Paginator;
use YZOI\Models\Solutions;
use YZOI\Uploader;

class ProblemsController extends ControllerBase
{
    public function initialize()
    {
        return parent::initialize(); // TODO: Change the autogenerated stub
    }

    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'list'
        ));
    }

    /**
     * problems list
     *
     */
    public function listAction()
    {
        $this->view->title = "题目列表";
        $this->view->additionalCss = array(
            'assets/css/uploader.css'
        );
        $this->view->additionalJS = array(
            'assets/js/uploader.js'
        );

        $numberPage = $this->request->getQuery("page", "int", 1);

        $problems = Problems::find(array('order' => 'id DESC'));

        $paginator = new Paginator(array(
            'data' => $problems,
            'limit' => Problems::BACK_PER_PAGE,
            'page' => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
    }

    /**
     * add problem
     *
     */
    public function createAction()
    {
        $this->view->title = "新增题目";

        $this->view->additionalCss = array(
            'bsmd/bsmd.css'
        );
        $this->view->additionalJS = array(
            'assets/js/jquery.tokeninput.js',
            'assets/js/jquery.validate.js',
            'bsmd/ace/ace.js',
            'bsmd/bsmd.js',
            'bsmd/marked.min.js',
            'bsmd/admineditor.js'
        );
        if ($this->session->has('problem_source')) {
            $problem = new Problems();
            $problem->sources = $this->session->get('problem_source');
            $this->view->form = new ProblemsForm($problem);
        } else {
            $this->view->form = new ProblemsForm();
        }


        // 系统所有的分类
        $this->view->categories = Common::buildTree(
            Common::object2Array(
                Metas::find("type = '" . Metas::TYPE_CATEGORY ."'")
            )
        );
        // 系统所有的标签
        $this->view->tags = Metas::find("type = 'tag'");

        if ($this->request->isPost()) {
            $problem = new Problems();

            $problem->title         = $this->request->getPost('title', 'striptags');
            $problem->description   = $this->request->getPost('description');
            $problem->pdfname       = $this->request->getPost('pdfname');
            $problem->sample_input  = $this->request->getPost('sample_input');
            $problem->sample_output = $this->request->getPost('sample_output');
            $problem->hint          = $this->request->getPost('hint');
            $problem->time_limit    = $this->request->getPost('time_limit');
            $problem->memory_limit  = $this->request->getPost('memory_limit');
            $problem->spj           = $this->request->getPost('spj', null, 0);
            $problem->view_perm     = $this->request->getPost('view_perm', null, 1);
            $problem->sources       = $this->request->getPost('sources', 'string');

            $problem->create_at = time();
            $problem->modify_at = $problem->create_at;

            // maybe no input data
            if (strlen($problem->sample_output) && !strlen($problem->sample_input))
                $problem->sample_input = "[No Input Data]";

            $success = $problem->create();

            if ($success) {
                $this->flashSession->success("添加成功！");
                $this->session->set('problem_source', $problem->sources);
            } else {
                foreach ($problem->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }

            // 设置分类标签
            $this->setCategories($problem->id, $this->request->getPost('categories'));
            $this->setTags($problem->id, $this->request->getPost('tags', 'trim'));

            // 生成第一个样例数据
            $data_path = $problem->data_dir(); // will be /home/data/1001
            if (! file_exists($data_path)) {
                mkdir($data_path);
            }
            if (strlen($problem->sample_input))
            {
                if ($this->_make_data_file('sample.in', $problem->sample_input, $data_path)) {
                    $this->flashSession->success("输入数据文件创建成功！");
                } else {
                    $this->flashSession->error("输入数据文件创建失败！");
                }
            }
            if (strlen($problem->sample_output))
            {
                if ($this->_make_data_file('sample.out', $problem->sample_output, $data_path)) {
                    $this->flashSession->success("输出数据文件创建成功！");
                } else {
                    $this->flashSession->error("输出数据文件创建失败！");
                }
            }


            $this->response->redirect('yzoi7x/problems/edit/' . $problem->id);
        }
    }

    /**
     * edit problem
     *
     * @param $id
     */
    public function editAction($id)
    {
        $problem = Problems::findFirstById($id);

        $this->view->title = "编辑题目: " . $problem->id;
        $this->view->additionalCss = array(
            'bsmd/bsmd.css'
        );
        $this->view->additionalJS = array(
            'assets/js/jquery.tokeninput.js',
            'assets/js/jquery.validate.js',
            'bsmd/ace/ace.js',
            'bsmd/bsmd.js',
            'bsmd/marked.min.js',
            'bsmd/admineditor.js'
        );
        $this->view->problem = $problem;
        $this->view->form = new ProblemsForm($problem);

        // 系统所有的分类
        $this->view->categories = Common::buildTree(
            Common::object2Array(
                Metas::find("type = '" . Metas::TYPE_CATEGORY ."'")
            )
        );
        // 系统所有的标签
        $this->view->tags = Metas::find("type = 'tag'");
        // 该题目所属的分类及标签id
        $this->view->probMetas = Common::arrayFlatten(
            ProblemsMetas::find("problems_id = " . $problem->id),
            'metas_id');

        if (!$problem) {
            $this->flash->error("Problem does not exist " . $id);
            return $this->dispatcher->forward(
                array(
                    "action" => "list"
                )
            );
        }

        if ($this->request->isPost()) {
            $problem->title         = $this->request->getPost('title', 'striptags');
            $problem->description   = $this->request->getPost('description');
            $problem->pdfname       = $this->request->getPost('pdfname');
            $problem->sample_input  = $this->request->getPost('sample_input');
            $problem->sample_output = $this->request->getPost('sample_output');
            $problem->hint          = $this->request->getPost('hint');
            $problem->time_limit    = $this->request->getPost('time_limit');
            $problem->memory_limit  = $this->request->getPost('memory_limit');
            $problem->spj           = $this->request->getPost('spj', null, 0);
            $problem->view_perm     = $this->request->getPost('view_perm', null, 1);
            $problem->sources       = $this->request->getPost('sources', 'string');

            $problem->modify_at = time();

            // maybe no input data
            if (strlen($problem->sample_output) && !strlen($problem->sample_input))
                $problem->sample_input = "[No Input Data]";

            $success = $problem->update();

            if ($success) {
                $this->flashSession->success("编辑成功！");
                //$this->session->set('problem_source', $problem->sources);
            } else {
                foreach ($problem->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
            // 设置分类
            $this->setCategories($problem->id, $this->request->getPost('categories'));
            // 设置标签
            $this->setTags($problem->id, $this->request->getPost('tags', 'trim'));

            // 修改样例数据
            if ($this->request->getPost('modifydata', null, 0) > 0) {
                $data_path = $problem->data_dir(); // will be /home/data/1001
                $this->view->data_path = $data_path;
                if (!file_exists($data_path)) {
                    mkdir($data_path);
                }
                if (strlen($problem->sample_input)) {
                    if ($this->_make_data_file('sample.in', $problem->sample_input, $data_path)) {
                        $this->flashSession->success("输入数据文件修改成功！");
                    } else {
                        $this->flashSession->error("输入数据文件修改失败！");
                    }
                }
                if (strlen($problem->sample_output)) {
                    if ($this->_make_data_file('sample.out', $problem->sample_output, $data_path)) {
                        $this->flashSession->success("输出数据文件修改成功！");
                    } else {
                        $this->flashSession->error("输出数据文件修改失败！");
                    }
                }
            }

            $this->response->redirect('yzoi7x/problems/edit/' . $problem->id);
        }
        //$this->view->phql = $this->setCategories($problem->id, array());
		
    }

    /**
     * 设置题目是否激活，供ajax调用
     *
     * @return \Phalcon\Http\Response|\Phalcon\Http\ResponseInterface
     */
    public function statusAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            $pid = $this->request->getQuery('problem_id', 'int');
            $problem = Problems::findFirstById($pid);
            if ($problem) {
                if ($problem->active == 'Y')
                    $problem->active = 'N';
                else
                    $problem->active = 'Y';

                $problem->update();

                $this->response->setJsonContent($problem->active);
                return $this->response;
            }
        }
    }

    public function testfilelistAction($id)
    {
        $this->view->disable();

        if ($this->request->isAjax())
        {
            $problem = Problems::findFirstById($id);
            if ($problem)
            {
                $data_path = $problem->data_dir();

                $file_list = array();
                if ($handle = opendir($data_path))
                {
                    $i = 0;
                    while (false !== ($filename = readdir($handle)))
                    {
                        if ($filename{0} == '.') continue;
                        $file = $data_path . '/' . $filename;

                        $file_list[$i]['filename'] = $filename; //文件名，包含扩展名
                        $file_list[$i]['filesize'] = filesize($file); //B
                        //$file_ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));
                        //$file_list[$i]['filetype'] = $file_ext;
                        //$file_list[$i]['datetime'] = date('Y-m-d H:i:s', filemtime($file)); //文件最后修改时间
                        $i++;
                    }
                    closedir($handle);
                }
                // 按文件名排序
                usort($file_list, array('YZOI\Common', 'file_cmp_only_by_name'));

                $this->response->setJsonContent($file_list);
                return $this->response;
            }
        }
    }

    public function uploadtestdataAction($id)
    {
        $this->view->disable();

        $problem = Problems::findFirstById($id);

        if ($this->request->isPost() && $problem)
        {
            $verifyToken = md5($this->config->application->cryptSalt);
            $postToken = $this->request->getPost('token');
            if ((empty($_FILES) === false) && ($postToken == $verifyToken))
            {
                $data_path = $problem->data_dir();

                $uploader = new Uploader(
                    explode(',', $this->config->uploader->testdata_type),
                    $this->config->uploader->testdata_size
                );

                $result = $uploader->upload($data_path . '/'); // 不改文件名，新内容会覆盖

                //return $result;

                if (isset($result['success']) && $result['success'])
                {
                    $this->response->setJsonContent(array(
                        'success' => true,
                        'data' => 'OKOKOK'
                    ));
                } else {
                    $this->response->setJsonContent(array(
                        'success' => false,
                        'data' => $result
                    ));
                }
                return $this->response;
            }
        }
    }

    /**
     * 设置分类，先删后插入
     *
     * @param $pid 题目ID
     * @param $categories 题目分类数组
     * @param bool|true $beforeCount 是否更新计数
     * @param bool|true $afterCount 是否更新计数
     */
    protected function setCategories($pid, $categories, $beforeCount = true, $afterCount = true)
    {
        // 取得现有category
        $phql = "SELECT YZOI\Models\Metas.id FROM YZOI\Models\Metas " .
                "INNER JOIN YZOI\Models\ProblemsMetas ON YZOI\Models\ProblemsMetas.metas_id = YZOI\Models\Metas.id " .
                "WHERE (YZOI\Models\ProblemsMetas.problems_id = " . $pid . ") AND (YZOI\Models\Metas.type = 'category')";
        $existCategories = $this->modelsManager->executeQuery($phql);

        //return $existCategories;

        // 删除已有category
        if ($existCategories) {
            foreach ($existCategories as $cate) {
                $phql = "DELETE FROM YZOI\Models\ProblemsMetas WHERE problems_id = ?0 AND metas_id = ?1";
                $this->modelsManager->executeQuery($phql, array(
                    0 => $pid,
                    1 => $cate->id
                ));

                // 更新分类下的题目数
                if ($beforeCount) {
                    $phql = "UPDATE YZOI\Models\Metas SET count = count - 1 WHERE id = " . $cate->id;
                    $this->modelsManager->executeQuery($phql);
                }
            }
        }

        if (! empty($categories)) {

            $categories = array_unique($categories);

            // 插入新category
            foreach ($categories as $cate) {
                $phql = "INSERT INTO YZOI\Models\ProblemsMetas (problems_id, metas_id) VALUES (?0, ?1)";
                $this->modelsManager->executeQuery($phql, array(
                    0 => $pid,
                    1 => $cate
                ));

                if ($afterCount) {
                    $phql = "UPDATE YZOI\Models\Metas SET count = count + 1 WHERE id = " . $cate;
                    $this->modelsManager->executeQuery($phql);
                }
            }
        }
    }

    /**
     * 设置标签
     *
     * @param $pid 题目ID
     * @param $tags 表单传递来的标签字符串，如1,5,23,7,LCA,BFS/DFS,2，其中数组表示已存在的标签id，字符表示新标签
     * @param bool|true $beforeCount
     * @param bool|true $afterCount
     */
    protected function setTags($pid, $tags, $beforeCount = true, $afterCount = true)
    {
        /**
         * 安全验证，参考typecho，/typecho/var/Widget/Contents/Post/Eidt.php line 593
         * /typecho/var/Typecho/Validate.php line277
         */
        //$tags = array_filter($tags, array('Typecho_Validate', 'xssCheck'));

        // 数据表中该$pid现有的标签
        $existTags = $this->modelsManager->createBuilder()
            ->columns('YZOI\Models\Metas.id')
            ->from('YZOI\Models\Metas')
            ->join('YZOI\Models\ProblemsMetas', 'YZOI\Models\ProblemsMetas.metas_id = YZOI\Models\Metas.id')
            ->where('YZOI\Models\ProblemsMetas.problems_id = ' . $pid . ' AND YZOI\Models\Metas.type = "tag"')
            ->getQuery()
            ->execute();

        //return $existTags

        // 删除对$pid关联的所有标签
        if ($existTags) {
            foreach ($existTags as $cate) {
                $phql = "DELETE FROM YZOI\Models\ProblemsMetas WHERE problems_id = ?0 AND metas_id = ?1";
                $this->modelsManager->executeQuery($phql, array(
                    0 => $pid,
                    1 => $cate->id
                ));

                // 更新分类下的题目数
                if ($beforeCount) {
                    $phql = "UPDATE YZOI\Models\Metas SET count = count - 1 WHERE id = " . $cate->id;
                    $this->modelsManager->executeQuery($phql);
                }
            }
        }

        if (! empty($tags)) {

            $tags = str_replace('，', ',', $tags);
            $tags = array_unique(array_map('trim', explode(',', $tags)));

            //return $tags;

            // 现在metas标签表中插入新增的标签，id返回后放入$tags数组
            foreach ($tags as $k => $tag) {
                // 检测一下这个$tag是否存在在metas表中，如果用户输入的是整数数字，就会当成已存在标签的id
                if (is_numeric($tag)) {
                    // 已存在的标签忽略
                    if (!Metas::findFirst("type = 'tag' and id = " . intval($tag)))
                        unset($tags[$k]);
                } else if (!empty($tag)) {
                    //不存在的标签，添加
                    $meta = new Metas();
                    $meta->name = $tag;
                    $meta->type = 'tag';
                    $meta->create();
                    $tags[$k] = $meta->id;
                }
            }

            // 插入$pid的标签到关系表中去
            foreach ($tags as $tag) {
                $phql = "INSERT INTO YZOI\Models\ProblemsMetas (problems_id, metas_id) VALUES (?0, ?1)";
                $this->modelsManager->executeQuery($phql, array(
                    0 => $pid,
                    1 => $tag
                ));

                if ($afterCount) {
                    $phql = "UPDATE YZOI\Models\Metas SET count = count + 1 WHERE id = " . $tag;
                    $this->modelsManager->executeQuery($phql);
                }
            }
        }
    }

    private function _make_data_file($filename, $content, $path)
    {
        $fp = @fopen ( $path . "/$filename", "w" );
        if ($fp)
        {
            fputs( $fp, preg_replace( "(\r\n)", "\n", $content ) );
            fclose( $fp );
            return true;
        } else {
            return false;
        }
    }


    public function refreshstaticAction()
    {
        $this->view->title = "刷新题库AC率";

        $problems = Problems::find();

        foreach ($problems as $problem) {
            $problem->submit = Solutions::count_for_problem(array(
                'problems_id' => $problem->id
            ));
            $problem->accepted = Solutions::count_for_problem(array(
                'problems_id' => $problem->id,
                'result' => Solutions::STATUS_AC
            ));
            $problem->solved = Solutions::count_distinct_user(array(
                'problems_id' => $problem->id,
                'result' => Solutions::STATUS_AC
            ));
            $problem->save();
        }

        echo "更新完毕";


    }
}





























