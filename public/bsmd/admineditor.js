/**
 * Created by xaero on 2016/3/27.
 */
$(document).ready(function() {
    var $editor = $('div.admineditor');
    var $textarea = $('#description').hide();
    $editor.markdownEditor({
        theme: 'github',
        preview: true,
        onPreview: function (content, callback) {
            //$parser = new HyperDown\Parser;
            callback( marked(content) );
        }
    });
    $editor.markdownEditor('setContent', $textarea.val());
    $editor.parents('form.admineditor').submit(function() {
        var content = $editor.markdownEditor('content');
        $textarea.val(content);
    });
});