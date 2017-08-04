{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
        <div class="panel-body no-padding-t">
            <h2 class="text-warning">
                <?php echo '<a href="', $this->url->get('problems/show/') , $problem->id , '">', $problem->id , ": " , $problem->title, '</a>'; ?>
            </h2>
            <div>
                <abbr title="Time Limit"><i class="fa fa-clock-o"></i> {{ problem.time_limit }}sec</abbr> &nbsp;
                <abbr title="Memory Limit"><i class="fa fa-flask"></i> {{ problem.memory_limit}}MB</abbr> &nbsp;
                <?php $pass = \YZOI\Common::accept_status($problem->id);
                if ($pass !== null) {
                    if ($pass) echo "<span class='label label-tags label-success'><i class='fa fa-check'></i> Accept</span>";
                    else echo "<span class='label label-tags label-danger'><i class='fa fa-times'></i> Decline</span>";
                }
                ?>
            </div>
        </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-4">
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-th-large"></i> Summary</span>
            </div>
            <div class="panel-body" id="problem_summary"></div>
            <ul class="list-group">
                <li class="list-group-item">
                    <span class="badge badge-primary"><?php echo $statistic['total'];?></span>
                    尝试次数
                </li>
                <li class="list-group-item">
                    <span class="badge badge-primary"><?php echo $statistic['submit_user'];?></span>
                    尝试人数
                </li>
                <li class="list-group-item">
                    <span class="badge badge-primary"><?php echo $statistic['ac_user'];?></span>
                    通过人数
                </li>
                <?php foreach ($statistic['more'] as $key => $value) { ?>
                <li class="list-group-item">
                    <span class="badge badge-<?php echo \YZOI\OJ::$labelcolor[$key]?>"><?php echo $value;?></span>
                    <?php echo \YZOI\OJ::$status[$key];?>
                </li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="col-sm-8">
        <div class="panel widget-followers">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> Best Solution</span>
            </div>
            <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th width="20">Rank</th>
                <th width="80">№</th>
                <th>User</th>
                <th width="30">Time</th>
                <th width="50">Memory</th>
                <th width="50">Lang</th>
                <th width="50">Length</th>
            </tr>
            </thead>
            <tbody>
            <?php if (isset($page->items)) {
            foreach ($page->items as $key => $solution) {?>
            <tr>
                <td><span class="standing-num active">{{ key+1 }}</span></td>
                <td><?php if (intval($solution->attempt)>1) {
                        $parmas = array(
                            'pid' => $problem->id,
                            'username' => $solution->name,
                            'result' => '4'
                        );
                        echo $this->tag->linkTo(array('status' . \YZOI\Common::url_query($parmas), $solution->id . '('. $solution->attempt .')', 'class' => 'text-warning'));
                    } else {
                        echo $solution->id;
                    }
                    ?></td>
                <td>
                    <img src="{{ url('assets/images/avatars/'~solution.avatar) }}" alt="{{ solution.name }}" class="follower-avatar">
                    <div class="body">
                        <a href="{{ url('users/profile/'~solution.users_id) }}" class="follower-name">{{ solution.name }}</a><br>
                        <span class="follower-username">{{ solution.nick }} </span>
                    </div>
                </td>
                <td>{{ solution.time }}</td>
                <td>{{ solution.memory }}</td>
                <td><?php if ($logged_in && $solution->user_can_access($logged_in)) {
                        echo $this->tag->linkTo(array(
                            'status/show/' . $solution->id,
                            \YZOI\OJ::$language[$solution->language],
                            'class' => 'text-warning'
                        ));
                    } else {
                        echo \YZOI\OJ::$language[$solution->language];
                    }?></td>
                <td>{{ solution.code_length }}</td>
            </tr>
            <?php }} ?>
            </tbody>
            </table>
            <div class="panel-footer">
                <ul class="pager">
                    <li><a href="{{ url('problems/statistic/'~problem.id~'?page='~page.first) }}"><i class="fa fa-fast-backward"></i> First</a></li>
                    <li><a href="{{ url('problems/statistic/'~problem.id~'?page='~page.before) }}"><i class="fa fa-arrow-left"></i> Newer</a></li>
                    <li><a href="{{ url('problems/statistic/'~problem.id~'?page='~page.next) }}">Older <i class="fa fa-arrow-right"></i></a></li>
                    <li><a href="{{ url('problems/statistic/'~problem.id~'?page='~page.last) }}">Last <i class="fa fa-fast-forward"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
init.push(function() {
    $('#problem_summary').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {text:''},
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Brands',
            colorByPoint: true,
            data: [
            <?php foreach ($statistic['more'] as $key => $value) {
                echo '{name:' . "'" . \YZOI\OJ::$status[$key] . "', ";
                echo 'y:' . $value .'},';
            }?>
            ]
        }]
    });
});
</script>














