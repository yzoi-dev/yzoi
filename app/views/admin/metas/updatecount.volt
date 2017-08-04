{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 更新分类下的题目数量</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon"></div>
                </div>
            </div>
            <div class="panel-body form-group simple">
                <div class="alert alert-info">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <strong>提示：</strong> 分类/标签表中有相应的题目数量（冗余字段），该功能可以更新到正确的题目数量
                </div>
                <?php if (isset($updatecount)) echo $updatecount;?>
            </div>            
        </div>
    </div>    
</div>

