{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body text-center no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> Any questions?</h6>
                <span class="pull-left">
                    <a href="#replytopicform" class="btn btn-lg btn-success"><i class="fa fa-reply"></i> Reply</a>
                    <a href="{{ url('topics/list') }}" class="btn btn-lg btn-primary"><i class="fa fa-arrow-left"></i> Back</a>
                    <?php
                    if ($logged_in && $topic->user_can_modify($logged_in)) {
                    ?>
                    <a href="{{ url('topics/edit/topic/'~topic.id) }}" class="btn btn-lg btn-info">
                    <i class="fa fa-pencil"></i>
                    Edit
                    </a>
                    <a class="btn btn-lg btn-danger" data-toggle="modal" data-target="#confirmDelete">
                    <i class="fa fa-remove"></i>
                    Delete
                    </a>
                    <?php
                    }
                    ?>
                </span>
                <span class="pull-right"><a href="{{ url('topics/create') }}" class="btn btn-lg btn-warning"><i class="fa fa-pencil"></i> New Topic</a></span>
            </div>
        </div>
        <div class="panel colourable">
            <div class="panel-body no-padding-t widget-comments">
                <img src="{{ url('assets/images/avatars/'~topic.avatar) }}" class="user-avatar">
                <h6 class="text-light-gray text-semibold text-xs text-left thread-title"><i class="fa fa-bars"></i> View Topic</h6>
                <h3 class="thread-title"><?php echo $parser->makeHtml($topic->title); ?></h3>
                <div class="comment-actions">
                    <?php
                    if (!empty($topic->problems_title)) {
                        echo "<a href='" . $this->url->get('problems/show/') . $topic->problems_id .
                            "' class='label label-warning' data-toggle='tooltip' data-placement='bottom' title='" .
                            $topic->problems_title . "' target='_blank'>" . $topic->problems_id . "</a>";
                    }
                    if ($topic->flag != "") {
                        echo $this->tag->linkTo(array(
                            'topics/list/' . $topic->flag,
                            \YZOI\OJ::$topic_flag[$topic->flag],
                            'class' => 'label label-info'
                        ));
                    }
                    if ($topic->orders >= 999) {
                        echo "<span class='label label-success'>精华</span>";
                    }
                    ?>
                    <a href="javascript:;"><i class="fa fa-eye"></i>浏览:{{ topic.view_count }}</a>
                    <a href="javascript:;"><i class="fa fa-reply"></i>回复:{{ topic.reply_count }}</a>
                    <a href="javascript:;" class="ratebtn" data-type="topic" data-value="{{ topic.id }}">
                        <i class="fa fa-thumbs-o-up"></i>赞:<em>{{ topic.vote_count }}</em>
                    </a>
                    <span class="pull-right">
                        Started by <a class="no-margin" href="{{ url('users/profile/'~topic.users_id) }}">{{ topic.name }}</a>
                        <?php echo YZOI\Common::datetimeFormat($topic->datetimes); ?>
                    </span>
                </div>

                <!-- The following functionality has been moved above. -->
                <!--
                <?php if ($logged_in && $topic->user_can_modify($logged_in)) { ?>
                <div class="comment-actions padding-xs-vr no-padding-b">
                    <a href="{{ url('topics/edit/topic/'~topic.id) }}"><i class="fa fa-pencil"></i>Edit</a>
                    <a href="#"><i class="fa fa-times"></i>Remove</a>
                </div>
                <?php } ?>
                -->

                <hr class="panel-wide">
                <div class="thread-body">
<?php echo $parser->makeHtml($topic->content);?>
                </div>
            </div>
        </div>
        {% if page.items is defined and (not page.items is empty) %}
        <div class="panel colourable">
            <div class="panel-body no-padding-t widget-comments">
                <h6 class="text-light-gray text-semibold text-xs text-left thread-title"><i class="fa fa-reply"></i> View Replies</h6>
                {% for reply in page.items %}
                <div class="thread-reply">
                    <hr class="panel-wide bordered">
                    <img src="{{ url('assets/images/avatars/'~reply.avatar) }}" class="user-avatar2">
                    <div class="comment-by">
                        <span>Replied by <a href="#" class="no-margin text-success">{{ reply.name }}</a>
                            <?php echo YZOI\Common::datetimeFormat($reply->datetimes); ?>
                        </span>
                        <a href="javascript:;" class="ratebtn" data-type="reply" data-value="{{ reply.id }}">
                            <i class="fa fa-thumbs-o-up"></i> 赞:<em>{{ reply.vote_count }}</em>
                        </a>
                        <?php if ($logged_in && $reply->user_can_modify($logged_in)) { ?>
                        <a href="{{ url('topics/edit/reply/'~reply.id) }}"><i class="fa fa-pencil"></i>Edit</a>
                        <a href="#"><i class="fa fa-times"></i>Remove</a>
                        <?php } ?>
                    </div>
                    <div class="thread-body">
<?php echo $parser->makeHtml($reply->content);?>
                    </div>
                </div>
                {% endfor %}
            </div>
            <div class="panel-footer">
                <ul class="pagination pagination-xs">
                    <li><a href="{{ url('topics/show/'~topic.id~'?page='~page.first) }}"><i class="fa fa-angle-double-left"></i></a></li>
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" . $this->url->get('topics/show/') . $topic->id . '?page=' . $i . "'>" . $i . "</a></li>";
                    }?>
                    <li><a href="{{ url('topics/show/'~topic.id~'?page='~page.last) }}"><i class="fa fa-angle-double-right"></i></a></li>
                </ul>
            </div>
        </div>
        {% endif %}
        {% if not(logged_in is empty) and logged_in %}
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> Reply</h6>
                <form method="post" class="newtopic-form fronteditor" id="replytopicform">
                    <div class="form-group dark">
                        {{ form.render('content') }}
                        <div class="fronteditor"></div>
                        <p class="help-block">不支持HTML标签，仅支持<a href="{{ url('topics/show/1') }}" target="_blank">markdown</a>写作</p>
                    </div>
                    <div class="form-group col-sm-offset-2">
                        <input type="hidden" name="topics_id" value="{{ topic.id }}">
                        <div class="pull-right">
                            <button type="submit" class="btn btn-lg btn-labeled btn-success"><span class="btn-label icon fa fa-reply"></span> Reply</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        {% endif %}
    </div>

</div>

<!-- Modal for confirming delete -->
<div class="modal fade" id="confirmDelete" tabindex="-1" role="dialog" aria-labelledby="modalConfirmDelete">
  <div class="modal-dialog" role="dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="titleConfirmDelete">确定删除</h4>
      </div>
      <div class="modal-body">
        话题删除后无法撤销。确认删除话题？
      </div>
      <div class="modal-footer">
        <form action={{ url('topics/delete') }} method="post">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="submit" class="btn btn-danger">确认</button>
        <input type="hidden" name="topic_id" value="{{ topic.id }}" />
      </div>
    </div>
  </div>
</div>

{% if not(logged_in is empty) and logged_in %}
<script type="text/javascript">
init.push(function(){
    $("a.ratebtn").click(function(){
        var $which = $(this);
        $.getJSON("{{ url('rates') }}",
            {sid: $which.data("value"), type: $which.data("type")},
            function(json) {
                if (json.success) {
                    var $org = $which.children("em");
                    var orgvalue = parseInt($org.text());
                    $.votetips({obj: $which, str: "+1", callback: function(){
                        $org.html(orgvalue+1);
                    }});
                } else {
                    alert(json.data);
                }
            }
        );
    });
});
</script>
{% endif %}
<script type="text/javascript">
    init.push(function() {
        $("#replytopicform").validate({
            rules: {
                content: {
                    required: true,
                    minlength: 6
                }
            },
            messages: {
                content: {required: "总该写点怎么吧？", minlength: "内容至少6个字节"}
            }
        });
        $("[data-toggle='tooltip']").tooltip();
    });
</script>
