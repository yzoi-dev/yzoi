{{ content() }}
{{ flashSession.output() }}

<form method="post" autocomplete="off" class="admineditor">
<div class="row">
    <div class="col-sm-9">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title">题目描述和样例</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon">
                        <a href="{{ url('yzoi7x/problems/list') }}"><i class="fa fa-reply"></i> Back</a>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="form-group{% if problem.spj == true %} has-success dark{% endif %}">
                    <label class="control-label" for="title">Title</label>
                    {{ form.render('title') }}
                    {% if problem.spj == true %}
                    <p class="help-block">Special Judge</p>
                    {% endif %}
                </div>
                <div class="form-group">
                    <label class="control-label" for="pdfname">题目描述中有PDF主文件名（把pdf文件放在public/assets/pdf目录下，文件名用题目ID格式：p1234.pdf）</label>
                    <div class="input-group">
                        <span class="input-group-btn">
                            <button class="btn" type="button">用ID当文件主名</button>
                        </span>
                        {{ form.render('pdfname') }}
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" for="description">Description</label>
                    {{ form.render('description') }}
                    <div class="admineditor"></div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label" for="sample_input">Sample Input</label>
                            {{ form.render('sample_input') }}
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label" for="sample_output">Sample Output</label>
                            {{ form.render('sample_output') }}
                        </div>
                    </div>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="modifydata" value="1" class="px"> <span class="lbl text-danger">同时修改样例数据（默认不修改，确实修改过数据的选中此项）</span>
                    </label>
                </div>
                <div class="form-group">
                    <label class="control-label" for="hint">Hint</label>
                    {{ form.render('hint') }}
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-3">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title">时限和分类</span>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label" for="time_limit">Time Limit</label>
                    <div class="input-group">
                        {{ form.render('time_limit') }}
                        <span class="input-group-addon bg-info no-border">sec</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" for="memory_limit">Memory Limit</label>
                    <div class="input-group">
                        {{ form.render('memory_limit') }}
                        <span class="input-group-addon bg-info no-border">MB</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" for="view_perm">做题权限（用户组）</label>
                    {{ form.render('view_perm') }}
                </div>
                <hr />
                <div class="checkbox">
                    <label>
                        {{ form.render('spj') }}
                        <span class="lbl">Special Judge</span>
                    </label>
                </div>
                <hr />
                <div class="form-group">
                    <label class="control-label">Category</label>
                    <ul class="checkbox list-unstyled">
                        {% for cate in categories %}
                        <li>
                            <label><?php echo str_repeat("&nbsp;&nbsp;&nbsp;&nbsp;", $cate['level']); ?>
                                <input type="checkbox" name="categories[]" class="px" value="{{ cate['id'] }}" <?php if (in_array($cate['id'], $probMetas)) :?> checked="checked"<?php endif; ?>>
                                <span class="lbl">{{ cate['name'] }}</span>
                            </label>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
                <div class="form-group">
                    <label class="control-label" for="tags">Tag</label>
                    <input type="text" id="tags" name="tags" class="form-control">
                </div>
                <div class="form-group">
                    <label class="control-label" for="source">Sources</label>
                    {{ form.render('sources') }}
                </div>
            </div>
            <div class="panel-footer text-right">
                {% if problem is defined %}
                {{ form.render('id') }}
                {% endif %}
                <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-check"></i> Submit</button>
            </div>
        </div>
    </div>
</div>
</form>

<script type="text/javascript">
init.push(function() {
    var tags = $('#tags');
    if (tags.length > 0) {
        tags.tokenInput(<?php
        $data = array();
        foreach ($tags as $tagg) {
            $data[] = array('id'=>$tagg->id, 'name'=>$tagg->name);
        }
        echo json_encode($data);
        ?>, {
            preventDuplicates: true,
            animateDropdown: false,
            hintText: '请输入标签名称',
            noResultsText: '此标签不存在，按回车创建',
            prePopulate: <?php
                $data = array();
                foreach ($tags as $tagg) {
                    foreach ($probMetas as $mid) {
                        if ($tagg->id == $mid)
                            $data[] = array('id'=>$tagg->id, 'name'=>$tagg->name);
                    }
                }
                echo json_encode($data);
            ?>,
            allowFreeTagging: true
        });
    }
    //console.log(tags.val());
    /*$("input[type=button]").click(function () {
        alert("Would submit: " + $(this).siblings("#tags").val());
    });*/
});
</script>