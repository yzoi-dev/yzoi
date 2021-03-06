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
use YZOI\Models\Solutionoldyzois;
use YZOI\Models\Solutions;
use YZOI\Models\SourceCodes;
use YZOI\Models\Users;

class ImportoldsolutionController extends ControllerBase
{
    public function initialize()
    {
        return parent::initialize(); // TODO: Change the autogenerated stub
    }

    public function indexAction()
    {
        $this->view->title = "从旧Solution导入";
        $this->view->pick("importoldsolution");

        if ($this->request->isPost()) {
            $olduser = $this->request->getPost('olduser');
            $userid = $this->request->getPost('user');
            $problems = $this->request->getPost('problems');
            //$problems = explode(',', $problems);

            $tuser = Users::findFirstById($userid);

            if ($tuser) {
                $oldsolutions = Solutionoldyzois::findos($olduser, $problems);

                $num = 0;

                foreach ($oldsolutions as $ositem) {
                    $news = new Solutions();

                    $news->problems_id = $ositem->problem_id;
                    $news->users_id = $tuser->id;
                    $news->language = $ositem->language;
                    $news->ip = $this->request->getClientAddress();
                    $news->judgetime = time();
                    $news->code_length = strlen($ositem->source);

                    if ($news->create()) {
                        $sourcecode = new SourceCodes();
                        $sourcecode->solutions_id = $news->id;
                        $sourcecode->source = $ositem->source;
                        if (! $sourcecode->create()) {
                            echo "P" . $ositem->problem_id ." Code Error<br>";
                        }

                        $num++;

                    } else {
                        echo "P" . $ositem->problem_id ." Solution Error<br>";
                    }

                }

                echo "导入了" . $num . '条记录';
            }

            

        }

    }




}





























