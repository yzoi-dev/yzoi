<div class="left-col">
    <div class="profile-block">
        <div class="panel profile-photo">
            <img src="{{ url('assets/images/avatars/'~user.avatar) }}">
        </div><br>
        <a href="#" class="btn btn-success"><i class="fa fa-check"></i>&nbsp;&nbsp;Following</a>&nbsp;&nbsp;
        <a href="{{ url('mails/write/'~user.name) }}" class="btn"><i class="fa fa-comment"></i></a>
    </div>

    <div class="panel panel-transparent">
        <div class="panel-heading">
            <span class="panel-title">About Me</span>
        </div>
        <div class="list-group">
            <a href="javascript:;" class="list-group-item">Nick: {{ user.nick }}</a>
            <a href="javascript:;" class="list-group-item">From: {{ user.school }}</a>
        </div>
    </div>

    <div class="panel panel-transparent">
        <div class="panel-heading">
            <span class="panel-title">Statistics</span>
        </div>
        <div class="list-group">
            <a href="javascript:;" class="list-group-item"><strong>{{ user.solved }}</strong> Solved</a>
            <a href="javascript:;" class="list-group-item"><strong>{{ user.submit }}</strong> Tries</a>
            <a href="javascript:;" class="list-group-item"><strong>100</strong> Following</a>
        </div>
    </div>

    <div class="panel panel-transparent profile-skills">
        <div class="panel-heading">
            <span class="panel-title">Skills</span>
        </div>
        <div class="panel-body">
            <span class="label label-primary">MST</span>
            <span class="label label-primary">最短路</span>
            <span class="label label-primary">搜索</span>
            <span class="label label-primary">模拟</span>
            <span class="label label-primary">动态规划</span>
        </div>
    </div>

    <div class="panel panel-transparent">
        <div class="panel-heading">
            <span class="panel-title">Social</span>
        </div>
        <div class="list-group">
            <a href="javascript:;" class="list-group-item"><i class="profile-list-icon fa fa-envelope text-info"></i>
            <?php echo YZOI\Common::hide_star($user->email);?>
            </a>
        </div>
    </div>
</div>