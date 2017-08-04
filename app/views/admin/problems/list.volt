{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12" id="problemlist">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> Problem Set</span>
                <div class="panel-heading-controls">
                    <span class="panel-heading-text"><em>Searching Problems by Tags:</em></span>
                    <input type="checkbox" data-class="switcher-sm switcher-primary" id="panel-switcher">
                </div>
            </div>
            <div class="alert alert-page alert-info alert-dark">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <strong>注意：</strong> 为了保持题目编号的连续性，系统不允许删除题目，你可以用“取消激活”的方式让其失效；可以用编辑题目的方式进行更改题号。
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="60">ID</th>
                        <th>Problem Title</th>
                        <th width="70">Operate</th>
                        <th width="70">Activity</th>
                        <th width="80">Testdata</th>
                        <th>Time created</th>
                        <th width="60">Tries</th>
                    </tr>
                    </thead>
                    <tbody>
                    {% if page.items is defined %}
                    {% for problem in page.items %}
                    <tr>
                        <td>{{ problem.id }}</td>
                        <td class="nowrap">
                            <a href="{{ url('problems/show/'~problem.id) }}" class="text-warning" target="_blank">{{ problem.title }}</a>
                            {% if problem.spj %}
                            <span class="label label-success label-tag">SPJ</span>
                            {% endif %}
                            {% if problem.view_perm > 1 %}
                            <span class="label label-light-green label-tag">YZOIer</span>
                            {% endif %}
                        </td>
                        <td><a href="{{ url('yzoi7x/problems/edit/'~problem.id) }}"><i class="fa fa-edit"></i> Edit</a></td>
                        <td>
                            {% if problem.active == 'Y' %}
                            <button class="btn btn-xs btn-labeled btn-success problem-status" data-value="{{ problem.id }}" id="P{{ problem.id }}"><span class="btn-label icon fa fa-check"></span> Y</button>
                            {% else %}
                            <button class="btn btn-xs btn-labeled btn-danger problem-status" data-value="{{ problem.id }}" id="P{{ problem.id }}"><span class="btn-label icon fa fa-times"></span> N</button>
                            {% endif %}
                        </td>
                        <td><a href="#dataModal" data-toggle="modal" class="btn btn-xs testdata" data-value="{{ problem.id }}">Testdata</a></td>
                        <td>{{ date('Y-m-d H:i:s', problem.modify_at) }}</td>
                        <td>{{ problem.submit }}</td>
                    </tr>
                    {% endfor %}
                    {% endif %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
{% if page.items is defined %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body text-center">
                <ul class="pagination">
                    <li><a href="{{ url('yzoi7x/problems/list?page='~page.first) }}"><i class="fa fa-angle-double-left"></i></a></li>
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                            echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('yzoi7x/problems/list?page=') . $i . "'>" . $i . "</a></li>";
                    }?>
                    <li><a href="{{ url('yzoi7x/problems/list?page='~page.first) }}"><i class="fa fa-angle-double-right"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}
{% include("partials/testdata") %}
<script type="text/javascript">
init.push(function() {
    $('button.problem-status').click(function(){
        var problem_id = $(this).attr('data-value');
        var element = $('#P' + problem_id);
        //console.log(problem_id);
        if (element.hasClass("btn-success"))
        {
            var user_ok = confirm('您确定要将题目'+ problem_id +'置为禁用状态吗？');
        } else {
            var user_ok = confirm('您确定要将题目'+ problem_id +'置为可用状态吗？');
        }
        if (user_ok)
        {
            var url = "{{ url('yzoi7x/problems/status/') }}";
            $.getJSON(url, {'problem_id': problem_id}, function(response){
                //console.log(response);
                if (element.hasClass("btn-success"))
                {
                    element.removeClass("btn-success");
                    element.addClass("btn-danger");
                    element.html("<span class='btn-label icon fa fa-times'></span> " + response);
                } else {
                    element.removeClass("btn-danger");
                    element.addClass("btn-success");
                    element.html("<span class='btn-label icon fa fa-check'></span> " + response)
                }
                //check_defunct(problem_id);
            })
        }
    });
});
</script>