{{ content() }}{{ flashSession.output() }}<div class="profile-full-name">    <span class="text-semibold">{{ user.name }}</span>'s profile</div><div class="profile-row">    {{ partial("partials/userleftprofile") }}    <div class="right-col">        <hr class="profile-content-hr no-grid-gutter-h">        <div class="profile-content">            <ul id="profile-tabs" class="nav nav-tabs">                <li>                    <a href="{{url('users')}}">Board</a>                </li>                <li class="active">                    <a href="javascript:;">Modify</a>                </li>                <li>                    <a href="{{url('users/avatar')}}">Avatar</a>                </li>                <li>                    <a href="{{url('users/mailbox')}}">Mail Box</a>                </li>            </ul>            <div class="tab-content tab-content-bordered ">                <form method="post" id="profile_modifier">                <div class="tab-pane panel-body fade in active form-horizontal">                    <div class="form-group">                        <label for="name" class="col-sm-2 control-label">Username</label>                        <div class="col-sm-10">                            <span class="help-block">{{ user.name }} (用户名暂时无法更改)</span>                        </div>                    </div>                    <div class="form-group">                        <label for="oldpassword" class="col-sm-2 control-label">Old Password</label>                        <div class="col-sm-10">                            {{ form.render('oldpassword') }}                            <span class="help-block">若要修改密码，请先填写旧密码</span>                        </div>                    </div>                    <div class="form-group">                        <label for="password" class="col-sm-2 control-label">Password</label>                        <div class="col-sm-10">                            {{ form.render('password', ['value' : '']) }}                            <p class="help-block">用户名新密码。若不修改，请留空</p>                        </div>                    </div>                    <div class="form-group">                        <label for="confirmPassword" class="col-sm-2 control-label">Confirm Password</label>                        <div class="col-sm-10">                            {{ form.render('confirmPassword') }}                            <p class="help-block">密码确认。若不修改，请留空</p>                        </div>                    </div>                    <div class="form-group">                        <label for="nick" class="col-sm-2 control-label">Nick Name</label>                        <div class="col-sm-10">                            {{ form.render('nick') }}                        </div>                    </div>                    <div class="form-group dark">                        <label for="email" class="col-sm-2 control-label">Email</label>                        <div class="col-sm-10">                            {{ form.render('email') }}                        </div>                    </div>                    <div class="form-group dark">                        <label for="school" class="col-sm-2 control-label">School</label>                        <div class="col-sm-10">                            {{ form.render('school') }}                        </div>                    </div>                    <div class="form-group dark">                        <label for="display_lang" class="col-sm-2 control-label">Display Language</label>                        <div class="col-sm-10">                            {{ form.render('display_lang', ['class':'form-control col-xs-3']) }}                        </div>                    </div>                    <div class="form-group">                        <div class="col-sm-offset-2 col-sm-10">                            {{ form.render('id') }}                            {{ form.render(form.getCsrfName()) }}                            <button type="submit" class="btn btn-warning"><i class="fa fa-pencil"></i> 确认修改</button>                        </div>                    </div>                </div></form>            </div>        </div>    </div></div><script type="text/javascript">init.push(function () {    $('body').addClass('page-profile');    $("#profile_modifier").validate({        rules: {            email:{required:true, email: true},            school: {required: true, minlength:2},            confirmPassword: { minlength: function () {                var $oldp = $("#oldpassword"), $psd = $("#password"), $cpsd = $("#confirmPassword");                if ($oldp.val() != "" && $psd.val() != "" && $cpsd.val() != "") {                    return 5;                }            }}        },        messages: {            email: {required: "Email必须要填写！", email: "Email格式有问题！"},            school: {required: "请填写学校！", minlength: "请正确填写学校"}        }    });});</script>