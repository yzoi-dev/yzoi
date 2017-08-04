<?php
/**
 * YZOI Online Judge System
 *
 * @copyright   Copyright (c) 2010 YZOI
 * @author      xaero <xaero@msn.cn>
 * @version     $Id: MetasController.php 2015/11/20 18:55 $
 */
namespace YZOI\Controllers\Admin;


use Phalcon\Tag;
use YZOI\Common;
use YZOI\Forms\TagForm;
use YZOI\Models\Metas;
use YZOI\Forms\CategoryForm;
use YZOI\Models\ProblemsMetas;


class MetasController extends ControllerBase
{
    public function indexAction()
    {
        $this->dispatcher->forward(array(
            'action' => 'listcate'
        ));
    }

    public function addcateAction($parent = null)
    {

        $this->view->title = "分类列表/新增分类";
        $form = new CategoryForm();
        $this->view->form = $form;


        if (isset($parent) && $parent) {
            $this->tag->setDefault('parent', $parent); //设自select框的值
            $parparent = Metas::findFirstById($parent)->parent;
        } else {
            $parent = 0;
            $parparent = 0;
        }
        // 当前分类的父亲，和父亲的父亲（返回按钮用）
        $this->view->parent = $parent;
        $this->view->parparent = $parparent;

        $this->view->allCategories = Common::buildTree(
            Common::object2Array(
                Metas::find("type = '" . Metas::TYPE_CATEGORY ."'")
            )
        );

        //分类过滤
        $this->view->categories = Metas::find(array(
            "type = '" . Metas::TYPE_CATEGORY . "' and parent = " . $parent,
            'order' => 'orders'
        ));
        //$this->view->tmp = $this->buildtreeview(Metas::find("type = 'category'"));

        if ($this->request->isPost()) {

            if (!$form->isValid($_POST)) {
                foreach ($form->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                $this->response->redirect("yzoi7x/metas/addcate/" . $parent);
            }

            $category = new Metas();

            $category->name = $this->request->getPost('name', 'string');
            $category->description = $this->request->getPost('description', 'striptags');
            $category->orders = $this->request->getPost('orders', 'int');
            $category->parent = $this->request->getPost('parent');

            $category->type = 'category';

            $success = $category->create();
            if ($success) {
                $this->flashSession->success("分类添加成功！");
                $this->response->redirect("yzoi7x/metas/addcate/" . $parent);
            } else {
                foreach ($category->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
        }
    }

    public function editcateAction($id)
    {
        $category = Metas::findFirstById($id);

        $this->view->title = "分类列表/编辑分类：" . $category->id;
        $this->view->category = $category;
        $form = new CategoryForm($category);
        $this->view->form = $form;
        $this->view->parent = $category->parent;

        $this->view->categories = Metas::find(array(
            "type = '" . Metas::TYPE_CATEGORY . "' and parent = 0",
            'order' => 'orders'
        ));

        $this->view->allCategories = Common::buildTree(
            Common::object2Array(
                Metas::find("type = '" . Metas::TYPE_CATEGORY ."'")
            )
        );

        if ($this->request->isPost()) {

            if (!$form->isValid($_POST)) {
                foreach ($form->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                $this->response->redirect("yzoi7x/metas/editcate/" . $category->id);
            }

            $category->name = $this->request->getPost('name', "string");
            $category->description = $this->request->getPost('description', 'striptags');
            $category->orders = $this->request->getPost('orders', 'int');
            $category->parent = $this->request->getPost('parent');

            $success = $category->update();
            if ($success) {
                $this->flashSession->success("分类编辑成功！");
                $this->response->redirect("yzoi7x/metas/addcate");
            } else {
                foreach ($category->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
        }
    }

    public function addtagAction()
    {
        $this->view->title = "新增标签";
        $this->view->additionalJS = array('jquery.validate.js');

        //分类过滤
        $tags = Metas::find(array("type = 'tag'", 'order' => 'name'));
        $this->view->tags = $tags;
        $form = new TagForm();
        $this->view->form = $form;

        if ($this->request->isPost()) {

            if (!$form->isValid($_POST)) {
                foreach ($form->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                $this->response->redirect("yzoi7x/metas/addtag/");
            }

            $tag = new Metas();

            $tag->name = $this->request->getPost('name', 'string');
            $tag->orders = $this->request->getPost('orders', 'int');
            $tag->type = 'tag';

            $success = $tag->create();
            if ($success) {
                $this->flashSession->success($tag->name . " 标签添加成功！");
                $this->response->redirect("yzoi7x/metas/addtag/");
            } else {
                foreach ($tag->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
        }
    }

    public function edittagAction($id)
    {
        $tag = Metas::findFirstById($id);

        $this->view->title = "编辑标签：" . $tag->id;
        $this->view->additionalJS = array('jquery.validate.js');
        $this->view->ttag = $tag;
        $form = new TagForm($tag);
        $this->view->form = $form;

        $tags = Metas::find(array("type = 'tag'", 'order' => 'name'));
        $this->view->tags = $tags;

        if ($this->request->isPost()) {

            if (!$form->isValid($_POST)) {
                foreach ($form->getMessages() as $message) {
                    $this->flashSession->error($message);
                }
                $this->response->redirect("yzoi7x/metas/editcate/" . $tag->id);
            }

            $tag->name = $this->request->getPost('name', "string");
            $tag->orders = $this->request->getPost('orders', 'int');

            $success = $tag->update();
            if ($success) {
                $this->flashSession->success($tag->name . " 标签编辑成功！");
                $this->response->redirect("yzoi7x/metas/addtag");
            } else {
                foreach ($tag->getMessages() as $message) {
                    $this->flash->error($message);
                }
            }
        }
    }

    public function mergeAction()
    {
        if (! $this->request->isPost()) {
            $this->response->redirect("yzoi7x/metas/addtag");
        } else {
            $tags = $this->request->getPost("tags");
            $newname = $this->request->getPost("newname" ,"trim");

            if (empty($tags) || empty($newname)) {
                $this->flashSession->error("未选中任何标签，或者新标签名字为空！");
                $this->response->redirect("yzoi7x/metas/addtag");
            }
            // TODO: 新标签名可能和已有的重复
            // insert new tag
            /*
            $newtag = new Metas();
            $newtag->name = strip_tags($newname);
            $newtag->type = Metas::TYPE_TAG;
            $newtag->create();
            */
            // delete merging tags
            /*
            foreach ($tags as $tid) {
                $tag = Metas::findFirstById($tid);
                if ($tag) {
                    $phql = "UPDATE YZOI\Models\ProblemsMetas SET metas_id = ?0 WHERE metas_id = ?1";
                    $this->modelsManager->executeQuery($phql, array(
                        0 => intval($newtag->id),
                        1 => intval($tag->id)
                    ));

                    $newtag->count += $tag->count;
                    $newtag->update();

                    $tag->delete();
                }
            }
            $this->flashSession->success("合并成功！");
            $this->response->redirect("yzoi7x/metas/addtag");
            */
        }
    }

    public function removetagAction()
    {
        $this->view->disable();

        if ($this->request->isAjax()) {
            $tid = $this->request->getQuery('tag_id');
            $tag = Metas::findFirstById($tid);

            if ($tag && $tag->count == 0) {
                if ($tag->delete()) {
                    // 删除成功
                    $this->response->setJsonContent($tid);
                    return $this->response;
                }
            }
        }
    }

    public function updatecountAction()
    {
        $this->view->title = "更新分类题数";
        if ($updatecount = Metas::update_metas_count()) {
            $this->view->updatecount = $updatecount;
        }
    }
}