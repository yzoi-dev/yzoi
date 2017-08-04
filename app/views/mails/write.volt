{{ content() }}

{{ flashSession.output() }}

<form method="post" action="{{ url('mails/send') }}">
    <fieldset class="form-group">
        <label class="col-sm-2 control-label">发给:</label>
        <input type="text" name="name" placeholder="请输入对方昵称" class="form-control" value="{{ username }}">
    </fieldset>
    <fieldset class="form-group">
        <textarea  name="content" placeholder="内容最多250个字" class="form-control" rows="5"></textarea>
    </fieldset>
    <input type="hidden" name="uid">
    <button type="submit" class="btn btn-info"><i class="fa fa-check"></i> Send</button>
</form>