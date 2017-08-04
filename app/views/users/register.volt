<!DOCTYPE html>
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if IE 9]>         <html class="ie9 gt-ie8"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="gt-ie8 gt-ie9 not-ie"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>用户注册 - YZOI Onlinde Judge</title>
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

<body class="theme-dust page-signup">
<div id="page-signup-bg">
    <!-- Background overlay -->
    <div class="overlay"></div>
    {{ image("assets/images/signin-bg-1.jpg") }}
</div>
<!-- Container -->
<div class="signup-container">
    <div class="signup-header">
        <a href="{{ url('') }}" class="logo">
            YZOI <span style="font-weight:100;">Yizhong Olympiad in Informatics Online Judge</span>
        </a>
        <div class="slogan">
            Simple. Flexible. Powerful.
        </div>
    </div>

    <div class="signup-form">
        <div class="signup-text">
            <span>Create an account</span>
        </div>

        {{ content() }}

        {{ flashSession.output() }}

        {{ form('users/register', 'id': 'signup-form_id') }}
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group w-icon dark">
                    {{ form.render("name", ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-user signup-form-icon"></span>
                </div>

                <div class="form-group w-icon dark">
                    {{ form.render('password', ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-lock signup-form-icon"></span>
                </div>

                <div class="form-group w-icon dark">
                    {{ form.render('confirmPassword', ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-lock signup-form-icon"></span>
                </div>

                <div class="form-group dark" style="margin-top: 20px;margin-bottom: 20px;">
                    <label class="checkbox-inline">
                        {{ form.render('terms') }}
                        <span class="lbl">I agree with the <a href="#" target="_blank">Terms and Conditions</a></span>
                    </label>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group w-icon dark">
                    {{ form.render('email', ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-envelope signup-form-icon"></span>
                </div>
                <div class="form-group w-icon dark">
                    {{ form.render('nick', ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-info signup-form-icon"></span>
                </div>
                <div class="form-group w-icon dark">
                    {{ form.render('school', ["class" : "form-control input-lg"]) }}
                    <span class="fa fa-university signup-form-icon"></span>
                </div>

                <div class="form-actions">
                    {{ form.render(form.getCsrfName()) }}
                    <button type="submit" class="signup-btn btn-warning"><i class="fa fa-check"></i> 注 册</button>
                </div>
            </div>
        </div>
        {{ endForm() }}
        <div class="signup-with">
            <a href="#" class="signup-with-btn btn-default">Sign Up with <span>Facebook</span></a>
        </div>
    </div>
</div>

<div class="have-account">
    Already have an account? {{ link_to("users/login", "Sign In") }}
</div>


{{ javascript_include('assets/js/jquery.js') }}
{{ javascript_include('assets/js/jquery.validate.js') }}
{{ javascript_include('assets/js/bootstrap.js') }}
{{ javascript_include('assets/js/yzoiapp.js') }}

<script type="text/javascript">
$("#signup-form_id").validate({
    rules: {
        name : {required: true, minlength:4},
        email : {required: true, email: true},
        school: {required: true, minlength: 2},
        password: {required: true, minlength: 5},
        confirmPassword: {required: true, minlength: 5, equalTo: "#password"},
        terms : {required:true}
    },
    messages:{
        name: {minlength: "用户名长度至少4个字符"},
        password: {minlength: "密码长度至少是5个字符"},
        confirmPassword: {equalTo: "两次输入的密码不一样！"}
    }
});

window.LanderApp.start(init);
</script>

</body>
</html>