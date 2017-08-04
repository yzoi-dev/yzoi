{{ content() }}

<div class="profile-full-name">
    <span class="text-semibold">查看 {{ user.name }}</span>'s profile
</div>
<div class="profile-row">
    {{ partial("partials/userleftprofile") }}
    <div class="right-col">
        <hr class="profile-content-hr no-grid-gutter-h">
        <div class="profile-content">
            <ul id="profile-tabs" class="nav nav-tabs">
                <li class="active">
                    <a href="javascript:;">解题情况</a>
                </li>
            </ul>

            <div class="tab-content tab-content-bordered ">
                <div class="tab-pane panel-body fade in active taglist">
                    <div id="user_statistic" class="panel-body no-padding-hr"></div>
                    <div class="alert" align="center">
                        <a class="label label-success" href="javascript:;"><i class="fa fa-warning"></i> Green：解决的问题</a>
                        <a class="label label-danger" href="javascript:;"><i class="fa fa-warning"></i> Red：尝试的问题</a>
                        <a class="label label-default" href="javascript:;"><i class="fa fa-warning"></i> Gray：未曾尝试的问题</a>
                    </div>
                <?php
                for ($i=1000; $i<=$max_pid; $i++)
                {
                    if (isset($user_prob[$i])) {
                        if ($user_prob[$i] == 1) {
                            echo $this->tag->linkTo(array(
                                "problems/show/$i",
                                $i,
                                "class" => "label label-success",
                                "target" => "_blank"
                            ));
                        } elseif ($user_prob[$i] == -1) {
                            echo $this->tag->linkTo(array(
                                "problems/show/$i",
                                $i,
                                "class" => "label label-danger",
                                "target" => "_blank"
                            ));
                        }
                    } else {
                        echo $this->tag->linkTo(array(
                            "problems/show/$i",
                            $i,
                            "class" => "label",
                            "target" => "_blank"
                        ));
                    }
                }
                ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
init.push(function () {
    $('body').addClass('page-profile');

});
</script>