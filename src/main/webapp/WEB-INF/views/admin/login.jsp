<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Backstage management</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%@include file="/static/comm/admin/taglib.jsp" %>
    <style type="text/css">
        .login-box-body .form-control-feedback{
            left: 0;
        }

        .login-box-body input{
            padding-left: 30px;
        }

        .login-box-body .input-group-addon{
            padding: 0;
            border-radius: 0;
        }
    </style>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <b>GO-TO Backstage management</b>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>

        <form action="/admin/login" method="post" id="admin_login_form">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="username" id="username" autocomplete="off">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="password" id="password" autocomplete="new-password">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" id="login4Admin">Login</button>
                </div>
                <!-- /.col -->
            </div>
        </form>
    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
<script type="text/javascript">

    $("#admin_login_form").submit(function (e) {

        e.preventDefault();
        var username = $("#username").val();
        var password = $("#password").val();
        if (username == "" || username == null) {
            layer.msg("The user name cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#username").focus();
            return;
        }
        if (password == "" || password == null) {
            layer.msg("The password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#password").focus();
            return;
        }

        var data = {"username":username,"password":password}
        $.ajax({
            url: "/admin/login",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {

                $("#login4Admin").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    location.href = "/admin/index";
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                    $("#login4Admin").removeAttr("disabled");
                }
            },
            complete: function () {
                $("#login4Admin").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#login4Admin").removeAttr("disabled");
            }
        });

    });

</script>

</body>
</html>
