{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> Contest Set</span>
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="60">ID</th>
                        <th>Contest Title</th>
                        <th width="70">Operate</th>
                        <th width="70">Activity</th>
                        <th width="90">Private</th>
                        <th>Time Range</th>
                    </tr>
                    </thead>
                    <tbody>
                    {% if page.items is defined %}
                    {% for contest in page.items %}
                    <tr>
                        <td>{{ contest.id }}</td>
                        <td class="nowrap">
                            <a href="ads" class="text-warning">{{ contest.title }}</a>
                        </td>
                        <td><a href="{{ url('yzoi7x/contests/edit/'~contest.id) }}"><i class="fa fa-edit"></i> Edit</a></td>
                        <td>
                            {% if contest.active == 'Y' %}
                            <button class="btn btn-xs btn-labeled btn-success contest-status" data-value="{{ contest.id }}" id="Cs{{ contest.id }}"><span class="btn-label icon fa fa-check"></span> Y</button>
                            {% else %}
                            <button class="btn btn-xs btn-labeled btn-danger contest-status" data-value="{{ contest.id }}" id="Cs{{ contest.id }}"><span class="btn-label icon fa fa-times"></span> N</button>
                            {% endif %}
                        </td>
                        <td>
                            {% if contest.is_private == 'Y' %}
                            <button class="btn btn-xs btn-labeled btn-warning contest-private" data-value="{{ contest.id }}" id="Cp{{ contest.id }}"><span class="btn-label icon fa fa-lock"></span> Private</button>
                            {% else %}
                            <button class="btn btn-xs btn-labeled btn-success contest-private" data-value="{{ contest.id }}" id="Cp{{ contest.id }}"><span class="btn-label icon fa fa-unlock"></span> Public</button>
                            {% endif %}
                        </td>
                        <td>
                            {{ date('Y-m-d H:i:s', contest.start_time) }} <i class="fa fa-long-arrow-right">
                            {{ date('Y-m-d H:i:s', contest.end_time) }}
                        </td>
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
                    <li><a href="{{ url('yzoi7x/contests/list?page='~page.first) }}"><i class="fa fa-angle-double-left"></i></a></li>
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                            echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('yzoi7x/contests/list?page=') . $i . "'>" . $i . "</a></li>";
                    }?>
                    <li><a href="{{ url('yzoi7x/contests/list?page='~page.last) }}"><i class="fa fa-angle-double-right"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}

<script type="text/javascript">
init.push(function() {
    $('button.contest-status').click(function(){
        var contest_id = $(this).attr('data-value');
        var element = $('#Cs' + contest_id);

        if (element.hasClass("btn-success"))
        {
            var user_ok = confirm('您确定要将测验'+ contest_id +'置为私有吗？');
        } else {
            var user_ok = confirm('您确定要将测验'+ contest_id +'置为可用状态吗？');
        }
        if (user_ok)
        {
            var url = "{{ url('yzoi7x/contests/status/') }}";
            $.getJSON(url, {'contest_id': contest_id}, function(response){
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

    $('button.contest-private').click(function(){
        var contest_id = $(this).attr('data-value');
        var element = $('#Cp' + contest_id);

        if (element.hasClass("btn-success"))
        {
            var user_ok = confirm('您确定要将测验'+ contest_id +'置为私有比赛吗？（私有比赛必须设置用户才能参赛）');
        } else {
            var user_ok = confirm('您确定要将测验'+ contest_id +'置为公有吗？（注册用户都能参赛）');
        }
        if (user_ok)
        {
            var url = "{{ url('yzoi7x/contests/private/') }}";
            $.getJSON(url, {'contest_id': contest_id}, function(response){
                //console.log(response);
                if (element.hasClass("btn-success"))
                {
                    element.removeClass("btn-success");
                    element.addClass("btn-warning");
                    element.html("<span class='btn-label icon fa fa-lock'></span> " + response);
                } else {
                    element.removeClass("btn-warning");
                    element.addClass("btn-success");
                    element.html("<span class='btn-label icon fa fa-unlock'></span> " + response)
                }
                //check_defunct(problem_id);
            })
        }
    });
});
</script>