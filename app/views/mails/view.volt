{{ content() }}

{{ flashSession.output() }}
                <div id="mailsession" class="panel-body widget-chat">
                    <?php
                    foreach ($mails as $mail) {
                        if ($mail->from_user == $user->id) {
                            $display_avatar = $user->avatar;
                            $display_name = $user->name;
                            $display_id = $user->id;
                            $display_addon_css = " right margin-left-only";
                        } else {
                            $display_avatar = $chat_user->avatar;
                            $display_name = $chat_user->name;
                            $display_id = $chat_user->id;
                            $display_addon_css = " margin-right-only";
                        }
                        ?>
                        <div class="message<?php echo $display_addon_css;?>">
                            <img src="{{ url('assets/images/avatars/'~display_avatar) }}" class="message-avatar">
                            <div class="message-body">
                                <div class="message-heading">
                                    {{ linkTo("users/profile/"~display_id, display_name) }} says:
                                    <span class="pull-right">{{ date('Y-m-d H:i:s', mail.in_date) }}</span>
                                </div>
                                <div class="message-text">
                                    {{ mail.content }}
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                    <hr>
                    <form id="submit_body" class="form-horizontal" method="post">
                        <div class="form-group">
                            <div class="col-sm-12 text-bg">发私信给: {{ chat_user.name }}</div>
                        </div>
                        <div class="form-group dark">
                            <div class="col-sm-12">
                                <textarea name="content" placeholder="内容最多250个字" class="form-control" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="hidden" name="uid" value="{{ chat_user.id }}">
                                <button type="button" class="btn btn-warning"><i class="fa fa-check"></i> Send</button>
                            </div>
                        </div>
                    </form>
                </div>
<script type="text/javascript">
    init.push(function () {
        $('body').addClass('page-profile');

        $("#submit_body button").click(function (e) {
            //var = $("submit_body")
            jQuery.ajax({
                type : "POST",
                url : "{{ url('users/sendmail') }}",
                data : $("#submit_body").serialize(),
                dataType : "json",
                success : function (json) {
                    console.log(json);
                    if (json.success) {
                        var html = "<div class='message right'>";
                        html += "<img src='{{ url('assets/images/avatars/'~user.avatar) }}' class='message-avatar'>";
                        html += "<div class='message-body'><div class='message-heading'>";
                        html += "<a href='{{ url('users/profile/'~user.id)}}'>{{ user.name }}</a> says:<span class='pull-right'>{{ date('Y-m-d H:i:s', mail.in_date) }}</span>";
                        html += "</div><div class='message-text'>"+ json.data.content +"</div></div></div>";

                        $("#mailsession hr").before(html);
                    }
                }
            });
        });
    });
</script>