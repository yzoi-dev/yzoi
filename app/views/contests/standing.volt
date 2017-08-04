{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-followers">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 测试排名</span>
                <div class="panel-heading-controls">
                    <a class="btn btn-xs btn-warning" href="{{ url('contests/show/'~contest.id) }}">
                        <i class="fa fa-reply"></i> Back to List
                    </a>
                </div>
            </div>
            <div class="panel-body padding-sm">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="30">Rank</th>
                        <th>User</th>
                        <th width="100">Penatly</th>
                        <?php
                        $amount_of_problems = $contest->amount_of_problems();
                        for ($i=0; $i< $amount_of_problems; $i++) {
                            echo '<th>Problem ', \YZOI\Common::contest_pid($i), '</th>';
                        }
                        ?>
                        <th width="20">Solved</th>
                        <th width="60">Score</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php
                    $rank = 0;
                    //var_dump($contest->standing());
                    foreach ($contest->standing() as $team) {
                        $rank++
                    ?>
                    <tr>
                        <td><span class="standing-num<?php echo ($rank<=3) ? " active" : ""; ?>"><?php echo $rank;?></span></td>
                        <td>
                            <img src="{{ url('assets/images/avatars/'~team.avatar) }}" alt="{{team.name}}" class="follower-avatar">
                            <div class="body">
                                <a href="{{ url('users/profile/'~team.users_id) }}" class="follower-name">{{team.name}}</a><br>
                                <span class="follower-username">{{ team.nick }}</span>
                            </div>
                        </td>
                        <td><?php echo \YZOI\Common::convert_contest_time($team->time)?></td>
                        <?php
                        $total_score = 0;
                        for ($i=0; $i< $amount_of_problems; $i++) {
                            $pdata = $team->problem_status($i);
                            $total_score += $pdata['score'];
                            echo '<td>';
                            if ($pdata['accept_at']) {
                                echo '<span class="label label-success">', \YZOI\Common::convert_contest_time($pdata['accept_at']), '</span>';
                                if ($pdata['wa_count']) {
                                    echo '<span class="label label-warning">(-', $pdata['wa_count'], ')</span>';
                                }
                            } else {
                                if ($pdata['wa_count']) {
                                    echo '<span class="label label-warning">(-', $pdata['wa_count'], ')</span>';
                                } else {
                                    echo '&nbsp;';
                                }
                            }
                            echo '</td>';
                        }
                        ?>

                        <td>{{ team.solved }}</td>
                        <td>{{ total_score }}</td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-foricon colourable">
            <div class="panel-body text-center">
                <ul class="pagination">
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('contests/list?page=') . $i . "'>" . $i . "</a></li>";
                    }?>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}
