{{ content() }}
{{ flashSession.output() }}


<div class="row">
    <div class="col-sm-10">
        <form method="post" class="form-horizontal">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 用户编辑</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon"></div>
                </div>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">Username</label>
                    <div class="col-sm-10">
                        {{ form.render('name') }}
                        <p class="help-block">用户名暂时无法更改</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="view_perm" class="col-sm-2 control-label">Viewing Permission</label>
                    <div class="col-sm-10">
                        {{ form.render('view_perm') }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="nick" class="col-sm-2 control-label">Nick Name</label>
                    <div class="col-sm-10">
                        {{ form.render('nick') }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        {{ form.render('password') }}
                        <p class="help-block">用户名密码</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label">Confirm Password</label>
                    <div class="col-sm-10">
                        {{ form.render('confirmPassword') }}
                        <p class="help-block">“密码确认”留空就不会更改原先的密码</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="school" class="col-sm-2 control-label">School</label>
                    <div class="col-sm-10">
                        {{ form.render('school') }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        {{ form.render('email') }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="status" class="col-sm-2 control-label">Status</label>
                    <div class="col-sm-10">
                        {{ form.render('status') }}
                    </div>
                </div>
                <div class="form-group">
                    <label for="status" class="col-sm-2 control-label">Privilege</label>
                    <div class="col-sm-10">
                        <select id="privilege" name="privilege" class="form-control">
                            <option<?php if (! isset($user->privilege->name)) { ?> selected="selected"<?php } ?> value="">Guest</option>
                            <option<?php if (isset($user->privilege->name) && $user->privilege->name == "Administrator") { ?> selected="selected"<?php } ?> value="Administrator">Administrator(Toppest)</option>
                            <option<?php if (isset($user->privilege->name) && $user->privilege->name == "Ultraman") { ?> selected="selected"<?php } ?> value="Ultraman">Ultraman</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="panel-footer form-inline">
                <div class="form-group text-right">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Save</button>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
    <div class="col-sm-2">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 更多信息</span>
            </div>
            <div class="panel-body">
                <dl>
                    <dt>Score</dt>
                    <dd>{{ user.score }}</dd>
                </dl>
                <dl>
                    <dt>Last IP</dt>
                    <dd>{{ user.ip }}</dd>
                </dl>
                <dl>
                    <dt>Create</dt>
                    <dd>{{ date('Y-m-d H:i', user.create_at) }}</dd>
                </dl>
                <dl>
                    <dt>Last Login</dt>
                    <dd>{{ date('Y-m-d H:i', user.last_login) }}</dd>
                </dl>
                <dl>
                    <dt>Solved</dt>
                    <dd>{{ user.solved }}</dd>
                </dl>
                <dl>
                    <dt>Submit</dt>
                    <dd>{{ user.submit }}</dd>
                </dl>
            </div>
        </div>
    </div>
</div>

