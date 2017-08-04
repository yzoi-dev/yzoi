{{ content() }}

<div class="row">
    <div class="col-sm-8" id="categorylist">
        <div class="panel">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 分类{{ parent }}下的所有分类</span>
                <div class="panel-heading-controls">
                    <div class="panel-heading-icon">
                        {% if parent != 0 %}
                        <a href="{{ parparent }}"><i class="fa fa-reply"></i> Back</a>
                        {% endif %}
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Order</th>
                        <th>Operate</th>
                        <th>Children</th>
                        <th>说明</th>
                        <th>题目数量</th>
                    </tr>
                    </thead>
                    <tbody>
                    {% for cate in categories %}
                    <tr>
                        <td>{{ cate.id }}</td>
                        <td class="nowrap"><a href="{{ url('yzoi7x/metas/addcate/'~cate.id) }}" class="text-warning">{{ cate.name }}</a></td>
                        <td>{{ cate.orders }}</td>
                        <td class="nowrap"><a href="{{ url('yzoi7x/metas/editcate/'~cate.id) }}"><i class="fa fa-edit"></i> Edit</a></a></td>
                        <td><a href="{{ url('yzoi7x/metas/addcate/'~cate.id) }}"><i class="fa fa-plus-circle"></i> Add</a></td>
                        <td>{{ cate.description }}</td>
                        <td>{{ cate.count }}</td>
                    </tr>
                    {% endfor %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="panel">
            <form method="post">
            <div class="panel-heading">
                <span class="panel-title"><i class="fa fa-th"></i> 新增分类</span>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <label class="control-label" for="name">分类名称</label>
                    {{ form.render('name') }}
                </div>
                <div class="form-group">
                    <label class="control-label" for="orders">显示次序</label>
                    {{ form.render('orders') }}
                </div>
                <div class="form-group">
                    <label class="control-label" for="parent">父级分类</label>
                    <select id="parent" name="parent" class="form-control">
                        <option value="0">Toppest</option>
                        {% for allcate in allCategories %}
                        <option value="{{ allcate['id'] }}"<?php if ($parent == $allcate['id']) echo " selected='selected'"; ?>>
                            <?php echo str_repeat("----", $allcate['level']), $allcate['name']; ?>
                        </option>
                        {% endfor %}
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label" for="description">分类描述</label>
                    {{ form.render('description') }}
                </div>
            </div>
            <div class="panel-footer text-right">

                <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Submit</button>
                {% if parent != 0 %}
                <a class="btn" href="{{ parparent }}"><i class="fa fa-reply"></i> Cancle</a>
                {% endif %}
            </div>
            </form>
        </div>
    </div>
</div>
