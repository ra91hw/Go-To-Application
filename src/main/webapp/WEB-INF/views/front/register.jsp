<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <%@include file="/static/comm/front/taglib.jsp" %>
    <link rel="stylesheet" type="text/css" href="/static/css/login.css">
</head>
<body>
<div class="sucaihuo-container">
    <div class="demo form-bg" style="padding: 60px 0;height: 100%;">
        <div class="container">
            <div class="row">
                <div class="col-md-offset-3 col-md-6">
                    <form class="form-horizontal" id="register_form">
                        <span class="heading">User registration</span>
                        <div class="form-group">
                            <input type="text" class="form-control" id="registerUsername" placeholder="Please enter a username" autocomplete="off">
                            <i class="fa fa-user"></i>
                        </div>
                        <div class="form-group help">
                            <input type="text" class="form-control" id="registerNickname" placeholder="Please enter nickname" autocomplete="off">
                            <i class="fa fa-edit"></i>
                        </div>
                        <div class="form-group help">
                            <input type="password" class="form-control" id="registerPassword" placeholder="Please enter your password" autocomplete="new-password">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="form-group help">
                            <input type="password" class="form-control" id="registerConfirmPassword" placeholder="Please enter your confirmation password" autocomplete="new-password">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-default" id="register_submit">Register</button>
                        </div>
                        <a class="footing" href="/login.html">You already have an account.</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    $('#register_form').submit(function (e) {
        e.preventDefault();
        var username = $.trim($('#registerUsername').val());
        var nickname = $.trim($('#registerNickname').val());
        var password = $.trim($('#registerPassword').val());
        var confirmPassword = $.trim($('#registerConfirmPassword').val());

        if(username == null || username == ''){
            layer.msg("Username cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerUsername").focus();
            return;
        }
        if(nickname == null || nickname == ''){
            layer.msg("Nickname cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerNickName").focus();
            return;
        }
        if(password == null || password == ''){
            layer.msg("Password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerPassword").focus();
            return;
        }
        if(confirmPassword == null || confirmPassword == ''){
            layer.msg("Confirm password can not be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerConfirmPassword").focus();
            return;
        }
        if(confirmPassword!=password){
            layer.msg("Confirmed password must be the same as original password！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#registerConfirmPassword").focus();
            return;
        }
        var data = {'username':username,'nickname':nickname,'password':password};
        $.ajax({
            url: '/signup',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // The disable button prevents duplicate submissions
                $("#register_submit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == 200) {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    window.location.href = "/login.html"
                }else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#register_submit").removeAttr("disabled");

            },
            complete: function () {
                $("#register_submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#register_submit").removeAttr("disabled");
            }
        });
    });
</script>
</body>
</html>