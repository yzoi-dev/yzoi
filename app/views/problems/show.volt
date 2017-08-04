{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
        <div class="panel-body no-padding-t">
            <h2 class="text-warning"><?php echo $parser->makeHtml($problem->id . ": " . $problem->title); ?></h2>
            <div>
                <div class="pull-left">
                    <abbr title="Time Limit"><i class="fa fa-clock-o"></i> {{ problem.time_limit }}sec</abbr> &nbsp;
                    <abbr title="Memory Limit"><i class="fa fa-flask"></i> {{ problem.memory_limit}}MB</abbr> &nbsp;
                    <abbr title="Solved"><i class="fa fa-check"></i> {{ problem.solved }}</abbr> &nbsp;
                    <abbr title="Submissions"><i class="fa fa-pencil"></i> {{ problem.submit }}</abbr> &nbsp;
                    <?php
                    if ($problem->spj == 1) {
                        echo "<span class='label label-tags label-danger'><i class='fa fa-lightbulb-o'></i> Special Judge</span> ";
                    }
                    $pass = \YZOI\Common::accept_status($problem->id);
                    if ($pass !== null) {
                        if ($pass) echo "<span class='label label-tags label-success'><i class='fa fa-check'></i> Accept</span>";
                        else echo "<span class='label label-tags label-danger'><i class='fa fa-times'></i> Decline</span>";
                    }
                    ?>
                </div>
                <div class="pull-right">
                    <div class="btn-group">
                        <a class="btn btn-warning" href="#submitModal" data-toggle="modal"><i class="fa fa-cloud-upload"></i> Submit My Code</a>
                    </div>
                    <div class="btn-group">
                        <a class="btn btn-success" href="{{ url('problems/statistic/'~problem.id) }}"><i class="fa fa-bar-chart"></i> Summary</a>
                        <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="{{ url('problems/statistic/'~problem.id) }}"><i class="fa fa-fw fa-bar-chart"></i> Statistic</a></li>
                            <li><a href="{{ url('status?pid='~problem.id) }}"><i class="fa fa-fw fa-legal"></i> Status</a></li>
                            <li><a href="{{ url('status?pid='~problem.id~'&uname='~logged_in.name) }}"><i class="fa fa-fw fa-user"></i> My Submission</a></li>
                        </ul>
                    </div>
                    <div class="btn-group">
                        <a class="btn btn-info" href="#"><i class="fa fa-comments-alt"></i> Discuss</a>
                        <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="{{ url('topics/list?pid='~problem.id) }}"><i class="fa fa-fw fa-comments"></i> Discuss</a></li>
                            <li><a href="{{ url('topics/list/solution?pid='~problem.id) }}"><i class="fa fa-fw fa-paste"></i> Solution</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-9">
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-th-large"></i> Description</span>
                <div class="panel-heading-controls">
                    <a class="btn btn-xs btn-info" href="<?php echo $this->url->get('problems/list?page='), floor((intval($problem->id) - 1000) / 100)+1;?>"><span class="fa fa-reply"></span>&nbsp;&nbsp;Back to List</a>
                </div>
            </div>
            <div class="panel-body markdown-body">
                <?php echo $parser->makeHtml($problem->description); ?>
            </div>
            <?php if (trim($problem->pdfname) != '') {?>
                <div class="panel-footer" id="pdfdescription"></div>
                <script src="<?php echo $this->url->get('assets/js/pdfobject.min.js');?>"></script>
                <script>PDFObject.embed("<?php echo $this->url->get('assets/pdf/'. trim($problem->pdfname) .'.pdf');?>", "#pdfdescription", {pdfOpenParams: {view: 'FitBH', toolbar: '0'}});</script>
            <?php } ?>
        </div>
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-copy"></i> Input / Output Sample</span>
            </div>
            <div class="panel-body">
<div class="zero-clipboard"><span class="btn-clipboard">Copy</span></div>
<pre class="alert alert-info">
{{ problem.sample_input }}
</pre>
<div class="zero-clipboard"><span class="btn-clipboard">Copy</span></div>
<pre class="alert alert-info">
{{ problem.sample_output }}
</pre>
            </div>
        </div>
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-lightbulb-o"></i> Hint</span>
            </div>
            <div class="panel-body markdown-body">
                <?php echo $parser->makeHtml($problem->hint); ?>
            </div>
        </div>
    </div>
    <div class="col-sm-3">
        <div class="panel colourable">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> Source/Category</span>
            </div>
            <div class="panel-body padding-xs-vr">
                <ul class="nav nav-tabs nav-tabs-simple nav-justified">
                    <li class="active">
                        <a href="#tab-sources" data-toggle="tab">Source</a>
                    </li>
                    <li>
                        <a href="#tab-tags" data-toggle="tab">Tags</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab-sources">
                        <?php echo "<a href='" . $this->url->get('problems/search?s=src&w=') . $problem->sources . "'>" . $problem->sources . "</a>" ;?>
                    </div>
                    <div class="tab-pane fade taglist" id="tab-tags">
                        <?php foreach ($problem->problems_metas as $pm) {
                            echo "<a href='" . $this->url->get('problems/' . $pm->type . '/') . $pm->id . "'";
                            if ($pm->type == "category")
                                echo "class='label label-success'";
                            else
                                echo "class='label label-info label-tag'";
                            echo ">" . $pm->name . "</a>";
                        }?>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel widget-followers">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> Best Solution</span>
            </div>
            <div class="panel-body padding-xs-vr">
                <?php $is_admin = ($logged_in && $logged_in->is_admin());
                foreach ($best_solutions as $key => $bs) {?>
                    <div class="follower">
                        <img src="{{ url('assets/images/avatars/'~bs.avatar) }}" alt="{{ bs.name }}" class="follower-avatar">
                        <div class="body">
                            <div class="follower-controls">
                                <?php if ($key<3) {
                                    echo "<span class='wizard-step-number active'>" . intval($key+1) . "</span>";
                                } else {
                                    echo "<span class='wizard-step-number'>" . intval($key+1) . "</span>";
                                }?>
                            </div>
                            <a href="#" class="follower-name">{{ bs.name }}</a><br>
                        <span class="follower-username">{{ bs.time }}ms / <?php echo round($bs->memory /1024, 2)?>MB /
                            <?php
                            if ($logged_in && $bs->user_can_access($logged_in)) {
                                echo $this->tag->linkTo(array("status/show/".$bs->id, \YZOI\OJ::$language[$bs->language]));
                            } else {
                                echo \YZOI\OJ::$language[$bs->language];
                            }?>
                        </span>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> ToDo</span>
            </div>
            <div class="panel-body padding-xs-vr">
                <a class="btn btn-warning btn-block" href="#submitModal" data-toggle="modal"><i class="fa fa-cloud-upload"></i> Submit My Code</a>
                <div class="btn-group btn-group-sm padding-sm-vr">
                    <a href="{{ url('status?pid='~problem.id~'&uname='~logged_in.name) }}" class="btn">My Solution</a>
                    <div class="btn-group">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">Summary <i class="fa fa-caret-down"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="{{ url('problems/statistic/'~problem.id) }}">Statistic</a></li>
                            <li><a href="{{ url('status?pic='~problem.id) }}">Status</a></li>
                        </ul>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">Discuss <i class="fa fa-caret-down"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="{{ url('topics/list?pid='~problem.id) }}">Discuss</a></li>
                            <li><a href="{{ url('topics/list/solution?pid='~problem.id) }}">Solution</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{% include("partials/submitcode") %}
<script type="text/javascript">
init.push(function() {
    ZeroClipboard.config({hoverClass:"btn-clipboard-hover"})
    var client = new ZeroClipboard( $('span.btn-clipboard') );
    var wrap = $("#global-zeroclipboard-html-bridge");

    client.on( 'ready', function(event) {
        wrap.data("placement", "top").attr("title", "Copy to Clipboard").tooltip();
        client.on( 'copy', function(event) {
            var pre = $(event.target).parent().next();
            event.clipboardData.setData('text/plain', pre.text());
        });
        client.on( 'aftercopy', function(event) {
            //console.log('Copied text to clipboard: ' + event.data['text/plain']);
            wrap.attr("title", "Copied!").tooltip("fixTitle").tooltip("show").attr("title", "Copy to Clipboard").tooltip("fixTitle");
        });
    });
    client.on( 'error', function(event) {
        // console.log( 'ZeroClipboard error of type "' + event.name + '": ' + event.message );
        ZeroClipboard.destroy();
    });
});
</script>