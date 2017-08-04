{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 搜索关键字 : <?php if ($this->session->has("searching-word"))
                    echo "<span class='text-danger'>" . $this->session->get("searching-word") . "</span>";
                    echo " (共" . $page->total_items ."题)";
                    ?></span>
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
                            <a href="{{ url('problems/show/'~problem.id) }}" class="text-warning" target="_blank">{{ problem.title }}</a>
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

{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-foricon colourable">
            <div class="panel-body text-center">
                <ul class="pagination">
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('problems/search?page=') . $i;
                        if ($this->session->has("searching-scope"))
                            echo "&s=" . $this->session->get("searching-scope");
                        if ($this->session->has("searching-word"))
                            echo "&w=" . $this->session->get("searching-word");
                        echo "'>" . $i . "</a></li>";
                    }?>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}
