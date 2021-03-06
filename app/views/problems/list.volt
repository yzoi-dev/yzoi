{{ content() }}

{{ flashSession.output() }}

{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-foricon colourable">
            <div class="panel-body text-center no-padding-t">
                <div class="widget-profile-bg-icon"><i class="fa fa-codepen"></i></div>
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-navicon"></i> Problem Volume Navigator</h6>
                <ul class="pagination">
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('problems/list?page=') . $i . "'>" . $i . "</a></li>";
                    }?>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}

<div class="row collapse" id="tagslist">
    <div class="col-sm-12">
        <div class="panel widget-foricon colourable ">
            <div class="panel-body no-padding-t stat-cell">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-tags"></i> Problem Searching Tags</h6>
                <i class="fa fa-tags bg-icon"></i>
                <div class="taglist">
                    <?php foreach ($metas as $meta) {
                        //根据题目数显示不同的标签颜色
                        if ($meta->count >= 40)
                            $tagcolor = 5;
                        else {
                            $tagcolor = ceil(intval($meta->count) / 10);
                        }
                        echo "<a href='" . $this->url->get('problems/tag/') . $meta->id ."' class='label ";
                        echo \YZOI\OJ::$tagcolor[$tagcolor] . " label-tag'>" . $meta->name;
                        echo " (" . $meta->count . ")</a>";
                    }?>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> Problem Set</span>
                <div class="panel-heading-controls">
                    <button class="btn btn-xs btn-warning" data-toggle="collapse" data-target="#tagslist">
                        <i class="fa fa-tags"></i> 分类标签
                    </button>
                </div>
            </div>
            <div class="panel-body padding-sm">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="20"></th>
                        <th width="60">ID</th>
                        <th>Problem Title</th>
                        <th width="220">Source</th>
                        <th width="70">AC Ratio</th>
                        <th width="60">Solved</th>
                        <th width="60">Tries</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if (isset($page->items)) {
                        foreach ($page->items as $problem) {
                            if ($problem->active == 'Y') {
                    ?>
                    <tr>
                        <td><?php $pass = \YZOI\Common::accept_status($problem->id);
                            if ($pass !== null) {
                                if ($pass) echo "<i class='fa fa-check-circle text-success'></i>";
                                else echo "<i class='fa fa-times-circle text-danger'></i>";
                            } ?></td>
                        <td>{{ problem.id }}</td>
                        <td class="nowrap">
                            <a href="{{ url('problems/show/'~problem.id) }}" class="text-warning">{{ problem.title }}</a>
                        </td>
                        <td><a href="{{ url('problems/search?s=src&w='~problem.sources) }}">{{ problem.sources }}</a></td>
                        <td><?php echo ($problem->submit)? round($problem->accepted * 100 / $problem->submit) : 0; ?>%</td>
                        <td>{{ problem.solved }}</td>
                        <td>{{ problem.submit }}</td>
                    </tr>
                    <?php } } } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

