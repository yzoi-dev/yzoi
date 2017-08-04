{{ content() }}

<div class="row">
    <div class="col-sm-9">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h2 class="text-warning">
                    <?php
                    if (is_null($solution->contests_id)) {
                        // 返回题目页
                        echo '<a href="', $this->url->get('problems/show/'), $solution->problems_id, '">',
                        $solution->problems_id, ": ", $solution->title, '</a><small>(测评编号: ', $solution->id, ')</small>';
                    } else {
                        // 返回测试中的题目页
                        echo '<a href="', $this->url->get('contests/view/'), $solution->contests_id , '/', $solution->cnum , '">',
                        '<em>测验', $solution->contests_id, ', 问题', YZOI\Common::contest_pid($solution->cnum) , "</em>: ", $solution->title, '</a><small>(测评编号: ', $solution->id, ')</small>';
                    }
                    ?>
                </h2>
                <div>
                    <abbr title="Language"><i class="fa fa-contao"></i> <?php echo \YZOI\OJ::$language[$solution->language]?></abbr> &nbsp;
                    <abbr title="Time Used"><i class="fa fa-clock-o"></i> {{ solution.time }}sec</abbr> &nbsp;
                    <abbr title="Memory Used"><i class="fa fa-flask"></i> <?php echo round($solution->memory / 1024); ?>MB</abbr> &nbsp;
                    <abbr title="Time Submited"><i class="fa fa-pencil"></i> <?php echo date('Y-m-d H:i:s',$solution->judgetime); ?></abbr> &nbsp;
                    <?php echo "<span class='label label-" . \YZOI\OJ::$labelcolor[$solution->result] . "'>" . \YZOI\OJ::$status[$solution->result] . "</span>"; ?>
                </div>
            </div>
        </div>
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-flask"></i> Judge Detail</span>
            </div>
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left">
                    <i class="fa fa-info-circle"></i> [EOLN] = End Of Line; [EOF] = End Of File; Killed = Runtime ERROR and the thread is killed by system; Input = The first 40 characters of the input data.
                </h6>
                <div class="panel-group" id="accordion-jr">
                    <?php
                    $is_admin = ($logged_in && $logged_in->is_admin());

                    // $judgeresult可能是null
                    // 可能是$solution->runtimes没法转成json_code，json_decode()函数返回为null
                    // 那么通过找到第一个json起始符{["来分割：
                    $json_start = strpos($solution->runtimes, '[{"');

                    if ($json_start == 0) {
                        $judgeresult = json_decode($solution->runtimes, true);
                    } elseif ($json_start > 0) {
                        $something_error = substr($solution->runtimes, 0, $json_start-1);
                        $judgeresult = json_decode(substr($solution->runtimes, $json_start), true);

                        if ($something_error != '') {
                            echo "<pre class='text-danger'>", htmlspecialchars($something_error) , "</pre>";
                        }
                    }

                    if ($judgeresult) {
                        foreach ($judgeresult as $k => $jr) {
                            $html = "";
                            $color = \YZOI\OJ::$labelcolor[$jr['flag']];
                            $colormsg = \YZOI\OJ::$status[$jr['flag']];
                            $filename = $jr['filename'];
                            $time = $jr['time'];
                            $memory = $jr['memory'];

                            $html .= "<div class='panel panel-group-$color'>";
                            $html .= "<div class='panel-heading'><a class='accordion-toggle collapsed' data-toggle='collapse' data-parent='#accordion-jr' href='#collapse$k'>";
                            $html .= "Testcase #" . ($k + 1);
                            if ($is_admin)
                                $html .= " [$filename]";
                            $html .= ": <span class='label label-$color'>$colormsg</span> , ";
                            $html .= "Consumes $time ms and $memory KB memory.";
                            $html .= "</a></div><div id='collapse$k' class='panel-collapse collapse'><div class='panel-body'>";
                            $html .= "<dl class='dl-horizontal'>";
                            if (isset($jr['killa'])) {
                                $kill = $jr['killa'];
                                $html .= "<dt>Killed:</dt><dd><code>$kill</code></dd>";
                            }
                            if (isset($jr['killb'])) {
                                $kill = $jr['killb'];
                                $html .= "<dt>Killed:</dt><dd><code>$kill</code></dd>";
                            }
                            if (isset($jr['killc'])) {
                                $kill = $jr['killc'];
                                $html .= "<dt>Killed:</dt><dd><code>$kill</code></dd>";
                            }
                            if (isset($jr['answer'])) {
                                $answer = $jr['answer'];
                                $html .= "<dt>The Answer:</dt><dd><code>$answer</code></dd>";
                            }
                            if (isset($jr['userout'])) {
                                $userout = $jr['userout'];
                                $html .= "<dt>But You:</dt><dd><code>$userout</code></dd>";
                            }
                            if (isset($jr['indata'])) {
                                $indata = $jr['indata'];
                                $html .= "<dt>Input:</dt><dd><pre>$indata</pre></dd>";
                            }
                            $html .= "</dl></div></div></div>";
                            echo $html;
                        }
                    } elseif ($solution->compiles) {
                        echo "<pre class='text-danger'>Complie Error\n\n" , htmlspecialchars($solution->compiles) , "</pre>";
                    }
                    ?>
                </div>
            </div>
        </div>
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-flask"></i> Code Information</span>
            </div>
            <div class="panel-body"><?php $codeclass = ($solution->language < 2) ? 'c_cpp' : strtolower(YZOI\OJ::$language[$solution->language]);?>
<pre><code class="{{codeclass}}"><?php echo htmlentities(str_replace("\n\r","\n",$solution->sourcecode),ENT_QUOTES,"UTF-8");
if ($solution->language == 2 ) {
    // Pascal Comments
    $comments_start = '{**';
    $comments_end = ' *}';
} else {
    $comments_start = '/**';
    $comments_end = ' */';
}
echo "\n\n$comments_start\n";
echo " * Problem: " . $solution->problems_id . "\n";
echo " * User: " . $solution->name . "\n";
echo " * Language: " . YZOI\OJ::$language[$solution->language] . "\n";
if ($solution->result==4){
    echo " * Time: " . $solution->time . " ms\n";
    echo " * Memory: " . $solution->memory . " KB\n";
}
echo "$comments_end\n";?></code></pre>

            </div>
        </div>
    </div>
    <div class="col-sm-3">
        <div class="panel panel-info panel-dark widget-profile">
            <div class="panel-heading">
                <div class="widget-profile-bg-icon"><i class="fa fa-twitter"></i></div>
                <img src="{{ url('assets/images/avatars/'~solution.avatar) }}"  class="widget-profile-avatar">
                <div class="widget-profile-header">
                    <span>{{ solution.name }}</span><br>
                    <a href="#">{{ solution.nick }}</a>
                </div>
            </div> <!-- / .panel-heading -->
            <div class="widget-profile-counters">
                <div class="col-xs-4"><span>{{ solution.time }}</span><br>Seconds</div>
                <div class="col-xs-4"><span>{{ solution.memory }}</span><br>Kilobytes</div>
                <div class="col-xs-4"><span>{{ solution.code_length }}</span><br>Code Length(Byte)</div>
            </div>
            <input type="text" placeholder="{{ solution.school }}" class="form-control input-lg widget-profile-input">
            <div class="widget-profile-text">
                <h5>Compile Information</h5>
                <?php if ($solution->compiles)
                    echo "<pre class='text-danger'>Complie Error\n\n" . htmlspecialchars($solution->compiles) . "</pre>";
                else
                    echo "<pre>Compiled Successfully</pre>";
                ?>
            </div>
        </div>
    </div>
</div>
