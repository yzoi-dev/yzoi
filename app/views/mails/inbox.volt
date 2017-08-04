{{ content() }}

{{ flashSession.output() }}

                <div class="tab-pane panel-body in active widget-article-comments no-padding-t">
                    <div class="padding-sm no-padding-hr text-right">
                        <span class="pull-left valign-middle text-bg">共有<?php echo count($maillist);?>个联系人</span>
                        <button class="btn btn-success" data-toggle="modal" data-target="#sendmailModal" data-sendtoid="0">发送私信</button>
                        <button class="btn btn-warning">清空所有私信</button>
                    </div><hr class="no-margin">
                    <?php
                    foreach ($maillist as $mail) {
                        ?>
                        <div class="comment">
                            <img src="{{url('assets/images/avatars/'~mail.avatar)}}" class="comment-avatar">
                            <div class="comment-body">
                                <div class="comment-text">
                                    <div class="comment-heading">
                                        {{ linkTo('users/profile/'~mail.display_id, mail.name) }}<span>{{ date('Y-m-d H:i:s', mail.in_date) }}</span>
                                    </div>
                                    <div>
                                        {{ mail.content }}
                                    </div>
                                </div>
                                <div class="comment-footer">
                                    <?php
                                    $unread_count = $logged_in->countUnreadMails($mail->display_id);
                                    ?>
                                    <a href="{{url('mails/view/'~mail.display_id)}}" class="btn btn-success btn-xs btn-outline">
                                        <?php
                                        if ($unread_count > 0) {
                                            echo $unread_count . " Unread";
                                        } else {
                                            echo "View";
                                        }
                                        ?>
                                    </a>
                                    <a class="btn btn-success btn-xs btn-outline" data-toggle="modal" data-target="#sendmailModal" data-sendtoname="{{ mail.name }}" data-sendtoid="{{ mail.display_id }}">Reply</a>
                                    <a class="btn btn-success btn-xs btn-outline">Delete</a>
                                </div>
                            </div>
                        </div>
                    <?php } ?>

                </div>
<div id="sendmailModal" class="modal modal-success fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">发送私信</h4>
            </div>
            <form method="post" action="{{ url('mails/send') }}">
                <div class="modal-body form-horizontal" id="submit_body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">发给:</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" placeholder="请输入对方昵称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea  name="content" placeholder="内容最多250个字" class="form-control" rows="5"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="uid">
                    <button type="submit" class="btn btn-warning"><i class="fa fa-check"></i> Send</button>
                </div></form>
        </div>
    </div>
</div>
<script type="text/javascript">
    init.push(function () {
        $('body').addClass('page-profile');
        $("#sendmailModal").on("show.bs.modal", function (event){
            var $button = $(event.relatedTarget);
            var sendto_id = $button.data("sendtoid");
            if (sendto_id > 0) {
                var sendto_name = $button.data("sendtoname");
                var $modal = $(this);
                $modal.find(".modal-title").text("发送私信给" + sendto_name);
                var $inputname = $modal.find(".modal-body input[type='text']");
                var $inputid = $modal.find(".modal-body input[type='hidden']");
                $inputname.val(sendto_name);
                $inputname.attr("readonly", "readonly");
                $inputid.val(sendto_id);
            }
        });
    });
</script>