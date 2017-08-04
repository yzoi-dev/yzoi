/**
 * Created by xaero on 2016/3/27.
 */
$(document).ready(function() {
    var $editor = $('div.fronteditor');
    var $textarea = $('#content').hide();
    if ($editor.length > 0) {
        $editor.markdownEditor({
            theme: 'github',
            preview: true,
            onPreview: function (content, callback) {
                callback(marked(content));
            }
        });
        $editor.markdownEditor('setContent', $textarea.val());
        $editor.parents('form.fronteditor').submit(function () {
            var content = $editor.markdownEditor('content');
            $textarea.val(content);
        });
    }

    var highlight = ace.require("ace/ext/static_highlight");
    var dom = ace.require("ace/lib/dom");
    function qsa(sel) {
        return Array.apply(null, document.querySelectorAll(sel));
    }
    qsa("pre > code").forEach(function (codeEl) {
        var m = codeEl.className.match(/(\w+)/);
        //console.log(m);
        if (!m || m[0]=="c" || m[0]=="cpp") m = new Array("c_cpp");
        highlight(codeEl, {
            mode: "ace/mode/" + m[0],
            theme: "ace/theme/solarized_light",
            trim: true
        }, function (highlighted) {

        });
    });

});