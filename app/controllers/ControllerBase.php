<?php/** * YZOI Online Judge System * * @copyright   Copyright (c) 2010 YZOI * @author      xaero <xaero@msn.cn> * @version     $Id: ControllerBase.php 2015-10-22 18:12 $ */namespace YZOI\Controllers;use YZOI\Common;use YZOI\Models\Metas;class ControllerBase extends Base{	/**     * 建立左侧题库菜单     *     * @param array $list     * @param int $parent     * @param bool|true $first 最顶部“所有题库”菜单的标志，确保只输出一次     * @return string     */    final private function treeHTMLMenu(array $list, $parent = 0, $first = true)    {        $html = "";        foreach ($list as $key => $value)        {            if ($key == 0 && $first)            {                $html .= "<li";				if ($this->dispatcher->getActionName() == "list")					$html .= " class='active'";				$html .= "><a href='" . $this->url->get('problems/list') . "'><i class='menu-icon fa fa-th-list'></i>所有题库</a></li>";                $html .= "<li";                if ($this->dispatcher->getActionName() == "tag")                    $html .= " class='active'";                $html .= "><a href='" . $this->url->get('problems/tag') . "'><i class='menu-icon fa fa-tags'></i>标签搜题</a></li>";                $first = false;            }            if ($value['parent'] == $parent)            {                $tmp = self::treeHTMLMenu($list, $value['id'], $first);                if (empty($tmp))                {					// 设置子类的激活状态                    $html .= "<li";					if (count($this->dispatcher->getParams())>0 && $this->dispatcher->getParams()[0] == $value['id'])						$html .= " class='active pleaseopenparent'";					$html .= ">";                } else {					// 这里貌似没法在服务端设定父类的打开状态，目前是通过js实现                    $html .= "<li class='mm-dropdown'>";                }                unset($list[$key]);                $html .= "<a href='" . $this->url->get('problems/category/' . $value['id']) ."'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>" . $value['name'];                $html .= "</span></a>";                $html .= $tmp;                $html .= "</li>";            }        }        // 返回之前把子类所属的父类菜单加入        if (! empty($html)) {            if ($parent == 0) {                $wraphtml = "<ul>";            } else {                $wraphtml = "<ul><li";                if (count($this->dispatcher->getParams()) > 0 && $this->dispatcher->getParams()[0] == $parent)                    $wraphtml .= " class='active pleaseopenparent'";                $wraphtml .= "><a href='";                $wraphtml .= $this->url->get('problems/category/' . $parent) . "/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题";                $wraphtml .= "</span></a></li>";            }            $html = $wraphtml . $html . "</ul>";        }        return $html;    }	    public function initialize()    {        $this->view->setTemplateBefore("main");        //$this->load_trans();        $this->view->setVar('logged_in', $this->auth->getIdentity());        // 系统所有的分类        $metas = Common::object2Array(            Metas::find(array("type = '" . Metas::TYPE_CATEGORY ."'", 'order' =>"orders"))        );        // 递归输出分类菜单        // TODO: 相当于每个页面都要递归输出一次，页面加载速度慢5～8ms，考虑缓存或者其他方式        $this->view->menuCategories = $this->treeHTMLMenu($metas);        //$this->view->menuCategories = "";        //$this->view->testmetas = Common::buildTree($metas);    }}