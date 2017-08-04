{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-navicon"></i> Filter tips: PID=1000,1001,... Under contest PID=A,B,C,...</h6>
                <form class="form-inline" method="get" action="{{ url(dispatcher.getControllerName()~'/'~dispatcher.getActionName()) }}">
                    <div class="form-group">
                        <label for="pid">PID:</label>
                        {{ form.render('pid') }}
                    </div>
                    <div class="form-group">
                        <label for="username">User:</label>
                        {{ form.render('uname') }}
                    </div>
                    <div class="form-group">
<!--                        <label for="language">Language:</label>-->
                        {{ form.render('ulang') }}
                    </div>
                    <div class="form-group">
<!--                        <label for="status">Result:</label>-->
                        {{ form.render('result') }}
                    </div>
                    {% if contest is defined %}
                    {{ form.render('cid') }}
                    {% endif %}
                    <button type="submit" class="btn btn-warning"><i class="fa fa-filter"></i> 筛选</button>
                </form>
            </div>
        </div>
    </div>
</div>
{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> {{ title }}</span>
                <div class="panel-heading-controls">
                    <?php if (isset($contest))
                            $backurl = $this->url->get('contests/show/'.$contest->id);
                        else
                            $backurl = $this->url->get('problems/list');?>
                    <a class="btn btn-xs btn-warning" href="<?php echo $backurl;?>"><span class="fa fa-reply"></span>&nbsp;&nbsp;Back to List</a>
                </div>
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="70">№</th>
                        <th>User</th>
                        <th width="80">PID</th>
                        <th width="70">Score</th>
                        <th width="140">Result</th>
                        <th width="70">Memory</th>
                        <th width="70">Times</th>
                        <th width="110">Language</th>
                        <th width="70">Length</th>
                        <th width="90">Submit Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php
                    $is_admin = ($logged_in && $logged_in->is_admin());
                    $is_ultraman = ($logged_in && $logged_in->is_ultraman());

                    $scores = array();

                    foreach ($page->items as $solution) {
                        echo '<tr><td>', $solution->id , '</td>',
                        '<td class="text-warning">' , $this->tag->linkTo(array(
                                'users/profile/' . $solution->users_id,
                                $this->tag->image(array('assets/images/avatars/' . $solution->avatar, 'class'=>'avatar')) . '&nbsp; ' . $solution->name,
                                'target' => '_blank'
                            )) , '</td>',

                        '<td class="text-warning">';

                        if ($solution->contests_id) {
                            echo $this->tag->linkTo(array(
                                'contests/view/' . $solution->contests_id . '/' . $solution->cnum,
                                \YZOI\Common::contest_pid($solution->cnum),
                                'title' => $solution->title,
                                'data-toggle' => 'tooltip'
                            ));
                        } else {
                            echo $this->tag->linkTo(array(
                                'problems/show/' . $solution->problems_id,
                                $solution->problems_id,
                                'title' => $solution->title,
                                'data-toggle' => 'tooltip'
                            ));
                        }

                        echo '</td><td class="text-danger">';

                        if (! empty($solution->score)) {
                            $scores = explode(',', $solution->score);
                            if (isset($scores[1]) && $scores[1]) {
                                echo round($scores[0] * 100 / $scores[1]);
                                if ($is_admin)
                                    echo "<small>/{$scores[1]}</small>";
                            } else
                                echo '0';
                        }

                        echo '</td><td>';

                        if ($logged_in && $solution->user_can_access($logged_in)) {
                            echo $this->tag->linkTo(array(
                                'status/show/' . $solution->id,
                                '<i class="fa fa-info-circle"></i> ' . \YZOI\OJ::$status[$solution->result],
                                'class' => 'label label-' . \YZOI\OJ::$labelcolor[$solution->result],
                                'target' => '_blank'
                            ));
                        } else {
                            echo '<span class="label label-', \YZOI\OJ::$labelcolor[$solution->result] , '">' , \YZOI\OJ::$status[$solution->result] , '</span>';
                        }

                        if (intval($solution->memory) > 1024)
                            echo '</td><td>' , round($solution->memory / 1024, 1) , '<abbr title="' , $solution->memory , 'KB">MB</abbr></td>',
                            '<td>' , $solution->time , '<abbr title="Milliseconds">ms</abbr></td><td>';
                        else
                            echo '</td><td>' , $solution->memory , '<abbr title="' , round($solution->memory / 1024) , 'MB">KB</abbr></td>',
                            '<td>' , $solution->time , '<abbr title="Milliseconds">ms</abbr></td><td>';

                        if ($logged_in && $solution->user_can_access($logged_in)) {
                            echo $this->tag->linkTo(array(
                                'status/show/' . $solution->id,
                                \YZOI\OJ::$language[$solution->language],
                                'class' => 'text-warning',
                                'target' => '_blank'
                            ));
                        } else {
                            echo \YZOI\OJ::$language[$solution->language];
                        }

                        if ($logged_in && $solution->user_can_modify($logged_in)) {

                            if ($solution->is_public == \YZOI\Models\Solutions::SOLUTION_PUBLIC) {
                                echo ' <a href="javascript:;" data-value="' , $solution->id , '" class="codetips1 locksolution label label-danger"><i class="fa fa-unlock"></i></a>';
                            } else {
                                echo ' <a href="javascript:;" data-value="' , $solution->id , '" class="codetips0 locksolution label label-info"><i class="fa fa-lock"></i></a>';
                            }
                            // "submit again" button
                            echo ' <a href="#submitAgainModal"';
                            if ($solution->contests_id) {
                                echo ' data-ccid="' . $solution->contests_id . '"',
                                ' data-cpid="' . $solution->cnum . '"';
                            }
                            echo ' data-solutionid="' . $solution->id . '"',
                            ' data-problemid="' . $solution->problems_id . '"',
                            ' data-language="' . $solution->language . '"',
                            ' data-toggle="modal" class="submitagain label label-warning"><i class="fa fa-pencil"></i></a>';
                        } else if ($logged_in && $solution->user_can_access($logged_in)) {
                            echo $this->tag->linkTo(array(
                                'status/show/' . $solution->id,
                                ' <i class="fa fa-unlock"></i>',
                                'class' => 'label label-success'
                            ));
                        }

                        echo '</td><td>' , $solution->code_length , '<abbr title="Byte">B</abbr></td>',
                        '<td class="text-sm">' , date('Y-m-d H:i:s', $solution->judgetime) , '</td></tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
            <div class="panel-footer">
                <ul class="pager">
                <?php
				$status_uri = (isset($contest)) ? 'contests/status' : 'status';
				
                if ($page->current > 1) {
                    $filter['page'] = $page->first;
                    echo '<li>', $this->tag->linkTo($status_uri . \YZOI\Common::url_query($filter), '<i class="fa fa-fast-backward"></i> First') , '</li>';
                }
                if ($page->current > 1) {
                    $filter['page'] = $page->before;
                    echo '<li>', $this->tag->linkTo($status_uri . \YZOI\Common::url_query($filter), '<i class="fa fa-arrow-left"></i> Newer') , '</li>';
                }
                if (($page->next > 1) && ($page->current < $page->next)) {
                    $filter['page'] = $page->next;
                    echo '<li>', $this->tag->linkTo($status_uri .\YZOI\Common::url_query($filter), 'Older <i class="fa fa-arrow-right"></i>') , '</li>';
                }
                if (($page->last > 1) &&  ($page->current < $page->last)) {
                    $filter['page'] = $page->last;
                    echo '<li>', $this->tag->linkTo($status_uri . \YZOI\Common::url_query($filter), 'Last <i class="fa fa-fast-forward"></i>') , '</li>';
                }
                ?>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}
<?php if (!(empty($logged_in)) && $logged_in): ?>
{% include("partials/submitcodeagain") %}
<script type="text/javascript">
init.push(function(){
    $("a.codetips0").data("placement", "top").attr("title", "It's private, others can't see the code! Click to unlock.").tooltip();
    $("a.codetips1").data("placement", "top").attr("title", "It's public, everyone can view the code! Click to lock.").tooltip();
    $("a.submitagain").data("placement", "top").attr("title", "Edit and Submit it again.").tooltip();

    $("a.locksolution").click(function() {
        var element = $(this);
        var solution_id = element.data("value");
        //console.log(solution_id);
        if (element.hasClass("label-danger"))
            var user_ok = confirm("您确定要将代码"+ solution_id +"置为私有吗？");
        else
            var user_ok = confirm("您确定要公开代码"+ solution_id +"吗？");
        if (user_ok)
        {
            $.getJSON("{{ url('status/locksolution') }}",
                {"solution_id": solution_id},
                function(response){
                    if (element.hasClass("label-danger"))
                    {
                        element.removeClass("label-danger");
                        element.addClass("label-info");
                        element.html("<i class='fa fa-lock'></i>");
                    } else {
                        element.removeClass("label-info");
                        element.addClass("label-danger");
                        element.html("<i class='fa fa-unlock'></i>")
                    }
                });
        }
    });

    $("a.submitagain").click(function() {
        var element = $(this);
        var solution_id = element.data("solutionid");
        var language = element.data("language");
        var ccid = element.data("ccid"), cpid = element.data("cpid");
        var problem_id = element.data("problemid");
        var $ccid = $('#ccid'), $cpid = $('#cpid'), $problem_id = $('#problem_id');
        //console.log($ccid.val());
        if (ccid == undefined) {
            $ccid.remove(), $cpid.remove();
            $('#submitAgainModal h4.modal-title').text("Try again for Problem " + problem_id);
        } else {
            $ccid.val(ccid), $cpid.val(cpid);
            $('#submitAgainModal h4.modal-title').text("Try again for Contest " + ccid + ", Problem " + cpid);
        }
        //console.log($cid.val());
        $problem_id.val(problem_id).prop("readonly", "readonly");
        if (language != $('#language option:selected').val()) {
            $('#language option[value="'+ language +'"]').prop("selected", "selected");
            //$('#language').get(0).options[sel_index].selected = true;
            //$('#language').get(0).selectedIndex  = sel_index;
        }
        //console.log($('#language option:selected').val());
        $.get("{{ url('status/getcode') }}",
            {"solution_id" : solution_id},
            function(data) {
                $('#sourcecode').val(data);
        });
    });

});
</script>
<?php endif;?>