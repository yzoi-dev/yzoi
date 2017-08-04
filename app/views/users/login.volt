<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>用户登录 - YZOI Onlinde Judge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <!-- LanderApp's stylesheets -->
    {{ stylesheet_link('assets/css/bootstrap.min.css') }}
    {{ stylesheet_link('assets/css/font.css') }}
    {{ stylesheet_link('assets/css/yzoiapp.min.css') }}
    {{ stylesheet_link('assets/css/pages.min.css') }}
    {{ stylesheet_link('assets/css/themes.min.css') }}
    <script type="text/javascript">
        var init = [];
    </script>
</head>


<body class="theme-dust page-signin">
<div id="page-signin-bg">
    <!-- Background overlay -->
    <div class="overlay"></div>
    {{ image("assets/images/signin-bg-1.jpg") }}
</div>
<!-- Container -->
<div class="signin-container">
    <div class="signin-info">
        <a href="{{ url('') }}" class="logo">YZOI</a>
        <div class="slogan">
            Yizhong Olympiad in Informatics Online Judge
        </div>
        <ul>
            <li><i class="fa fa-sitemap signin-icon"></i> Well formed classification</li>
            <li><i class="fa fa-search signin-icon"></i> Powerful search engine</li>
            <li><i class="fa fa-television signin-icon"></i> Flexible job monitoring</li>
            <li><i class="fa fa-heart signin-icon"></i> Crafted with accessibility</li>
        </ul>
    </div>
    <div class="signin-form">
        <div class="signin-text">
            <span>Sign In to your account</span>
        </div>

{{ content() }}

{{ flashSession.output() }}

        {{ form('users/login', 'id': 'signin-form_id') }}

        <div class="form-group w-icon dark">
            {{ form.render('name') }}
            <span class="fa fa-user signin-form-icon"></span>
        </div>
        <div class="form-group w-icon dark">
            {{ form.render('password') }}
            <span class="fa fa-lock signin-form-icon"></span>
        </div>
        <div class="form-group">
            <label class="checkbox-inline">
                {{ form.render('remember') }}
                <span class="lbl">Remember Me</span>
            </label>
        </div>
        <div class="form-actions">
            {{ form.render(form.getCsrfName()) }}
            <input type="submit" value="登 录" class="signin-btn bg-warning">
            <a href="javascript:;" class="forgot-password" id="forgot-password-link">Forgot your password?</a>
        </div>
        <div class="signin-with">
            <a href="#" class="signin-with-btn">Sign In with <span>Facebook</span></a>
        </div>
        {{ endForm() }}
        <div class="password-reset-form" id="password-reset-form">
            <div class="header">
                <div class="signin-text">
                    <span>Password reset</span>
                    <div class="close">&times;</div>
                </div>
            </div>
            <form action="{{ url('users/forgot') }}" id="password-reset-form_id" method="post">
                <div class="form-group w-icon dark">
                    <input type="text" name="password_reset_email" id="p_email_id" class="form-control input-lg" placeholder="Enter your email">
                    <span class="fa fa-envelope signin-form-icon"></span>
                </div>
                <?php if (isset($captform)) { ?>
                <div class="form-group w-icon dark">
                    {{ captform.render('captcha') }}
                    <span class="fa fa-key signin-form-icon"></span>
                </div>
                <div class="form-group w-icon dark">
                    <img src="{{ url('index/captcha') }}" class="captcha" title="点击刷新验证码" alt="点击刷新验证码">
                </div>
                <?php } ?>
                <div class="form-actions">
                    {{ form.render(form.getCsrfName()) }}
                    <input type="submit" value="SEND PASSWORD RESET LINK" class="signin-btn bg-warning">
                </div>
            </form>
        </div>
    </div>
</div>

<div class="not-a-member">
    Not a member? {{ link_to("users/register", "Sign up now") }}
</div>

{{ javascript_include('assets/js/jquery.js') }}
{{ javascript_include('assets/js/jquery.validate.js') }}
{{ javascript_include('assets/js/bootstrap.js') }}
{{ javascript_include('assets/js/yzoiapp.js') }}
<script type="text/javascript">
// Show/Hide password reset form on click
$('#forgot-password-link').click(function () {
    $('#password-reset-form').fadeIn(400);
    return false;
});
$('#password-reset-form .close').click(function () {
    $('#password-reset-form').fadeOut(400);
    return false;
});


$("#signin-form_id").validate({
    rules: {
        name : {required: true, minlength:4},
        password: {required: true, minlength: 5},
    },
    messages:{
        name: {required: "请输入用户名", minlength: "用户名长度至少4个字符"},
        password: {required: "请输入密码", minlength: "密码长度至少是5个字符"}
    }
});

$("#password-reset-form_id").validate({
    rules: {
        password_reset_email : {required: true, email:true},
        <?php if (isset($captform)) { ?>
        captcha : {required: true},
        <?php }?>
    },
    messages:{
        password_reset_email: {required: "请输入Email", email:"Email格式不正确"},
        <?php if (isset($captform)) { ?>
        captcha : {required: "请输入验证码"},
        <?php }?>
    }
});

$('form > div > img.captcha').click(function(){
    //console.log($(this));
    $(this).attr('src', '/yzoix/index/captcha');
});

window.LanderApp.start(init);
</script>
</body>
</html>