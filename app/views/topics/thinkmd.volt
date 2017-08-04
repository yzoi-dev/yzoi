
<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>测试markdown-plus - YZOI Online Judge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <!-- LanderApp's stylesheets -->

    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/font.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/yzoiapp.min.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/pages.min.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/themes.min.css" />

    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/stylesheets/thinker-md.vendor.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/nature.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/object.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/people.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/place.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/Sysmbols.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/thinkermd/emoji/twemoji.css" />
    <link rel="stylesheet" type="text/css" href="/yzoix/assets/css/katex.min.css" />

    <script type="text/javascript">
        var init = [];
    </script>
</head>

<body class="theme-dust main-menu-fixed">
<div id="main-wrapper">
    <div id="main-navbar" class="navbar navbar-inverse" role="navigation">
        <div class="navbar-inner">
            <div class="navbar-header">
                <a href="/yzoix/" class="navbar-brand"><i class="fa fa-codepen"></i> <strong>YZOI</strong> - Online Judge</a>
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
                                <form class="navbar-form pull-left" action="/yzoix/problems/search" method="get">
                                    <select name="s" class="form-control search-query">
                                        <optgroup label="题库搜索">
                                            <option value="tl"
                                                    selected='selected'>标题</option>
                                            <option value="ct"
                                            >内容</option>
                                            <option value="sr"
                                            >来源</option>
                                        </optgroup>
                                        <optgroup label="教程搜索">
                                            <option value="tp">教程标题</option>
                                        </optgroup>
                                    </select>
                                    <input type="text" name="w" class="form-control search-query" placeholder="关键字……"
                                    >
                                    <button type="submit"><i class="fa fa-search"></i></button>
                                </form>
                            </li>
                            <!--<li class="nav-icon-btn nav-icon-btn-danger dropdown">
<a href="#notifications" class="dropdown-toggle" data-toggle="dropdown">
<span class="label">5</span>
<i class="nav-icon fa fa-bullhorn"></i>
<span class="small-screen-text">Notifications</span>
</a>
<div class="dropdown-menu widget-notifications no-padding" style="width: 300px">
<div class="notifications-list" id="main-navbar-notifications">

notification

</div>
<a href="#" class="notifications-link">MORE NOTIFICATIONS</a>
</div>
</li>
<li class="nav-icon-btn nav-icon-btn-success dropdown">
<a href="#messages" class="dropdown-toggle" data-toggle="dropdown">
<span class="label">10</span>
<i class="nav-icon fa fa-envelope"></i>
<span class="small-screen-text">Income messages</span>
</a>
<div class="dropdown-menu widget-messages-alt no-padding" style="width: 300px;">
<div class="messages-list" id="main-navbar-messages">

message

</div>
<a href="/yzoix/users/mailbox" class="messages-link">MORE MESSAGES</a>
</div>
</li>
-->
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle user-menu" data-toggle="dropdown">
                                    <img src="/yzoix/assets/images/avatars/xaero.jpg">
                                    <span>xaero</span>
                                    <i class="fa fa-caret-down"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="/yzoix/users"><i class='dropdown-icon fa fa-user'></i> Profile</a></li>
                                    <li><a href="/yzoix/users/mailbox"><i class="dropdown-icon fa fa-envelope"></i> Messages <span class="badge badge-primary pull-right">new</span></a></li>
                                    <li><a href="/yzoix/users/modify"><i class="dropdown-icon fa fa-cog"></i> Settings</a></li>
                                    <li class="divider"></li>
                                    <li><a href="/yzoix/yzoi7x/problems/list"><i class="fa fa-cogs"></i> Administration</a></li>
                                    <li class="divider"></li>
                                    <li><a href="/yzoix/users/logout"><i class='dropdown-icon fa fa-power-off'></i> Log Out</a></li>
                                </ul>
                            </li>                                                    </ul> <!-- / .navbar-nav -->
                    </div> <!-- / .right -->
                </div>
            </div> <!-- / #main-navbar-collapse -->
        </div> <!-- / .navbar-inner -->
    </div> <!-- / #main-navbar -->

    <div id="main-menu" role="navigation">
        <div id="main-menu-inner">
            <div class="menu-content top" id="user-sider-menu">
                <div>
                    <div class="text-bg"><span class="text-semibold">xaero</span></div>

                    <a href="/yzoix/users"><img src="/yzoix/assets/images/avatars/xaero.jpg"></a>
                    <div class="btn-group">
                        <a href="/yzoix/users/mailbox" class="btn btn-xs btn-primary btn-outline dark"><i class="fa fa-envelope"></i></a>
                        <a href="/yzoix/users" class="btn btn-xs btn-info btn-outline dark"><i class="fa fa-user"></i></a>
                        <a href="/yzoix/users/modify" class="btn btn-xs btn-warning btn-outline dark"><i class="fa fa-cog"></i></a>
                        <a href="/yzoix/users/logout" class="btn btn-xs btn-danger btn-outline dark"><i class="fa fa-power-off"></i></a>
                    </div>                                        <a href="javascript:;" class="close">&times;</a>
                </div>
            </div>
            <ul class="navigation">
                <li class="">
                    <a href="/yzoix/"><i class="menu-icon fa fa-university"></i><span class="mm-text">首页</span></a>
                </li>

                <li class="mm-dropdown">
                    <a href="/yzoix/problems"><i class="menu-icon fa fa-th"></i><span class="mm-text">训练题库</span></a>
                    <ul><li><a href='/yzoix/problems/list'><i class='menu-icon fa fa-th-list'></i>所有题库</a></li><li><a href='/yzoix/problems/tag'><i class='menu-icon fa fa-tags'></i>标签搜题</a></li><li class='mm-dropdown'><a href='/yzoix/problems/category/1'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>语言学习</span></a><ul><li><a href='/yzoix/problems/category/1/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题</span></a></li><li><a href='/yzoix/problems/category/4'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>语言入门</span></a></li><li><a href='/yzoix/problems/category/5'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>选择结构</span></a></li><li><a href='/yzoix/problems/category/8'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>循环结构</span></a></li><li><a href='/yzoix/problems/category/299'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>数组</span></a></li><li><a href='/yzoix/problems/category/300'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>模块化</span></a></li><li><a href='/yzoix/problems/category/301'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>字符串</span></a></li></ul></li><li class='mm-dropdown'><a href='/yzoix/problems/category/2'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>基本算法</span></a><ul><li><a href='/yzoix/problems/category/2/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题</span></a></li><li><a href='/yzoix/problems/category/6'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>分治法</span></a></li><li><a href='/yzoix/problems/category/303'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>高精度</span></a></li><li><a href='/yzoix/problems/category/304'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>排序</span></a></li><li><a href='/yzoix/problems/category/305'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>递推和递归</span></a></li><li><a href='/yzoix/problems/category/306'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>贪心</span></a></li><li><a href='/yzoix/problems/category/307'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>模拟</span></a></li><li><a href='/yzoix/problems/category/308'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>枚举</span></a></li><li><a href='/yzoix/problems/category/309'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>回溯</span></a></li><li><a href='/yzoix/problems/category/313'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>搜索</span></a></li></ul></li><li class='mm-dropdown'><a href='/yzoix/problems/category/3'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>算法与数据结构</span></a><ul><li><a href='/yzoix/problems/category/3/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题</span></a></li><li><a href='/yzoix/problems/category/302'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>线性表</span></a></li><li><a href='/yzoix/problems/category/7'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>栈和队列</span></a></li><li><a href='/yzoix/problems/category/294'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>树型结构</span></a></li><li><a href='/yzoix/problems/category/314'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>线段树</span></a></li><li><a href='/yzoix/problems/category/315'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>块状树/块状链表</span></a></li><li><a href='/yzoix/problems/category/316'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>树链剖分/动态树</span></a></li><li><a href='/yzoix/problems/category/295'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>图状结构</span></a></li><li><a href='/yzoix/problems/category/317'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>最小生成树MST</span></a></li><li><a href='/yzoix/problems/category/318'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>最短路</span></a></li><li><a href='/yzoix/problems/category/319'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>连通性</span></a></li><li><a href='/yzoix/problems/category/320'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>网络流</span></a></li></ul></li><li class='mm-dropdown'><a href='/yzoix/problems/category/310'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>动态规划</span></a><ul><li><a href='/yzoix/problems/category/310/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题</span></a></li><li><a href='/yzoix/problems/category/311'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>背包模型</span></a></li><li><a href='/yzoix/problems/category/312'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>LCS/LIS/LCIS</span></a></li></ul></li><li class='mm-dropdown'><a href='/yzoix/problems/category/321'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>专题</span></a><ul><li><a href='/yzoix/problems/category/321/all'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>该类所有题</span></a></li><li><a href='/yzoix/problems/category/322'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>字符串</span></a></li><li><a href='/yzoix/problems/category/323'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>数学/数论</span></a></li><li><a href='/yzoix/problems/category/324'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>计算机几何</span></a></li><li><a href='/yzoix/problems/category/325'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>博弈论</span></a></li><li><a href='/yzoix/problems/category/326'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>离散化</span></a></li><li><a href='/yzoix/problems/category/327'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>莫队</span></a></li><li><a href='/yzoix/problems/category/328'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>随机/模拟退火/爬山法</span></a></li></ul></li><li><a href='/yzoix/problems/category/296'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>NOIP真题</span></a></li><li><a href='/yzoix/problems/category/297'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>NOI和省选</span></a></li><li><a href='/yzoix/problems/category/298'><i class='menu-icon fa fa-map-marker'></i><span class='mm-text'>USACO</span></a></li></ul>    </li>
                <li class="">
                    <a href="/yzoix/status"><i class="menu-icon fa fa-gavel"></i><span class="mm-text">测评结果</span></a>
                </li>
                <li class="">
                    <a href="/yzoix/users/rank"><i class="menu-icon fa fa-trophy"></i><span class="mm-text">学生排名</span></a>
                </li>
                <li class="mm-dropdown">
                    <a href="/yzoix/contests"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">作业/比赛</span></a>
                    <ul>
                        <li class="">
                            <a href="/yzoix/contests/list"><i class="menu-icon fa fa-flag-checkered"></i><span class="mm-text">比赛列表</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="/yzoix/topics"><i class="menu-icon fa fa-comments"></i><span class="mm-text">社区</span></a>
                </li>
                <li>
                    <a href="/yzoix/topics/list/tutorial"><i class="menu-icon fa fa-key"></i><span class="mm-text">帮助教程</span></a>
                </li>
                <li class="mm-dropdown">
                    <a href="javascript:;"><i class="menu-icon fa fa-cloud"></i><span class="mm-text">学习资源</span></a>
                    <ul>
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
                            <a href="javascript:;"><i class="menu-icon fa fa-graduation-cap"></i><span class="mm-text">Online Judge</span></a>
                            <ul>
                                <li><a href="http://poj.org" target="_blank"><i class="menu-icon fa fa-file-o"></i><span class="mm-text">PKU</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>            <div class="menu-content text-center" id="back-to-top-container"></div>
        </div> <!-- / #main-menu-inner -->
    </div> <!-- / #main-menu -->

    <div id="content-wrapper">
        <div class="page-header page-header-breadcrumb">
            <h1><i class="fa fa-windows"></i> 测试markdown-plus</h1>
            <ul class="breadcrumb breadcrumb-page">
                <li><a href="/yzoix/">Home</a></li>
                <li><a href="/yzoix/topics">Topics</a></li>
                <li class="active">Testmd</a></li>
            </ul>
        </div>



        <div class="row">
            <div class="col-sm-12">
                <div class="panel colourable">
                    <div class="panel-body markdown-body md-preview" id="mdmdmd">
## `print 'hello code'`

evens = [1, 2, 3, 4, 5].collect do |item|
item * 2
end

```javascript
$(document).ready(function() {
$('pre code').each(function(i, block) {
hljs.highlightBlock(block);
});
});
```

Markdown 是一种用来写作的轻量级** 标记语言 **，它用简洁的语法代替排版，而不像一般我们用的字处理软件 Word 或 Pages有大量的排版、字体设置。它使我们专心于码字，用“标记”语法，来代替常见的排版格式。例如此文从内容到格式，甚至插图，键盘就可以通通搞定了。

YZOI系统遵循`Github`用的[GFM](https://help.github.com/categories/writing-on-github/)，风格很漂亮，简洁美观大方。 GFM对标准Markdown做了少了修改，请参考本教程：

<table>
    <tr>
        <th>格式</th>
        <th>语法（输入）</th>
        <th>效果（输出）</th>
    </tr>
    <tr>
        <td>粗体</td>
        <td>`** 两个星号 **`</td>
        <td>** 两个星号 **</td>
    </tr>
    <tr>
        <td>斜体</td>
        <td>* 一个星号 *</td>
        <td>* 一个星号 *</td>
    </tr>
    <tr>
        <td>删除线</td>
        <td>~~ 两个波浪线 ~~</td>
        <td>~~ 两个波浪线 ~~</td>
    </tr>
    <tr>
        <td>标题</td>
        <td>### 三号标题
            #### 四号标题
            ##### 五号标题
        </td>
        <td>###三号标题
            #### 四号标题
            ##### 五号标题</td>
    </tr>

</table>

行内公式：`$ x_{1,2} = \dfrac{-b \pm \sqrt{b^2-4ac}}{2a} $`

段落公式：

$$
x_{1,2} = \dfrac{-b \pm \sqrt{b^2-4ac}}{2a}
$$



代码编辑:whale: ：

```cpp
#include &lt; iostream &gt;
using namespace std;

int main() {
    int a, b;

    cin >> a >> b;
    cout << a+b << '\n';

    return 0;
}
```

[Code Formatting](https://help.github.com/articles/markdown-basics/#code-formatting)


## Tables and alignment

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |

[Table Syntax](https://help.github.com/articles/github-flavored-markdown/#tables)


## Task list

- [ ] a bigger project
- [x] first subtask
- [x] follow up subtask
- [ ] final subtask
- [ ] a separate task

[Task List Syntax](https://help.github.com/articles/writing-on-github/#task-lists)

                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <div class="panel colourable">
                    <div class="panel-body no-padding-t">
                        <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> New Topic</h6>
                        <form action="/yzoix/topics/create" method="post" class="newtopic-form fronteditor" id="newtopicform">
                            <div class="form-group dark">
                                <div class="input-group input-group-lg">
                        <span class="input-group-addon">
                            <select class="form-control" name="flag">
                                <option selected="selected" value="">选择主题类型</option>
                                <option value="">不选择</option>
                                <br />
                                <font size='1'><table class='xdebug-error xe-notice' dir='ltr' border='1' cellspacing='0' cellpadding='1'>
                                        <tr><th align='left' bgcolor='#f57900' colspan="5"><span style='background-color: #cc0000; color: #fce94f; font-size: x-large;'>( ! )</span> Notice: Undefined variable: flags in /var/www/yzoi7x/var/volt/%%var%%www%%yzoi7x%%app%%views%%topics%%testmd.volt.php on line <i>132</i></th></tr>
                                        <tr><th align='left' bgcolor='#e9b96e' colspan='5'>Call Stack</th></tr>
                                        <tr><th align='center' bgcolor='#eeeeec'>#</th><th align='left' bgcolor='#eeeeec'>Time</th><th align='left' bgcolor='#eeeeec'>Memory</th><th align='left' bgcolor='#eeeeec'>Function</th><th align='left' bgcolor='#eeeeec'>Location</th></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>1</td><td bgcolor='#eeeeec' align='center'>0.0001</td><td bgcolor='#eeeeec' align='right'>243760</td><td bgcolor='#eeeeec'>{main}(  )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>2</td><td bgcolor='#eeeeec' align='center'>0.0008</td><td bgcolor='#eeeeec' align='right'>299920</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\Application.handle' target='_new'>handle</a>
                                                (  )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>35</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>3</td><td bgcolor='#eeeeec' align='center'>0.0121</td><td bgcolor='#eeeeec' align='right'>685768</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View.render' target='_new'>render</a>
                                                ( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>35</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>4</td><td bgcolor='#eeeeec' align='center'>0.0122</td><td bgcolor='#eeeeec' align='right'>688904</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View.-engineRender' target='_new'>_engineRender</a>
                                                ( ???, ???, ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>5</td><td bgcolor='#eeeeec' align='center'>0.0122</td><td bgcolor='#eeeeec' align='right'>689808</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View\Engine\Volt.render' target='_new'>render</a>
                                                ( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>6</td><td bgcolor='#eeeeec' align='center'>0.0123</td><td bgcolor='#eeeeec' align='right'>695128</td><td bgcolor='#eeeeec'>Phalcon\Mvc\View\Engine\Volt->render( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                    </table></font>
                                <br />
                                <font size='1'><table class='xdebug-error xe-warning' dir='ltr' border='1' cellspacing='0' cellpadding='1'>
                                        <tr><th align='left' bgcolor='#f57900' colspan="5"><span style='background-color: #cc0000; color: #fce94f; font-size: x-large;'>( ! )</span> Warning: Invalid argument supplied for foreach() in /var/www/yzoi7x/var/volt/%%var%%www%%yzoi7x%%app%%views%%topics%%testmd.volt.php on line <i>132</i></th></tr>
                                        <tr><th align='left' bgcolor='#e9b96e' colspan='5'>Call Stack</th></tr>
                                        <tr><th align='center' bgcolor='#eeeeec'>#</th><th align='left' bgcolor='#eeeeec'>Time</th><th align='left' bgcolor='#eeeeec'>Memory</th><th align='left' bgcolor='#eeeeec'>Function</th><th align='left' bgcolor='#eeeeec'>Location</th></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>1</td><td bgcolor='#eeeeec' align='center'>0.0001</td><td bgcolor='#eeeeec' align='right'>243760</td><td bgcolor='#eeeeec'>{main}(  )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>2</td><td bgcolor='#eeeeec' align='center'>0.0008</td><td bgcolor='#eeeeec' align='right'>299920</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\Application.handle' target='_new'>handle</a>
                                                (  )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>35</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>3</td><td bgcolor='#eeeeec' align='center'>0.0121</td><td bgcolor='#eeeeec' align='right'>685768</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View.render' target='_new'>render</a>
                                                ( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>35</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>4</td><td bgcolor='#eeeeec' align='center'>0.0122</td><td bgcolor='#eeeeec' align='right'>688904</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View.-engineRender' target='_new'>_engineRender</a>
                                                ( ???, ???, ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>5</td><td bgcolor='#eeeeec' align='center'>0.0122</td><td bgcolor='#eeeeec' align='right'>689808</td><td bgcolor='#eeeeec'><a href='http://www.php.net/Phalcon\Mvc\View\Engine\Volt.render' target='_new'>render</a>
                                                ( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                        <tr><td bgcolor='#eeeeec' align='center'>6</td><td bgcolor='#eeeeec' align='center'>0.0123</td><td bgcolor='#eeeeec' align='right'>695128</td><td bgcolor='#eeeeec'>Phalcon\Mvc\View\Engine\Volt->render( ???, ???, ??? )</td><td title='/var/www/yzoi7x/public/index.php' bgcolor='#eeeeec'>../index.php<b>:</b>0</td></tr>
                                    </table></font>
                            </select>
                        </span>
                                    <input type="text" id="title" name="title" class="form-control" placeholder="标题（至少6个字节）" />                        </div>
                                <!--<p class="help-block">标题中可以使用LaTeX公式，放在双美元符中，如<code>$$ \Delta = b^2-4ac $$</code></p>-->
                            </div>
                            <div class="form-group form-inline dark">
                                <label class="control-label">题目ID：</label>
                                <input type="text" id="problems_id" name="problems_id" class="form-control" placeholder="题目ID" />                        <span class="help-block-inline">若非针对题目，则请留空</span>
                            </div>
                            <div class="form-group dark">
                                <textarea></textarea>
                            </div>
                            <div class="form-group col-sm-offset-2">
                                <button type="submit" class="btn btn-lg btn-labeled btn-success"><span class="btn-label icon fa fa-pencil"></span> Create Topic</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            init.push(function() {
                var md = $('#mdmdmd').html();
                $('#mdmdmd').html(marked(md));
            });
        </script>
    </div>

    <div id="main-menu-bg"></div>
</div>

<footer>
    <div class="footer">
        <div class="footerow row">
            <div class="col-md-6">
                &copy; 2010-2015 <a href="/yzoix/">YZOI</a> V4.1 <br> Yizhong Olympiad in Informatics - Online Judge System.
            </div> <!-- /span6 -->
            <div class="col-md-6 text-right">
                <small><i class="fa fa-envelope-o"></i> <a href="mailto:xaero@msn.cn">xaero@msn.cn</a></small><br>
                <small>Above IE 9 or Non-IE Browsers Recommended.</small>
            </div> <!-- /.span6 -->
        </div> <!-- /row -->
    </div>
</footer> <!-- /footer -->

<script type="text/javascript" src="/yzoix/assets/js/jquery.js"></script>
<script type="text/javascript" src="/yzoix/thinkermd/javascripts/thinker-md.vendor.min.js"></script>

<script type="text/javascript" src="/yzoix/assets/js/bootstrap.js"></script>
<script type="text/javascript" src="/yzoix/assets/js/katex.min.js"></script>
<script type="text/javascript" src="/yzoix/assets/js/jquery.validate.js"></script>
<script type="text/javascript" src="/yzoix/assets/js/yzoitex.js"></script>


<script type="text/javascript" src="/yzoix/assets/js/yzoiapp.js"></script>

<script type="text/javascript">
    window.LanderApp.start(init);
    $("textarea").markdown({
        language: 'zh',
        fullscreen: {
            enable: true
        },
        resize: 'vertical',
        localStorage: 'md',
        imgurl: '/c/imgUpload',
        base64url: '/c/imgUpload',
        flowChart : true
    });
</script>

</body>
</html>