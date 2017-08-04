/**
 * Created by xaero on 2016/3/27.
 */
$(document).ready(function() {
    var highlight = ace.require("ace/ext/static_highlight");
    var dom = ace.require("ace/lib/dom");
    function qsa(sel) {
        return Array.apply(null, document.querySelectorAll(sel));
    }
    qsa("pre > code").forEach(function (codeEl) {
        var m = codeEl.className;
        //console.log(m);
        if (!m || m=="c" || m=="cpp") m = "c_cpp";
        highlight(codeEl, {
            mode: "ace/mode/" + m,
            theme: "ace/theme/solarized_light",
            startLineNumber: 1,
            showGutter: true,
            trim: true
        }, function (highlighted) {

        });
    });

});