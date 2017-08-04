{{ content() }}

{{ flashSession.output() }}

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body markdown-body" id="mdmdmd">
## `print 'hello code'`

evens = [1, 2, 3, 4, 5].collect do |item|
item * 2
end

```javascript
$(document).ready(function() {
$('pre code').each(function(i, block) {
hljs.highlightBlock(block);
});
});
```

Markdown 是一种用来写作的轻量级** 标记语言 **，它用简洁的语法代替排版，而不像一般我们用的字处理软件 Word 或 Pages有大量的排版、字体设置。它使我们专心于码字，用“标记”语法，来代替常见的排版格式。例如此文从内容到格式，甚至插图，键盘就可以通通搞定了。

YZOI系统遵循`Github`用的[GFM](https://help.github.com/categories/writing-on-github/)，风格很漂亮，简洁美观大方。 GFM对标准Markdown做了少了修改，请参考本教程：

<table>
<tr>
    <th>格式</th>
    <th>语法（输入）</th>
    <th>效果（输出）</th>
</tr>
<tr>
    <td>粗体</td>
    <td>`** 两个星号 **`</td>
    <td>** 两个星号 **</td>
</tr>
<tr>
    <td>斜体</td>
    <td>* 一个星号 *</td>
    <td>* 一个星号 *</td>
</tr>
<tr>
    <td>删除线</td>
    <td>~~ 两个波浪线 ~~</td>
    <td>~~ 两个波浪线 ~~</td>
</tr>
<tr>
    <td>标题</td>
    <td>### 三号标题
        #### 四号标题
        ##### 五号标题
    </td>
    <td>###三号标题
        #### 四号标题
        ##### 五号标题</td>
</tr>

</table>

行内公式：`$ x_{1,2} = \dfrac{-b \pm \sqrt{b^2-4ac}}{2a} $`

段落公式：

```math
x_{1,2} = \dfrac{-b \pm \sqrt{b^2-4ac}}{2a}
```



代码编辑:whale: ：

```cpp
#include <iostream>
using namespace std;

    int main() {
    int a, b;

    cin >> a >> b;
    cout << a+b << '\n';

    return 0;
}
```

[Code Formatting](https://help.github.com/articles/markdown-basics/#code-formatting)


## Tables and alignment

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |

[Table Syntax](https://help.github.com/articles/github-flavored-markdown/#tables)


## Task list

- [ ] a bigger project
- [x] first subtask
- [x] follow up subtask
- [ ] final subtask
- [ ] a separate task

[Task List Syntax](https://help.github.com/articles/writing-on-github/#task-lists)

            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-12">
        <div class="panel colourable">
            <div class="panel-body no-padding-t">
                <h6 class="text-light-gray text-semibold text-xs text-left"><i class="fa fa-pencil"></i> New Topic</h6>
                <form action="{{ url('topics/create') }}" method="post" class="newtopic-form fronteditor" id="newtopicform">
                    <div class="form-group dark">
                        <div class="input-group input-group-lg">
                        <span class="input-group-addon">
                            <select class="form-control" name="flag">
                                <option selected="selected" value="">选择主题类型</option>
                                <option value="">不选择</option>
                                <?php foreach ($flags as $key => $topicflag) {
                                    echo "<option value='" . $key . "'>" . $topicflag . "</option>";
                                }
                                ?>
                            </select>
                        </span>
                            {{ form.render('title') }}
                        </div>
                        <!--<p class="help-block">标题中可以使用LaTeX公式，放在双美元符中，如<code>$$ \Delta = b^2-4ac $$</code></p>-->
                    </div>
                    <div class="form-group form-inline dark">
                        <label class="control-label">题目ID：</label>
                        {{ form.render('problems_id') }}
                        <span class="help-block-inline">若非针对题目，则请留空</span>
                    </div>
                    <div class="form-group dark">
                        <div id="mdp-container" style="height: 680px;">
                            <div class="ui-layout-north">
                                <div id="toolbar" class="noselect">
                                    <i title="Bold" class="fa fa-bold styling-icon" data-modifier="**"></i>
                                    <i title="Italic" class="fa fa-italic styling-icon" data-modifier="*"></i>
                                    <i title="Strikethrough" class="fa fa-strikethrough styling-icon" data-modifier="~~"></i>
                                    <i title="Underline" class="fa fa-underline styling-icon" data-modifier="++"></i>
                                    <i title="Mark" class="fa fa-pencil styling-icon" data-modifier="=="></i>
                                    <i class="dividor">|</i>
                                    <i title="Heading 1" class="fa heading-icon" data-level="1">h1</i>
                                    <i title="Heading 2" class="fa heading-icon" data-level="2">h2</i>
                                    <i title="Heading 3" class="fa heading-icon" data-level="3">h3</i>
                                    <i title="Heading 4" class="fa heading-icon" data-level="4">h4</i>
                                    <i title="Heading 5" class="fa heading-icon" data-level="5">h5</i>
                                    <i title="Heading 6" class="fa heading-icon" data-level="6">h6</i>
                                    <i class="dividor">|</i>
                                    <i title="Horizontal rule" id="horizontal-rule" class="fa fa-minus"></i>
                                    <i title="Quote" class="fa fa-quote-left list-icon" data-prefix="> "></i>
                                    <i title="Unordered list" class="fa fa-list-ul list-icon" data-prefix="- "></i>
                                    <i title="Ordered list" class="fa fa-list-ol list-icon" data-prefix="1. "></i>
                                    <i title="Incomplete task list" class="fa fa-square-o list-icon" data-prefix="- [ ] "></i>
                                    <i title="Complete task list" class="fa fa-check-square-o list-icon" data-prefix="- [x] "></i>
                                    <i class="dividor">|</i>
                                    <i title="Link" class="fa fa-link" id="link-icon" data-sample-text="link" data-sample-url="http://mdp.tylingsoft.com/"></i>
                                    <i title="Image" class="fa fa-image" id="image-icon" data-sample-text="image" data-sample-url="http://mdp.tylingsoft.com/icon.png"></i>
                                    <i title="Code" class="fa fa-code" id="code-icon"></i>
                                    <i title="Table" class="fa fa-table" id="table-icon" data-sample="header 1 | header 2
  ---|---
  row 1 col 1 | row 1 col 2
  row 2 col 1 | row 2 col 2"></i>
                                    <i class="dividor">|</i>
                                    <i title="Emoji" class="fa fa-smile-o" data-remodal-target="emoji-modal"></i>
                                    <i title="Font awesome" class="fa fa-flag-o" data-remodal-target="fa-modal"></i>
                                    <i title="Ionicons" class="icon ion-ionic" data-remodal-target="ion-modal"></i>
                                    <i class="dividor">|</i>
                                    <i title="Mathematical formula" class="fa fa-superscript" id="math-icon" data-sample="E = mc^2"></i>
                                    <i title="Flowchart" class="fa fa-long-arrow-right mermaid-icon" data-sample="graph LR
  A-->B"></i>
                                    <i title="Sequence diagram" class="fa fa-exchange mermaid-icon" data-sample="sequenceDiagram
  A->>B: How are you?
  B->>A: Great!"></i>
                                    <i title="Gantt diagram" class="fa fa-sliders mermaid-icon" data-sample="gantt
  dateFormat YYYY-MM-DD
  section S1
  T1: 2014-01-01, 9d
  section S2
  T2: 2014-01-11, 9d
  section S3
  T3: 2014-01-02, 9d"></i>
                                    <i class="dividor">|</i>
                                    <i title="Hide toolbar" class="fa fa-long-arrow-up" id="toggle-toolbar"></i>
                                    <i title="Toggle editor" class="fa fa-long-arrow-left" id="toggle-editor"></i>
                                    <i title="Toggle preview" class="fa fa-long-arrow-right" id="toggle-preview"></i>
                                    <i class="dividor">|</i>
                                    <i title="Preferences" class="fa fa-cog" data-remodal-target="preferences-modal"></i>
                                    <i title="Help" class="fa fa-question-circle" data-remodal-target="help-modal"></i>
                                    <i title="About" class="fa fa-info-circle" data-remodal-target="about-modal"></i>
                                </div>
                            </div>
                            <div class="ui-layout-center">
                                <div id="editor"></div> <!-- editor -->
                                <div class="remodal" id="emoji-modal" data-remodal-id="emoji-modal"> <!-- emoji modal -->
                                    <h2>Please enter an emoji code:</h2>
                                    <p>Examples: "smile", "whale", "santa", "panda_face", "dog", "truck" ...</p>
                                    <p>For a complete list, please check <a href="http://www.emoji-cheat-sheet.com/" target="_blank">Emoji Cheat Sheet</a>.</p>
                                    <p><input class="form-control" id="emoji-code" placeholder="smile"/></p>
                                    <br/><a data-remodal-action="cancel" class="remodal-cancel">Cancel</a>
                                    <a data-remodal-action="confirm" class="remodal-confirm" id="emoji-confirm">OK</a>
                                </div>
                                <div class="remodal" id="fa-modal" data-remodal-id="fa-modal"> <!-- Font Awesome modal -->
                                    <h2>Please enter a Font Awesome code:</h2>
                                    <p>Examples: "cloud", "flag", "car", "truck", "heart", "dollar" ...</p>
                                    <p>For a complete list, please check <a href="http://fontawesome.io/icons/" target="_blank">Font Awesome Icons</a>.</p>
                                    <p><input class="form-control" id="fa-code" placeholder="heart"/></p>
                                    <br/><a data-remodal-action="cancel" class="remodal-cancel">Cancel</a>
                                    <a data-remodal-action="confirm" class="remodal-confirm" id="fa-confirm">OK</a>
                                </div>
                                <div class="remodal" id="ion-modal" data-remodal-id="ion-modal"> <!-- Ionicons modal -->
                                    <h2>Please enter an Ionicons code:</h2>
                                    <p>Examples: "beer", "key", "locked", "location", "plane", "ios-eye" ...</p>
                                    <p>For a complete list, please check <a href="http://ionicons.com/" target="_blank">Ionicons Website</a>.</p>
                                    <p><input class="form-control" id="ion-code" placeholder="beer"/></p>
                                    <br/><a data-remodal-action="cancel" class="remodal-cancel">Cancel</a>
                                    <a data-remodal-action="confirm" class="remodal-confirm" id="ion-confirm">OK</a>
                                </div>
                                <div class="remodal" id="preferences-modal" data-remodal-id="preferences-modal" data-remodal-options="closeOnEscape: false, closeOnCancel: false, closeOnOutsideClick: false"> <!-- Preferences modal -->
                                    <img src="icon.png" width="64"/>
                                    <h2>Markdown Plus Preferences</h2>
                                    <p>Show toolbar: <select id="show-toolbar">
                                            <option value="yes">Yes</option>
                                            <option value="no">No</option>
                                        </select></p>
                                    <p>Editor : Preview <select id="editor-versus-preview">
                                            <option value="100%">0 : 1</option>
                                            <option value="66.6%">1 : 2</option>
                                            <option value="50%">1 : 1</option>
                                            <option value="33.3%">2 : 1</option>
                                            <option value="1">1 : 0</option>
                                        </select></p>
                                    <p>Editor theme: <select id="editor-theme">
                                            <option value="tomorrow_night_blue">Blue</option>
                                            <option value="tomorrow">Bright</option>
                                            <option value="tomorrow_night_eighties">Dark</option>
                                            <option value="kuroir">Gray</option>
                                        </select></p>
                                    <p>Editor font size: <select id="editor-font-size">
                                            <option value="8">8px</option><option value="9">9px</option><option value="10">10px</option><option value="11">11px</option>
                                            <option value="12">12px</option><option value="13">13px</option><option value="14">14px</option><option value="15">15px</option>
                                            <option value="16">16px</option><option value="17">17px</option><option value="18">18px</option><option value="20">20px</option>
                                            <option value="24">24px</option><option value="32">32px</option><option value="48">48px</option><option value="64">64px</option>
                                        </select></p>
                                    <p>Key binding: <select id="key-binding">
                                            <option value="default">Default</option>
                                            <option value="emacs">Emacs</option>
                                            <option value="vim">Vim</option>
                                        </select></p>
                                    <p>Gantt diagram axis format: <input id="gantt-axis-format" placeholder="%Y-%m-%d"/>
                                        <br/><a href="https://github.com/mbostock/d3/wiki/Time-Formatting" target="_blank">Time formatting reference</a></p>
                                    <p>Custom CSS files: <textarea id="custom-css-files" wrap="off" placeholder="https://cdn.example.com/file1.css
  https://cdn.example.com/file2.css"></textarea>
                                        <br/><span class="hint">(You need to restart the editor to apply the CSS files)</span>
                                        <br/><a href="https://github.com/tylingsoft/markdown-plus-themes" target="_blank">Markdown Plus themes</a></p>
                                    <p>Custom JS files: <textarea id="custom-js-files" wrap="off" placeholder="https://cdn.example.com/file1.js
  https://cdn.example.com/file2.js"></textarea>
                                        <br/><span class="hint">(You need to restart the editor to apply the JS files)</span>
                                        <br/><a href="https://github.com/tylingsoft/markdown-plus-plugins" target="_blank">Markdown Plus plugins</a></p>
                                    <br/><a data-remodal-action="confirm" class="remodal-confirm">OK</a>
                                </div>
                                <div class="remodal" data-remodal-id="help-modal"> <!-- help modal -->
                                    <img src="icon.png" width="64"/>
                                    <h2>Markdown Plus help</h2>
                                    <p><a href="http://mdp.tylingsoft.com/" target="_blank">Online Sample</a></p>
                                    <p><a href="https://github.com/ajaxorg/ace/wiki/Default-Keyboard-Shortcuts" target="_blank">Keyboard Shortcuts</a></p>
                                    <p><a href="https://guides.github.com/features/mastering-markdown/" target="_blank">Markdown Basics</a></p>
                                    <p><a href="https://help.github.com/articles/github-flavored-markdown/" target="_blank">GitHub Flavored Markdown</a></p>
                                    <p><a href="http://www.emoji-cheat-sheet.com/" target="_blank">Emoji Cheat Sheet</a></p>
                                    <p><a href="http://fontawesome.io/icons/" target="_blank">Font Awesome Icons</a></p>
                                    <p><a href="http://ionicons.com/" target="_blank">Ionicons Website</a></p>
                                    <p><a href="http://meta.wikimedia.org/wiki/Help:Displaying_a_formula" target="_blank">Mathematical Formula</a></p>
                                    <p><a href="http://knsv.github.io/mermaid/#flowcharts-basic-syntax" target="_blank">Flowchart Syntax</a></p>
                                    <p><a href="http://knsv.github.io/mermaid/#sequence-diagrams" target="_blank">Sequence Diagram Syntax</a></p>
                                    <p><a href="http://knsv.github.io/mermaid/#gant-diagrams" target="_blank">Gantt Diagram Syntax</a></p>
                                    <p>If none of the above solves your problem, please <a target="_blank" href="http://tylingsoft.com/contact/">contact us</a>.</p>
                                    <br/><a data-remodal-action="confirm" class="remodal-confirm">OK</a>
                                </div>
                                <div class="remodal" data-remodal-id="about-modal"> <!-- about modal -->
                                    <img src="icon.png" width="64"/>
                                    <h2>Markdown Plus</h2> Version 1.9.x
                                    <p>Markdown editor with extra features.</p>
                                    <p>Copyright © 2016 <a href="http://tylingsoft.com" target="_blank">Tylingsoft</a>.</p>
                                    <p>Home page: <a href="http://tylingsoft.com/markdown-plus/" target="_blank">http://tylingsoft.com/markdown-plus/</a>.</p>
                                    <br/><a data-remodal-action="confirm" class="remodal-confirm">OK</a>
                                </div>
                            </div>
                            <div class="ui-layout-east">
                                <article class="markdown-body" id="preview"></article>
                                <article class="markdown-body" id="cache" style="display: none"></article>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-sm-offset-2">
                        <button type="submit" class="btn btn-lg btn-labeled btn-success"><span class="btn-label icon fa fa-pencil"></span> Create Topic</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
init.push(function() {
    var md = $('#mdmdmd').html();
    $('#mdmdmd').html(mdc.render(md));
});
</script>