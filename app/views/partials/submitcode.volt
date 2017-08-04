<div id="submitModal" class="modal modal-success fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    <?php if (isset($contest->id))
                        echo "Contest $contest->id, Submit Code for Problem $display_pid";
                    else
                        echo "Submit Code for Problem " . $problem->id;
                    ?>
                </h4>
            </div>
            <form action="{{ url('problems/submitcode') }}" method='post'>
                <div class="modal-body form-horizontal">
                    {% if contest.id is defined %}
                    {{ form.render('ccid') }}
                    {{ form.render('cpid') }}
                    {% endif %}
                        <div class="form-group">
                            <label for="problem_id" class="col-sm-2 control-label">Problem:</label>
                            <div class="col-sm-10">
                                {{ form.render('problem_id') }}
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="language" class="col-sm-2 control-label">Language:</label>
                            <div class="col-sm-10">
                                {{ form.render('language') }}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                {{ form.render('sourcecode') }}
                            </div>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-warning"><i class="fa fa-check"></i> Submit</button>
                    <button type="reset" class="btn btn-default"><i class="fa fa-refresh"></i> Reset</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-remove"></i> Close</button>
                </div></form>
        </div>
    </div>
</div>