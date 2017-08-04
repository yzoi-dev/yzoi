<body class="theme-dust main-menu-fixed">
<div id="main-wrapper">
    <div id="main-navbar" class="navbar navbar-inverse" role="navigation">
        <div class="navbar-inner">
            <div class="navbar-header">
                <a href="{{ url('') }}" class="navbar-brand"><i class="fa fa-codepen"></i> <strong>YZOI</strong> - Online Judge</a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-navbar-collapse"><i class="navbar-icon fa fa-bars"></i></button>
            </div>
            <div id="main-navbar-collapse" class="collapse navbar-collapse main-navbar-collapse">
                <div>
                    <ul class="nav navbar-nav">
                        <li><button type="button" id="main-menu-toggle"><i class="navbar-icon fa fa-bars icon"></i><span class="hide-menu-text">HIDE MENU</span></button></li>
                    </ul>
                    <div class="right clearfix">
                        <ul class="nav navbar-nav pull-right right-navbar-nav">
                            <li>
                                <form class="navbar-form pull-left">
                                    <input type="text" class="form-control go-query" id="goto_pid" placeholder="题目ID">
                                    <button id="goto_btn" type="button"><i class="fa fa-rocket"></i></button>
                                </form>
                            </li>
                            <li>
                                <form class="navbar-form pull-left" action="{{ url('problems/search') }}" method="get">
                                    <select name="s" class="form-control search-query">
                                        <optgroup label="题库搜索">
                                            <option value="tl"
                                                <?php if ($this->session->has("searching-scope"))
                                                {
                                                    if ($this->session->get("searching-scope") == "tl")
                                                        echo " selected='selected'";
                                                } else echo " selected='selected'";?>>标题</option>
                                            <option value="ct"
                                                <?php if ($this->session->has("searching-scope")
                                                && $this->session->get("searching-scope") == "ct")
                                                    echo " selected='selected'"; ?>>内容</option>
                                            <option value="sr"
                                                <?php if ($this->session->has("searching-scope")
                                                    && $this->session->get("searching-scope") == "sr")
                                                    echo " selected='selected'"; ?>>来源</option>
                                        </optgroup>
                                        <optgroup label="教程搜索">
                                            <option value="tp">教程标题</option>
                                        </optgroup>
                                    </select>
                                    <input type="text" name="w" class="form-control search-query" placeholder="关键字……"
                                    <?php if ($this->session->has("searching-word")) echo "value=" . $this->session->get("searching-word"); ?>>
                                    <button type="submit"><i class="fa fa-search"></i></button>
                                </form>
                            </li>
                            {% if not(logged_in is empty) and logged_in %}
                                {{ partial("partials/userstopmenu") }}
                            {% else %}
                            <li>
                                {{ link_to("users/login", "登录") }}
                            </li>
                            <li>
                                {{ link_to("users/register", "注册") }}
                            </li>
                            {% endif %}
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
                    {% if not(logged_in is empty) and logged_in %}
                        {{ partial("partials/usersidermenu") }}
                    {% else %}
                        {{ link_to("users/login", "登录", "class":"text-warning") }}后更精彩
                    {% endif %}
                    <a href="javascript:;" class="close">&times;</a>
                </div>
            </div>
            {{ partial("partials/mainsider") }}
            <div class="menu-content text-center" id="back-to-top-container"></div>
        </div> <!-- / #main-menu-inner -->
    </div> <!-- / #main-menu -->

    <div id="content-wrapper">
        <div class="page-header page-header-breadcrumb">
            <h1><i class="fa fa-windows"></i> {{ title }}</h1>
            <ul class="breadcrumb breadcrumb-page">
                <li><a href="{{ url('') }}">Home</a></li>
                <li><a href="{{ url(dispatcher.getControllerName()) }}"><?php echo ucfirst($this->dispatcher->getControllerName())?></a></li>
                <li class="active"><?php echo ucfirst($this->dispatcher->getActionName())?></li>
            </ul>
        </div>

        {{ content() }}

    </div>

    <div id="main-menu-bg"></div>
</div>

{% include "partials/footer.volt" %}

{{ javascript_include('assets/js/jquery.js') }}
{# javascript_include('assets/markdown-plus.min.js') #}
{{ javascript_include('assets/js/bootstrap.js') }}


{% if additionalJS is defined %}
{% for js in additionalJS %}
{{ javascript_include(js) }}
{% endfor %}
{% endif %}


{{ javascript_include('assets/js/yzoiapp.js') }}

<script type="text/javascript">
    window.LanderApp.start(init);
</script>

</body>