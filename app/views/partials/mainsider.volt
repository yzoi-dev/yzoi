<?php
$this_controller = $this->dispatcher->getControllerName();
$this_action = $this->dispatcher->getActionName();
?>
<ul class="navigation">
    <li class="{% if this_controller == 'index' %}active{% endif %}">
        <a href="{{ url('') }}"><i class="menu-icon fa fa-university"></i><span class="mm-text">首页</span></a>
    </li>

    <li>
        <a href="{{ url('problems') }}"><i class="menu-icon fa fa-th-list"></i><span class="mm-text">训练题库</span></a>
    </li>

    <li class="mm-dropdown{% if this_controller == 'problems' %} active open{% endif %}">
        <a href="{{ url('problems') }}"><i class="menu-icon fa fa-th"></i><span class="mm-text">题库分类</span></a>
        {{ menuCategories }}
    </li>
    <li class="{% if this_controller == 'status' %}active{% endif %}">
        <a href="{{ url('status') }}"><i class="menu-icon fa fa-gavel"></i><span class="mm-text">测评结果</span></a>
    </li>
    <li class="{% if this_action == 'rank' %}active{% endif %}">
        <a href="{{ url('users/rank') }}"><i class="menu-icon fa fa-trophy"></i><span class="mm-text">学生排名</span></a>
    </li>
    <li class="mm-dropdown{% if this_controller == 'contests' %} active open{% endif %}">
        <a href="{{ url('contests') }}"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">作业/比赛</span></a>
        <ul>
            <li class="{% if this_controller == 'contests' and this_action == 'list' %}active{% endif %}">
                <a href="{{ url('contests/list') }}"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">比赛列表</span></a>
            </li>
            <?php if ($this_controller == 'contests') {
            if ($this_action == 'show' || $this_action == 'view' || $this_action == 'status' || $this_action == 'standing' || $this_action == 'statistic') {
            ?>
            <li class="mm-dropdown active open">
                <a href="{{ url('contests') }}"><i class="menu-icon fa fa-table"></i><span class="mm-text">{{ contest.id }}的比赛情况</span></a>
                <ul>
                    <li class="mm-dropdown{% if this_action == 'show' or this_action == 'view'  %}  active open {% endif %}">
                        <a href="{{ url('contests/show/'~contest.id) }}"><i class="menu-icon fa fa-list"></i> 比赛题目</a>
                        <ul>
                            <li{% if this_action == 'show' %} class="active"{% endif %}><a href="{{ url('contests/show/'~contest.id) }}"><i class="menu-icon fa fa-list"></i> 所有题目</a></li>
                <?php foreach ($contest->problems() as $key => $ctp) {
                    echo "<li";
                    $this_params = $this->dispatcher->getParams();
                    if ($this_action = 'view' && isset($this_params[1]) && $this_params[1] == $key) echo " class='active'";
                    echo ">";
                    echo $this->tag->linkTo("contests/view/".$contest->id."/".$key, "<i class='menu-icon fa fa-file-powerpoint-o'></i> 题".\YZOI\Common::contest_pid($key));
                    echo "</li>";
                }?>
                        </ul>
                    </li>
                    <li{% if this_action == 'status' %} class="active"{% endif %}><a href="{{ url('contests/status?cid='~contest.id) }}"><i class="menu-icon fa fa-gavel"></i> 评分情况</a></li>
                    <li{% if this_action == 'standing' %} class="active"{% endif %}><a href="{{ url('contests/standing/'~contest.id) }}"><i class="menu-icon fa fa-line-chart"></i>测验排名</a></li>
                    <li{% if this_action == 'statistic' %} class="active"{% endif %}><a href="#"><i class="menu-icon fa fa-pie-chart"></i> <s>数据统计</s></a></li>
                </ul>
            </li>
            <?php } } ?>
        </ul>
    </li>
    <li>
        <a href="{{ url('topics') }}"><i class="menu-icon fa fa-comments"></i><span class="mm-text">社区</span></a>
    </li>
    <li>
        <a href="{{ url('topics/list/tutorial') }}"><i class="menu-icon fa fa-key"></i><span class="mm-text">帮助教程</span></a>
    </li>
    <li class="mm-dropdown">
        <a href="javascript:;"><i class="menu-icon fa fa-cloud"></i><span class="mm-text">学习资源</span></a>
        <ul>
            <li>
                <a href="/docs/" target="_blank"><i class="menu-icon fa fa-book"></i><span class="mm-text">算法文库</span></a>
            </li>
            <li class="mm-dropdown">
                <a href="javascript:;"><i class="menu-icon fa fa-book"></i><span class="mm-text">学生博客</span></a>
                <ul>
                    <li><a href="http://www.cnblogs.com/vb4896/" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">lzw4896s</span></a></li>
                    <li><a href="http://definiter.net/archives/category/diary/page/3" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">王皓</span></a></li>
                    <li><a href="http://chper.cn/blog" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">鹏鹏</span></a></li>
                    <li><a href="http://www.cnblogs.com/zcyhhh" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">zcyhhh</span></a></li>
                    <li><a href="http://hzwer.com/" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">黄哲威</span></a></li>
                </ul>
            </li>
            <li class="mm-dropdown">
                <a href="javascript:;"><i class="menu-icon fa fa-book"></i><span class="mm-text">参考手册/教程</span></a>
                <ul>
                    <li><a href="http://www.cplusplus.com" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">cplusplus.com</span></a></li>
                    <li><a href="http://www.cplusplus.com/reference/clibrary" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">C Library</span></a></li>
                    <li><a href="http://www.cplusplus.com/reference/stl" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">STL</span></a></li>
                    <li><a href="http://zh.cppreference.com/w/cpp" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">CPP WIKI</span></a></li>
                    <li><a href="http://www.cplusplus.com/doc" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">CPP 教程</span></a></li>
                </ul>
            </li>
			<li class="mm-dropdown">
                <a href="javascript:;"><i class="menu-icon fa fa-graduation-cap"></i><span class="mm-text">在线课程</span></a>
                <ul>
                    <li><a href="https://www.coursera.org/course/program" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">程序设计与算法（北大）</span></a></li>
                </ul>
            </li>
            <li class="mm-dropdown">
                <a href="javascript:;"><i class="menu-icon fa fa-graduation-cap"></i><span class="mm-text">Online Judge</span></a>
                <ul>
                    <li><a href="http://poj.org" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">PKU</span></a></li>
                    <li><a href="http://noi.openjudge.cn/" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">NOI题库</span></a></li>
                    <li><a href="https://vjudge.net/contest" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">专题测试</span></a></li>
                </ul>
            </li>
            <li><a href="http://www.cs.usfca.edu/~galles/visualization/Algorithms.html" target="_blank"><i class="menu-icon fa fa-graduation-cap"></i><span class="mm-text">算法演示（旧金山大学）</span></a></li>
        </ul>
    </li>
</ul>