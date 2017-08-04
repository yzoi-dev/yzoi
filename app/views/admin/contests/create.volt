{{ content() }}

<form method="post">
    <div class="row">
        <div class="col-sm-9">
            <div class="panel">
                <div class="panel-heading">
                    <span class="panel-title">新增测验/作业</span>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="control-label" for="title">Title</label>
                        {{ form.render('title') }}
                    </div>
                    <div class="form-group">
                        <label class="control-label">Time Range</label>
                        <div class="input-daterange input-group">
                            {{ form.render('start_time') }}
                            <span class="input-group-addon">to</span>
                            {{ form.render('end_time') }}
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="title">Problems(题目ID，半角分号“;”分隔，书写顺序即为显示顺序)</label>
                        <input type="text" id="problems_id" name="problems_id" class="form-control">
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="description">Description</label>
                        {{ form.render('description') }}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="panel">
                <div class="panel-heading">
                    <span class="panel-title">私有参与用户</span>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="control-label" for="source">私有用户</label>

                    </div>
                </div>
                <div class="panel-footer text-right">
                    <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-check"></i> Submit</button>
                </div>
            </div>
        </div>
    </div>
</form>