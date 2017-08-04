<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{{ title }} - YZOI Online Judge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <!-- LanderApp's stylesheets -->
    {{ stylesheet_link('assets/css/bootstrap.min.css') }}
    {{ stylesheet_link('assets/css/font.css') }}
    {{ stylesheet_link('assets/css/yzoiapp.min.css') }}
    {{ stylesheet_link('assets/css/pages.min.css') }}
    {{ stylesheet_link('assets/css/themes.min.css') }}

    {% if additionalCss is defined %}
    {% for css in additionalCss %}
    {{ stylesheet_link(css) }}
    {% endfor %}
    {% endif %}
    <script type="text/javascript">
        var init = [];
    </script>
</head>

<body class="theme-default main-menu-animated main-menu-fixed">
<div id="main-wrapper">
    <div id="main-navbar" class="navbar navbar-inverse" role="navigation">
        <div class="navbar-inner">
            <div class="navbar-header">
                <a href="{{ url(admin_uri~'/index') }}" class="navbar-brand"><i class="fa fa-codepen"></i> <strong>YZOI</strong> - Online Judge</a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse"><i class="navbar-icon fa fa-bars"></i></button>
            </div>
            <div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
                <div>
                    <ul class="nav navbar-nav hidden">
                        <li><a href="{{ url(admin_uri~'/problems/create') }}"> 新建题目</a></li>
                        <li><a href="{{ url(admin_uri~'/problems/list') }}"> 题目列表</a></li>
                    </ul>
                    <div class="right clearfix">
                        <ul class="nav navbar-nav pull-right right-navbar-nav">
                            <li>
                                <form class="navbar-form pull-left">
                                    <input type="text" class="form-control go-query" id="goto_pid_admin" placeholder="题目ID">
                                    <button id="goto_btn_admin"><i class="fa fa-rocket"></i></button>
                                </form>
                            </li>
                            <li>
                                <form class="navbar-form pull-left" action="{{ url('problems/search') }}" method="get">
                                    <select name="s" class="form-control search-query">
                                        <optgroup label="题库搜索">
                                            <option value="tl" selected="selected">标题</option>
                                            <option value="ct">内容</option>
                                            <option value="sr">来源</option>
                                        </optgroup>
                                        <optgroup label="教程搜索">
                                            <option value="tp">教程标题</option>
                                        </optgroup>
                                    </select>
                                    <input type="text" class="form-control search-query" placeholder="题目搜索……" name="w">
                                    <button type="submit"><i class="fa fa-search"></i></button>
                                </form>
                            </li>
                            {{ partial("../partials/userstopmenu") }}
                        </ul> <!-- / .navbar-nav -->
                    </div> <!-- / .right -->
                </div>
            </div> <!-- / #main-navbar-collapse -->
        </div> <!-- / .navbar-inner -->
    </div> <!-- / #main-navbar -->

    <div id="main-menu" role="navigation">
        <div id="main-menu-inner">
            <div class="menu-content top" id="user-sider-menu">
                <div>
                    {{ partial("../partials/usersidermenu") }}
                    <a href="javascript:;" class="close">&times;</a>
                </div>
            </div>
            {{ partial("partials/mainsider") }}
            <div class="menu-content">
                <a href="{{ url(admin_uri~'/importoldsolution')}}" class="btn btn-primary btn-block btn-outline dark">代码导入</a>
            </div>
        </div> <!-- / #main-menu-inner -->
    </div> <!-- / #main-menu -->

    <div id="content-wrapper">
        <div class="page-header">
            <h1><i class="fa fa-university"></i> {{ title }}</h1>
        </div>

        {{ content() }}

    </div>

    <div id="main-menu-bg"></div>
</div>

{% include "partials/footer.volt" %}

{{ javascript_include('assets/js/jquery.js') }}
{{ javascript_include('assets/js/bootstrap.js') }}

{% if additionalJS is defined %}
{% for js in additionalJS %}
{{ javascript_include(js) }}
{% endfor %}
{% endif %}
{{ javascript_include('assets/js/yzoiapp.js') }}


<script type="text/javascript">
function goto_problem(pid) {
    if (pid>999 && pid <9999)
        window.location.href = "{{ url(admin_uri~'/problems/edit/') }}" + pid;
    else
        alert("Problem ID Error!");
};
$("#goto_pid_admin").keydown(function(e) {
    if (e.which == 13){
        e.preventDefault();
        var pid = $("#goto_pid_admin").val();
        goto_problem(pid);
    }
});
$("#goto_btn_admin").on("click", function() {
    var pid = $("#goto_pid_admin").val();
    goto_problem(pid);
});
window.LanderApp.start(init);
</script>

</body>
</html>