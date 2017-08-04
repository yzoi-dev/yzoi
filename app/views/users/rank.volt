{{ content() }}

{{ flashSession.output() }}

{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-foricon colourable">
            <div class="panel-body text-center">
                <ul class="pagination">
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        $rank_min = 50 * ($i-1) + 1;
                        $rank_max = $rank_min + 50 - 1;
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('users/rank?page=') . $i . "'>" . $rank_min . " - " . $rank_max . "</a></li>";
                    }?>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-users"></i> 所有用户总排名</span>
                <div class="panel-heading-controls" style="width: 30%">
                    <form method="post">
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control" placeholder="Find somebody..." name="s">
                            <span class="input-group-btn">
                                <button class="btn" type="submit">
                                    <span class="fa fa-search"></span>
                                </button>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="60">Rank</th>
                        <th>User</th>
                        <th>Nick</th>
                        <th>AC Ratio</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if (isset($page->items)) {
                        foreach ($page->items as $key=>$rank) {
                    ?>
                    <tr>
                        <td>{{  50 * (page.current-1) + key + 1 }}</td>
                        <td>
                            <a href="{{ url('users/profile/'~rank.id) }}" class="text-warning">
                                <img src="{{ url('assets/images/avatars/'~rank.avatar) }}" class="avatar">
                                {{ rank.name }}</a>
                        </td>
                        <td>{{ rank.nick }}</td>
                        <td><?php if ($rank->submit > 0)
                                $solved_percent = round($rank->solved * 100 / $rank->submit);
                            else
                                $solved_percent = 0; ?>
                            <div class="progress">
                                <div class="progress-bar progress-bar-success" style="width: {{ solved_percent }}%">{{ rank.solved }}</div>
                                <div class="progress-bar progress-bar-warning" style="width: {{ 100-solved_percent }}%">{{ rank.submit - rank.solved }}</div>
                            </div>
                        </td>
                    </tr>
                    <?php } } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
