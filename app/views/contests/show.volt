{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
        <div class="panel-body no-padding-t">
            <h2 class="text-primary">{{ contest.id ~ ': ' ~ contest.title }}</h2>
            <div class="row">
                <div class="col-sm-5">
                    <div class="panel colourable no-border">
                        <div class="panel-body no-padding-hr">
                            <div>
                            <?php $now = time();
                            // past
                            if ($now > $contest->end_time) {
                                echo "<span class='label'><i class='fa fa-ban'></i> Ended";
                                // pending
                            } else if ($now < $contest->start_time) {
                                echo "<span class='label label-warning'><i class='fa fa-ban'></i> Pending";
                            } else {
                                echo "<span class='label label-success'><i class='fa fa-check'></i> Running";
                            }
                            echo "</span> ";

                            if ($contest->is_private == 'N') {
                                echo "<span class='label label-success'><i class='fa fa-unlock'></i> Public";
                            } else {
                                echo "<span class='label label-danger'><i class='fa fa-lock'></i> Private";
                            }
                            echo "</span>";
                            ?>
                            </div>
                            <div class="padding-sm no-padding-hr text-bg text-bold"><i class="fa fa-clock-o"></i>
                                {{ date('Y-m-d H:i:s', contest.start_time) ~ " ~ " ~ date('Y-m-d H:i:s', contest.end_time) }}
                            </div>
                            <div class="btn-group btn-group-sm">
                                <a class="btn btn-info" href="{{ url('contests/standing/'~contest.id) }}" target="_blank"><i class="fa fa-line-chart"></i> 作业排名</a>
                                <a class="btn btn-info" href="#"><i class="fa fa-pie-chart"></i> <s>数据统计</s></a>
                                <a class="btn btn-info" href="{{ url('contests/status?cid='~contest.id) }}" target="_blank"><i class="fa fa-gavel"></i> 测评情况</a>
                                <a class="btn btn-outline" href="{{ url('contests/list') }}"><i class="fa fa-reply"></i> 返回列表</a>
                            </div>
                        </div>
                        <div class="padding-sm no-padding-hr">
                            {{ contest.description }}
                        </div>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="panel colourable no-border">
                        <table class="table table-hover table-striped">
                            <thead>
                            <tr>
                                <th width="30"></th>
                                <th width="40">№</th>
                                <th>Problem Title</th>
                            </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($contest->problems() as $key => $ctp) { ?>
                            <tr>
                                <td><?php $pass = \YZOI\Common::accept_status($ctp->problems_id);
                                    if ($pass !== null) {
                                        if ($pass) echo "<i class='fa fa-check-circle text-success'></i>";
                                        else echo "<i class='fa fa-times-circle text-danger'></i>";
                                    } ?></td>
                                <td>{{ ctp.display_order() }}</td>
                                <td class="text-warning">{{ link_to("contests/view/" ~ ctp.contests_id ~ "/" ~ key, ctp.title) }}</td>
                            </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>


