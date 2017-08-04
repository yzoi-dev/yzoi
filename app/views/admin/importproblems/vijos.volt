{{ content() }}
{{ flashSession.output() }}

<form method="post">
    <div class="row">
        <div class="col-sm-12">
            <div class="panel">
                <div class="panel-heading">
                    <span class="panel-title">从USACO的Contest里导入题目</span>
                    <div class="panel-heading-controls">
                        <div class="panel-heading-icon">
                            <a href="{{ url('yzoi7x/problems/list') }}"><i class="fa fa-reply"></i> Back</a>
                        </div>
                    </div>
                </div>
                <div class="alert alert-page alert-info alert-dark">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <strong>注意：</strong> 涉及到样例文件的生成，目前只支持一题一题添加，不支持批量添加！
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="control-label" for="description">题目所在路径（包含通配符“<span class="text-danger">[*]</span>”）</label>
                        <input type="text" name="urls" class="form-control" value="http://172.16.11.7/vijos/[*].htm">
                        <p class="help-block">如：http://172.16.11.7/vijos/[*].htm</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="sample_input">每次只支持一个题目</label>
                        <input type="text" name="theval" class="form-control">
                        <p class="help-block">若填写1038，则上述地址会解析为http://172.16.11.7/vijos/1038.htm</p>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="sample_input">题目来源</label>
                        <textarea name="sources" class="form-control" rows="6"></textarea>
                        <p class="help-block">一行一个来源，行数必须和上面的“|”段数对应</p>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Submit</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</form>

<form method="post" action="{{ url(admin_uri~'/problems/create') }}" autocomplete="off" class="admineditor">
    <div class="row">
        <div class="col-sm-9">
            <div class="panel">
                <div class="panel-heading">
                    <span class="panel-title">题目描述和样例</span>
                    <div class="panel-heading-controls">
                        <div class="panel-heading-icon">
                            <a href="{{ url(admin_uri~'/problems/list') }}"><i class="fa fa-reply"></i> Back</a>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group{% if problem.spj is defined %} has-success dark{% endif %}">
                        <label class="control-label" for="title">Title</label>
                        {{ form.render('title') }}
                        {% if problem.spj is defined %}
                        <p class="help-block">Special Judge</p>
                        {% endif %}
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
                    <div class="checkbox">
                        <label>
                            {{ form.render('spj') }}
                            <span class="lbl">Special Judge</span>
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Category</label>
                        <ul class="checkbox list-unstyled">
                            {% for cate in categories %}
                            <li>
                                <label><?php echo str_repeat("&nbsp;&nbsp;&nbsp;&nbsp;", $cate['level']); ?>
                                    <input type="checkbox" name="categories[]" class="px" value="{{ cate['id'] }}"> <span class="lbl">{{ cate['name'] }}</span>
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
                    allowFreeTagging: true
                });
        }
    });
</script>