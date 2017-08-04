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
        <a href="{{ url('users/mailbox') }}" class="messages-link">MORE MESSAGES</a>
    </div>
</li>
-->
<li class="dropdown">
    <a href="#" class="dropdown-toggle user-menu" data-toggle="dropdown">
        <img src="{{ url('assets/images/avatars/'~logged_in.avatar) }}">
        <?php
        $unread_count = $logged_in->countUnreadMails();
        if ($unread_count > 0) {
        ?>
        <span class="label notify-badge"">
        {{ unread_count }}
        </span>
        <?php
        }
        ?>
        <span>{{ logged_in.name }}</span>
        <i class="fa fa-fw fa-caret-down"></i>
    </a>
    <ul class="dropdown-menu">
        <li>{{ link_to("users", "<i class='dropdown-icon fa fa-fw fa-user'></i> Profile") }}</li>
        <li>
            <a href="{{ url('mails/inbox') }}">
            <i class="dropdown-icon fa fa-envelope"></i> Messages
            <?php
            //$unread_count = $logged_in->countUnreadMails();
            if ($unread_count > 0) {
            ?>
            <span class="badge badge-primary pull-right">
            {{ unread_count }}
            </span>
            <?php
            }
            ?>
            </a>
        </li>
        <li><a href="{{ url('users/modify') }}"><i class="dropdown-icon fa fa-fw fa-cog"></i> Settings</a></li>
        <?php if ($logged_in && $logged_in->is_ultraman()) {?>
        <li class="divider"></li>
        <li><a href="{{ url('yzoi7x/problems/list') }}"><i class="fa fa-fw fa-cogs"></i> Administration</a></li>
        <?php } ?>
        <li class="divider"></li>
        <li>{{ link_to("users/logout", "<i class='dropdown-icon fa fa-fw fa-power-off'></i> Log Out") }}</li>
    </ul>
</li>