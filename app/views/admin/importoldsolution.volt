{{ content() }}
{{ flashSession.output() }}

<form method="post">
<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title">导入旧系统的Solution</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon">
                        <a href="{{ url('yzoi7x/problems/list') }}"><i class="fa fa-reply"></i> Back</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label" for="description">旧系统用户名（字符串）</label>
                    <input type="text" name="olduser" class="form-control">
                </div>
                <div class="form-group">
                    <label class="control-label" for="sample_input">新系统用户ID（数字）</label>
                    <input type="text" name="user" class="form-control">
                </div>
                <div class="form-group">
                    <label class="control-label" for="sample_output">题号（支持“,”）</label>
                    <input type="text" name="problems" class="form-control">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-check"></i> Submit</button>
                </div>
            </div>
        </div>
    </div>

</div>
</form>