<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>{{ title }} - YZOI Online Judge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <!-- LanderApp's stylesheets -->
    {# stylesheet_link('assets/markdown-plus.min.css') #}
    {{ stylesheet_link('assets/css/bootstrap.min.css') }}
    {{ stylesheet_link('assets/css/font.css') }}
    {{ stylesheet_link('assets/css/yzoiapp.min.css') }}
    {{ stylesheet_link('assets/css/pages.min.css') }}
    {{ stylesheet_link('assets/css/themes.min.css') }}

    {% if additionalCss is defined %}
    {% for css in additionalCss %}
    {{ stylesheet_link(css) }}
    {% endfor %}
    {% endif %}

    <script type="text/javascript">
        var init = [];
    </script>
</head>

{{ content() }}

</html>