{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> New Topic</h6>
                <form method="post" class="newtopic-form fronteditor" id="newtopicform">
                    <?php if (! isset($thread->topics_id)) {?>
                    <div class="form-group dark">
                        <div class="input-group input-group-lg">
                        <span class="input-group-addon">
                            {{ form.render('flag') }}
                        </span>
                            {{ form.render('title') }}
                        </div>
                        <!--<p class="help-block">标题中可以使用LaTeX公式，放在双美元符中，如<code>$$ \Delta = b^2-4ac $$</code></p>-->
                    </div>
                    <div class="form-group form-inline dark">
                        <label class="control-label">题目ID：</label>
                        {{ form.render('problems_id') }}
                        <span class="help-block-inline">若非针对题目，则请留空</span>
                    </div>
                    <?php }?>
                    <div class="form-group dark">
                        {{ form.render('content') }}
                        <div class="fronteditor"></div>
                        <p class="help-block">不支持HTML标签，仅支持<a href="{{ url('topics/show/1') }}" target="_blank">markdown</a>写作</p>
                    </div>
                    <div class="form-group col-sm-offset-2">
                        <button type="submit" class="btn btn-lg btn-labeled btn-success"><span class="btn-label icon fa fa-pencil"></span> Edit Thread</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
init.push(function() {
    $("#newtopicform").validate({
        rules: {
            title: {
                required: true,
                minlength: 3
            },
            problems_id: {
                min: function() {
                    if ($("#problems_id").val() != "")
                        return 1000;
                }
            },
            content: {
                required: true,
                minlength: 6
            }
        },
        messages: {
            title: {required: "主题类型可以不选，标题必须要写！", minlength: "主题类型可以不选，标题必须6字节以上！"},
            problems_id: {min: "题目ID的最小值是1000"},
            content: {required: "总该写点怎么吧？", minlength: "内容至少6个字节"}
        }
    });
});
</script>