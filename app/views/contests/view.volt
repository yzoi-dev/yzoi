{{ content() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h2 class="text-warning"><em>{{ title }}:</em> <?php echo $parser->makeHtml($problem->id . ": " . $problem->title); ?></h2>
                <h5>{{ contest.title }}</h5>
                <div>
                    <div class="pull-left">
                        <abbr title="Time Limit"><i class="fa fa-clock-o"></i> {{ problem.time_limit }}sec</abbr> &nbsp;
                        <abbr title="Memory Limit"><i class="fa fa-flask"></i> {{ problem.memory_limit}}MB</abbr> &nbsp;
                        <abbr title="Solved"><i class="fa fa-check"></i> {{ problem.solved }}</abbr> &nbsp;
                        <abbr title="Submissions"><i class="fa fa-pencil"></i> {{ problem.submit }}</abbr> &nbsp;
                        <?php $pass = \YZOI\Common::accept_status($problem->id);
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
                            <a class="btn btn-success" href="#"><i class="fa fa-bar-chart"></i> Summary</a>
                            <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="{{ url('contests/standing/'~contest.id) }}"><i class="fa fa-bar-chart"></i> Statistic</a></li>
                                <li><a href="{{ url('contests/status?cid='~contest.id) }}"><i class="fa fa-legal"></i> Status</a></li>
                                <li><a href="{{ url('contests/status?cid='~contest.id~'&uname='~logged_in.name) }}"><i class="fa fa-user"></i> My Solution</a></li>
                            </ul>
                        </div>
                        <div class="btn-group">
                            <a class="btn btn-info" href="#"><i class="fa fa-comments-alt"></i> Discuss</a>
                            <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#problem_discuss" data-toggle="tab"><i class="fa fa-comments-alt"></i> Discuss</a></li>
                                <li><a href="#"><i class="fa fa-paste"></i> 解题报告</a></li>
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
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> Source</span>
            </div>
            <div class="panel-body padding-xs-vr">
                <?php echo "<a href='" . $this->url->get('problems/search?s=src&w=') . $problem->sources . "'>" . $problem->sources . "</a>" ;?>
            </div>
        </div>
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="panel-title-icon fa fa-link"></i> ToDo</span>
            </div>
            <div class="panel-body padding-xs-vr">
                <button class="btn btn-warning btn-block"><i class="fa fa-cloud-upload"></i> Submit My Code</button>
                <div class="btn-group btn-group-sm padding-sm-vr">
                    <button type="button" class="btn">My Solution</button>
                    <div class="btn-group">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">Summary <i class="fa fa-caret-down"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#">Dropdown link</a></li>
                            <li><a href="#">Dropdown link</a></li>
                        </ul>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">Discuss <i class="fa fa-caret-down"></i></button>
                        <ul class="dropdown-menu">
                            <li><a href="#">Dropdown link</a></li>
                            <li><a href="#">Dropdown link</a></li>
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