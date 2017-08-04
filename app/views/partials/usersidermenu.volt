<div class="text-bg"><span class="text-semibold follower-username">{{ logged_in.name }}</span></div>

<a href="{{ url('users') }}"><img src="{{ url('assets/images/avatars/'~logged_in.avatar) }}"></a>
<div class="btn-group">
    <a href="{{ url('mails/inbox') }}" class="btn btn-xs btn-primary btn-outline dark"><i class="fa fa-envelope"></i></a>
    <a href="{{ url('users') }}" class="btn btn-xs btn-info btn-outline dark"><i class="fa fa-user"></i></a>
    <a href="{{ url('users/modify') }}" class="btn btn-xs btn-warning btn-outline dark"><i class="fa fa-cog"></i></a>
    <a href="{{ url('users/logout') }}" class="btn btn-xs btn-danger btn-outline dark"><i class="fa fa-power-off"></i></a>
</div>