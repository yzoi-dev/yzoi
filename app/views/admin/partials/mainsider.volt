<ul class="navigation">
    <li>
        <a href="{{ url('') }}"><i class="menu-icon fa fa-university"></i><span class="mm-text">网站首页</span></a>
    </li>
    <li>
        <a href="{{ url(admin_uri~'/index') }}"><i class="menu-icon fa fa-cogs"></i><span class="mm-text">后台首页</span></a>
    </li>
    <li class="mm-dropdown{% if dispatcher.getControllerName()=='problems' %} active open{% endif %}">
        <a href="javascript:;"><i class="menu-icon fa fa-th"></i><span class="mm-text">题库管理</span></a>
        <ul>
            <li{% if dispatcher.getActionName()=='list' %} class="active"{% endif %}>
                <a href="{{ url(admin_uri~'/problems/list') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">题目列表</span></a>
            </li>
            {% if dispatcher.getActionName()=='edit' and problem.id is defined %}
            <li class="active">
            <a href="javascript:;"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">编辑题目：{{ problem.id }}</span></a>
            </li>
            {% endif %}
            <li{% if dispatcher.getActionName()=='create' %} class="active"{% endif %}>
                <a href="{{ url(admin_uri~'/problems/create') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">新增题目</span></a>
            </li>
            <li{% if dispatcher.getActionName()=='refreshstatic' %} class="active"{% endif %}>
                <a href="{{ url(admin_uri~'/problems/refreshstatic') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">刷新题库AC率</span></a>
            </li>
        </ul>
    </li>
    <li class="mm-dropdown{% if dispatcher.getControllerName()=='metas' %} active open{% endif %}">
        <a href="javascript:;"><i class="menu-icon fa fa-tags"></i><span class="mm-text">分类/标签管理</span></a>
        <ul>
            <li{% if dispatcher.getActionName()=='addcate' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/metas/addcate') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">分类列表/新增</span></a>
            </li>
            {% if dispatcher.getActionName()=='editcate' and category.id is defined %}
            <li class="active">
            <a href="javascript:;"><i class="menu-icon fa fa-pencil"></i><span class="mm-text">编辑分类：{{ category.id }}</span></a>
            </li>
            {% endif %}

            <li{% if dispatcher.getActionName()=='addtag' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/metas/addtag') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">标签列表/新增</span></a>
            </li>
            {% if dispatcher.getActionName()=='edittag' and ttag.id is defined %}
            <li class="active">
                <a href="javascript:;"><i class="menu-icon fa fa-pencil"></i><span class="mm-text">编辑标签：{{ ttag.id }}</span></a>
            </li>
            {% endif %}
			<li{% if dispatcher.getActionName()=='updatecount' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/metas/updatecount') }}"><i class="menu-icon fa fa-repeat"></i><span class="mm-text">更新分类题目数</span></a>
            </li>
        </ul>
    </li>
    <?php if ($logged_in && $logged_in->is_admin()) {?>
    <li class="mm-dropdown{% if dispatcher.getControllerName()=='users' %} active open{% endif %}">
        <a href="javascript:;"><i class="menu-icon fa fa-gavel"></i><span class="mm-text">用户管理</span></a>
        <ul>
            <li{% if dispatcher.getActionName()=='list' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/users/list') }}"><i class="menu-icon fa fa-user"></i><span class="mm-text">用户列表</span></a>
            </li>
            {% if dispatcher.getActionName()=='edit' and user.id is defined %}
            <li class="active">
                <a href="javascript:;"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">编辑用户：{{ user.id }}</span></a>
            </li>
            {% endif %}
        </ul>
    </li>
    <li class="mm-dropdown{% if dispatcher.getControllerName()=='importproblems' %} active open{% endif %}">
        <a href="javascript:;"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">题库导入（慎用）</span></a>
        <ul>
            <li{% if dispatcher.getActionName()=='usaco' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/importproblems/usaco') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">导入USACO</span></a>
            </li>
            <li{% if dispatcher.getActionName()=='vijos' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/importproblems/vijos') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">导入Vijos</span></a>
            </li>
        </ul>
    </li>
    <?php } ?>
    <li class="mm-dropdown{% if dispatcher.getControllerName()=='contests' %} active open{% endif %}">
        <a href="javascript:;"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">测验/作业管理</span></a>
        <ul>
            <li{% if dispatcher.getActionName()=='list' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/contests/list') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">测验/作业列表</span></a>
            </li>
            {% if dispatcher.getActionName()=='edit' and contest.id is defined %}
            <li class="active">
                <a href="javascript:;"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">编辑测验/作业：{{ contest.id }}</span></a>
            </li>
            {% endif %}
            <li{% if dispatcher.getActionName()=='create' %} class="active"{% endif %}>
            <a href="{{ url(admin_uri~'/contests/create') }}"><i class="menu-icon fa fa-list-ul"></i><span class="mm-text">新建测验/作业</span></a>
            </li>
        </ul>
    </li>

</ul> <!-- / .navigation -->