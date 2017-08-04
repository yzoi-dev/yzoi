{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-9">
                <div class="panel colourable">
                    <div class="panel-body text-center no-padding-t">
                        <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-search"></i> Topic Searching</h6>
                        <form action="#" class="search-form">
                            <div class="input-group input-group-lg">
                                <span class="input-group-addon no-background"><i class="fa fa-search"></i></span>
                                <input type="text" name="s" class="form-control" placeholder="Type your search here...">
                                <span class="input-group-btn"><button class="btn" type="submit">Search</button></span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="panel colourable">
                    <div class="panel-body text-center no-padding-t">
                        <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> Any questions?</h6>
                        <div class="input-group input-group-lg">
                            <span class="input-group-btn"><a href="#newtopicform" class="btn btn-lg btn-success"><i class="fa fa-pencil"></i> New Topic</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel widget-comments">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-comments-o"></i>Topics</span>
                <ul class="nav nav-tabs nav-tabs-xs">
                    <?php
                    $params = $this->dispatcher->getParams();

                    echo '<li';
                    if (empty($params)) echo ' class="active"';
                    echo '>' . $this->tag->linkTo('topics', 'All');

                    foreach (\YZOI\OJ::$topic_flag as $key => $value) {
                        echo '<li';
                        if (isset($params[0]) && $params[0] == $key) echo ' class="active"';
                        echo '>' . $this->tag->linkTo('topics/list/'.$key, $value) .'</li>';
                    } ?>
                </ul>
            </div> <!-- / .panel-heading -->
            <div class="panel-body">
                {% if page.items is defined %}
                {% for topic in page.items %}
                <div class="comment">
                    <img src="{{ url('assets/images/avatars/'~topic.avatar) }}" class="comment-avatar">
                    <div class="comment-body">
                        <div class="comment-by">
                            Started by <a href="{{ url('users/profile/'~topic.users_id) }}">{{ topic.name }}</a>
                            <?php
                            $last_reply_info = $topic->getLastReplyInfo();
                            if ($last_reply_info) {
                            ?>
                            / Last replied by
                            <a href="{{ url('users/profile/'~last_reply_info['user_id']) }}">{{ last_reply_info["user_name"] }}</a>
                            <?php
                            echo YZOI\Common::datetimeFormat($last_reply_info["reply_time"]);
                            }
                            ?>
                        </div>
                        <div class="comment-text">
                            <a href="{{ url('topics/show/'~topic.id) }}"><?php echo $parser->makeHtml($topic->title); ?></a>
                        </div>
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
                            <a href="javascript:;"><i class="fa fa-thumbs-o-up"></i>赞:{{ topic.vote_count }}</a>
                            <?php if ($logged_in && $topic->user_can_modify($logged_in)) { ?>
                            <a href="{{ url('topics/edit/topic/'~topic.id) }}"><i class="fa fa-pencil"></i>Edit</a>
                            <a href="#"><i class="fa fa-times"></i>Remove</a>
                            <?php } ?>
                            <span class="pull-right">{{ date('Y-m-d H:i:s', topic.datetimes) }}</span>
                        </div>
                    </div>
                </div>
                {% endfor %}
                {% endif %}
            </div>
            <div class="panel-footer">
                <ul class="pagination pagination-xs">
                    <li><a href="{{ url('topics?page='~page.first) }}"><i class="fa fa-angle-double-left"></i></a></li>
                    <?php for ($i=1; $i<=$page->total_pages; $i++) {
                        echo "<li";
                        if ($i == $page->current) echo " class='active'";
                        echo "><a href='" , $this->url->get('topics') ,  '?page=' , $i , "'>" , $i , "</a></li>";
                    }?>
                    <li><a href="{{ url('topics?page='~page.last) }}"><i class="fa fa-angle-double-right"></i></a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

{% if not(logged_in is empty) and logged_in %}
<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> New Topic</h6>
                <form action="{{ url('topics/create') }}" method="post" class="newtopic-form fronteditor" id="newtopicform">
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
                <div class="form-group dark">
                    {{ form.render('content') }}
                    <div class="fronteditor"></div>
                    <p class="help-block">不支持HTML标签，仅支持<a href="{{ url('topics/show/1') }}" target="_blank">markdown</a>写作</p>
                </div>
                <div class="form-group col-sm-offset-2">
                    <button type="submit" class="btn btn-lg btn-labeled btn-success"><span class="btn-label icon fa fa-pencil"></span> Create Topic</button>
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
{% endif %}
