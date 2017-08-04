<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Error 404 - YZOI Onlinde Judge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <!-- LanderApp's stylesheets -->
    {{ stylesheet_link('assets/css/bootstrap.min.css') }}
    {{ stylesheet_link('assets/css/font.css') }}
    {{ stylesheet_link('assets/css/yzoiapp.min.css') }}
    {{ stylesheet_link('assets/css/pages.min.css') }}
    {{ stylesheet_link('assets/css/themes.min.css') }}
</head>


<body class="page-404">


<div class="header">
    <a href="{{url()}}" class="logo">
        <i class="fa fa-codepen"></i> <strong>YZOI</strong> Online Judge
    </a>
</div>

<div class="error-code">404</div>

<div class="error-text">
    <span class="oops">OOPS!</span><br>
    <span class="hr"></span>
    <br>
    SOMETHING WENT WRONG, OR THAT PAGE DOESN'T EXIST... YET
</div> <!-- / .error-text -->

<form action="#" class="search-form">
    <input type="text" class="search-input" name="s">
    <input type="submit" value="SEARCH" class="search-btn">
</form> <!-- / .search-form -->

{{ javascript_include('assets/js/jquery.js') }}
{{ javascript_include('assets/js/bootstrap.js') }}
{{ javascript_include('assets/js/yzoiapp.js') }}

</body>
</html>