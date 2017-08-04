<div id="dataModal" class="modal modal-success fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-default">
                    <div class="panel-body clearfix">
                        <div class="col-sm-9"><input type="file" class="pull-left" name="files_upload" id="files_upload"></div>
                        <div class="col-sm-3"><button type="button" class="btn btn-warning pull-right" id="do_upload"><i class="fa fa-upload"></i> Upload</button></div>
                    </div>
                    <table class="table">
                        <thead>
                        <tr>
                            <th width="10" class="text-center">№</th>
                            <th width="40" class="text-center">Size</th>
                            <th class="text-right">In</th>
                            <th>Out</th>
                            <th width="40" class="text-center">Size</th>
                        </tr>
                        </thead>
                        <tbody id="testdatalist">
                        <tr>
                            <td class="text-center">8</td>
                            <td class="text-center">123</td>
                            <td class="text-right">a.in</td>
                            <td>a.out</td>
                            <td class="text-center">321</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-check"></i> OK</button>
            </div>
        </div>
    </div>
</div>
<?php $timestamp = time(); ?>
<script type="text/javascript">
init.push(function () {
    var showFileListFn = function(pid) {
        var url = "{{ url(admin_uri~'/problems/testfilelist/') }}" + pid;
        $.getJSON(url, function(response){
            //.html(response.length);
            var datacnt = response.length;
            var html = '';
            for (var i=0; i<datacnt; i+=2) {
                html += '<tr><td class="text-center">' + (i+2)/2 + '</td><td class="text-center">';
                if (response[i].filesize >= 1024)
                    html += Math.round(response[i].filesize/1024) + 'KB';
                else
                    html += response[i].filesize  + 'B';
                html += '</td><td class="text-right">' + response[i].filename + '</td><td>';

                if ((i+1) < datacnt)
                {
                    html += response[i+1].filename + '</td><td class="text-center">';
                    if (response[i+1].filesize >= 1024)
                        html += Math.round(response[i+1].filesize / 1024) + 'KB';
                    else
                        html += response[i+1].filesize  + 'B';
                } else {
                    html += '</td><td>'
                }

                html += '</td></tr>';
            }
            $('#testdatalist').html(html);
        })
    };
    $(".testdata").click(function(){
        var pid = $(this).data("value");
        var $uploader = $("#files_upload");
        $uploader.uploadifive({
            'auto': false,
            'buttonText': 'Select Text Files',
            'fileSizeLimit' : <?php echo intval($this->config->uploader->testdata_size) / 1024; ?>,
            'fileType': '*.in; *.out; *.dic',
            'formData': {
                'timestamp': '<?php echo $timestamp; ?>',
                'token': '<?php echo md5($this->config->application->cryptSalt . $timestamp); ?>'
            },
            'uploadScript' : "{{ url(admin_uri~'/problems/uploadtestdata/') }}" + pid,
            'onError': function(errorType) {
                alert("Something Wrong: " + errorType);
            },
            'onUploadComplete': function(file, data) {
                console.log(file);
                //console.log(data);
            },
            'onQueueComplete': function(data) {
                showFileListFn(pid);
                console.log(data);
                $uploader.uploadifive('clearQueue');
            }
        });
    });
    $("#dataModal").on('show.bs.modal', function(e) {
        var pid = $(e.relatedTarget).data('value');
        $(".modal-title").text("Testdata of Problem - " + pid);
        showFileListFn(pid);
    });
    $('#do_upload').click(function() {
        $('#files_upload').uploadifive('upload');
    });
});
</script>