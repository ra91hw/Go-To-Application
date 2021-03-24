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
    <div class="demo form-bg" style="padding: 100px 0;height: 100%;">
        <div class="container">
            <div class="row">
                <div class="col-md-offset-3 col-md-6">
                    <form class="form-horizontal" id="login_form" method="post">
                        <span class="heading">Sign in</span>
                        <div class="form-group">
                            <input type="text" class="form-control" id="loginUsername" placeholder="Username" autocomplete="off">
                            <i class="fa fa-user"></i>
                        </div>
                        <div class="form-group help">
                            <input type="password" class="form-control" id="loginPassword" placeholder="Password" autocomplete="new-password">
                            <i class="fa fa-lock"></i>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-default" id="login_submit">Login</button>
                        </div>
                        <a class="footing" href="/register.html">Register</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
    <script type="text/javascript">
        $('#login_form').submit(function (e) {
            e.preventDefault();
            var username = $.trim($('#loginUsername').val());
            var password = $.trim($('#loginPassword').val());
            if(username == null || username == ''){
                layer.msg("Username cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#registerUsername").focus();
                return;
            }
            if(password == null || password == ''){
                layer.msg("Password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#registerPassword").focus();
                return;
            }
            var data = {'username':username,'password':password};
            $.ajax({
                url: '/signin',
                type: "POST",
                dataType: "JSON",
                contentType: "application/json",
                data: JSON.stringify(data),
                beforeSend: function () {
                    // 禁用按钮防止重复提交
                    $("#login_submit").attr({disabled: "disabled"});
                },
                success: function (data) {
                    if (data.code == "200") {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        window.location.reload();
                    } else {
                        layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                    }
                    $("#login_submit").removeAttr("disabled");

                },
                complete: function () {
                    $("#login_submit").removeAttr("disabled");
                },
                error: function (data) {
                    layer.msg(data.body, {icon: 5, time: 2000});
                    $("#login_submit").removeAttr("disabled");
                }
            });
        })
    </script>
</body>
</html>