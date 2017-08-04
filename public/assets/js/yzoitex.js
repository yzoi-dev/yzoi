var tex = document.getElementsByClassName("yzoitex");
Array.prototype.forEach.call(tex, function(el) {
    katex.render(el.getAttribute("data-expr"), el, {throwOnError : false});
});