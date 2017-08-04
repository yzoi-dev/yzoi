{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12" id="problemlist">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> User List</span>
            </div>
            <div class="alert alert-page alert-info alert-dark">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <strong>注意：</strong> 删除线表示该用户未激活，Administrator = 最高管理员， Ultraman = 管理员。
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th width="20">ID</th>
                        <th>User Name</th>
                        <th width="80">Type</th>
                        <th width="50">Operate</th>
                        <th width="50">Perm</th>
                        <th>Nick</th>
                        <th>School</th>
                        <th width="60">Solved</th>
                        <th width="60">Tries</th>
                        <th>Last Login</th>
                    </tr>
                    </thead>
                    <tbody>
                    {% if page.items is defined %}
                    {% for user in page.items %}

                    <?php $textclass = ($user->active == 'Y') ? 'text-warning' : 'text-line-through'; ?>
                    <tr>
                        <td>{{ user.id }}</td>
                        <td class="nowrap"><a href="{{ url('users/profile/'~user.id) }}" target="_blank" class="{{ textclass }}">{{ user.name }}</a></td>
                        <td><?php if (isset($user->privilege)) {
                                foreach ($user->privilege as $upn)
                                    if ($upn->name == "Administrator" || $upn->name == "Ultraman")
                                    echo "<span class='label label-warning'>" . $upn->name . "</span>";
                            } ?></td>
                        <td><a href="{{ url(admin_uri~'/users/edit/'~user.id) }}"><i class="fa fa-edit"></i> Edit</a></td>
                        <td>{{ user.view_perm }}</td>
                        <td>{{ user.nick }}</td>
                        <td>{{ user.school }}</td>
                        <td class="user_solved"><a href="javascript:;" data-value="{{user.id}}" class="btn btn-success btn-sm"><i class="fa fa-refresh"></i> {{ user.solved }} </a></td>
                        <td class="user_submit">{{ user.submit }}</td>
                        <td>{{ date('Y-m-d H:i', user.last_login) }}</td>
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
                    <li><a href="{{ url(admin_uri~'/users/list?page='~page.first) }}"><i class="fa fa-angle-double-left"></i></a></li>
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                            echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='/yzoix/yzoi7x/users/list?page=" . $i . "'>" . $i . "</a></li>";
                    }?>
                    <li><a href="{{ url(admin_uri~'/users/list?page='~page.first) }}"><i class="fa fa-angle-double-right"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
{% endif %}
<script type="text/javascript">
init.push(function() {
    $('td.user_solved a').click(function (element) {
        var userid = $(this).data("value");
        $.get("{{ url(admin_uri~'/users/usersolve') }}",
            {"user_id" : userid},
            function(data) {
                $(this).html(data);
                //$('.user_solved').html(data);
            });
    });
})
</script>