{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-8">
        <form method="post" id="mergeTags" action="{{ url('yzoi7x/metas/merge') }}">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 标签列表</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon"></div>
                </div>
            </div>
            <div class="panel-body form-group simple">
                <div class="alert alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <strong>提示：</strong> 括号内数字为该标签的题目数，题目数为0的可以删除；点击标签可以选中，选中后可以合并；点击“编辑”可以编辑其名称。
                </div>

                {% for tagg in tags %}
                <span class="btn btn-sm btn-outline btn-labeled btn-warning">
                    <span class="btn-label">
                        <input type="checkbox" name="tags[]" value="{{ tagg.id }}">
                    </span>
                    {{ tagg.name ~ '<span class="text-info text-bold">(' ~ tagg.count ~ ')</span>' }}
                    <a href="{{ url('yzoi7x/metas/edittag/'~tagg.id) }}" class="label"><i class="fa fa-pencil"></i></a>
                    {% if tagg.count == 0 %}
                    <a href="javascript:;" class="label removetag" data-value="{{ tagg.id }}"><i class="fa fa-remove"></i></a>
                    {% endif %}
                </span>
                {% endfor %}
            </div>
            <div class="panel-footer form-inline">
                <div class="form-group dark">
                    <label for="newname">将选中的标签可并成：</label>
                    <input type="text" class="form-control" name="newname" id="newname" placeholder="新标签名称">
                </div>
                <button type="submit" class="btn btn-primary">合并</button>
            </div>
        </div>
        </form>
    </div>
    <div class="col-sm-4">
        <div class="panel">
            <form method="post" id="addTags">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 新增标签</span>
            </div>
            <div class="panel-body">
                <div class="form-group dark">
                    <label class="control-label" for="name">标签名称</label>
                    {{ form.render('name') }}
                </div>
            </div>
            <div class="panel-footer text-right">
                <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Submit</button>
            </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
init.push(function() {
    $('span.btn-outline').on('click', function() {
        var chkbox = $(this).children().children("input");
        //console.log(chkbox.val());
        if ($(this).hasClass('btn-selected') || chkbox.prop("checked")) {
            $(this).removeClass('btn-selected');
            chkbox.prop("checked", false);
        } else {
            $(this).addClass('btn-selected');
            chkbox.prop("checked", true);
        }
    });
    $("#mergeTags").validate({
        rules: {
            newname: {
                required: true,
                minlength: 2
            },
            "tags[]": {
                required: true,
                minlength:2
            }
        },
        messages: {
            newname: {required: "新标签名称不能空！", minlength:"新标签名称至少2个字符"},
            "tags[]": {required: "不选标签怎么合并？", minlength:"至少得2个才能合并吧？"}
        }
    });
    $("#addTags").validate({
        rules: {
            name: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            name: {required: "名称不能空！", minlength:"名称至少2个字符"}
        }
    });
    $('a.removetag').click(function(){
        var tag_id = $(this).attr('data-value');
        var $p = $(this).parent("span");
        //console.log(tag_id);
        var user_ok = confirm('您确定要将删除标签'+ tag_id +'吗？');
        if (user_ok)
        {
            var url = "{{ url('yzoi7x/metas/removetag/') }}";
            $.getJSON(url, {'tag_id': tag_id}, function(response){
                //console.log(response);
                $p.hide(1000, function () {
                    $p.remove();
                });
                //check_defunct(problem_id);
            })
        }
    });
});
</script>
