{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 所有测试列表</span>
            </div>
            <div class="panel-body padding-sm">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="70">ID</th>
                        <th>Contest Title</th>
                        <th width="280">Status</th>
                        <th width="60">Type</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php if (isset($page->items)) {
                        foreach ($page->items as $contest) {
                    ?>
                    <tr>
                        <td>{{ contest.id }}</td>
                        <td class="nowrap">
                            <a href="{{ url('contests/show/'~contest.id) }}" class="text-warning">{{ contest.title }}</a>
                        </td>
                        <?php
                        echo "<td>";
                        $now = time();
                            // past
                            if ($now > $contest->end_time) {
                                echo "<span class='text-default'>Ended @ " . date("Y-m-d H:i:s", $contest->end_time);
                            // pending
                            } else if ($now < $contest->start_time) {
                                echo "<span class='text-warning'>Start @ " . date("Y-m-d H:i:s", $contest->start_time);
                            } else {
                                echo "<span class='text-success'>Running";
                            }
                        echo "</span></td><td>";

                        if ($contest->is_private == 'N') {
                            echo "<span class='label label-success' data-toggle='tooltip' data-original-title='Public'><i class='fa fa-unlock'></i>";
                        } else {
                            echo "<span class='label label-danger' data-toggle='tooltip' data-original-title='Private'><i class='fa fa-lock'></i>";
                        }
                        echo "</span></td>"
                            ?>
                    </tr>
                    <?php } } ?>
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
