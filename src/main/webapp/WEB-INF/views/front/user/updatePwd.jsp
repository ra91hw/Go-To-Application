<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Change Password</title>
    <%@include file="/static/comm/front/taglib.jsp" %>
    <%@include file="/static/comm/front/taglib.jsp" %>
    <link rel="stylesheet" href="/static/css/user-center.css">

</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article class="user-center">
    <div class="location" style="">
        <i class="fa fa-home"></i>
        <a href="/index.html">Home</a>
        <span>Change Password</span>
    </div>
    <%@include file="/static/comm/front/left.jsp" %>
    <div class="rbox">
        <div class="whitebg bloglist">
            <h2 class="htitle">Change Password</h2>
            <form action="" id="updatePwd_form">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="orginPwd">Original password</label>
                            <input type="password" class="form-control" id="orginPwd" placeholder="Please enter the original password" autocomplete="new-password">
                        </div>
                        <div class="form-group">
                            <label for="newPwd">New password</label>
                            <input type="password" class="form-control" id="newPwd" placeholder="Please enter a new password" autocomplete="new-password">
                        </div>
                        <div class="form-group">
                            <label for="confirmPwd">Confirm password</label>
                            <input type="password" class="form-control" id="confirmPwd" placeholder="Please enter confirm password" autocomplete="new-password">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <button type="submit" class="btn btn-info"><i class="fa fa-save">Save</i> </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">

    $('#updatePwd_form').submit(function (e) {
        e.preventDefault();
        var orginPwd = $.trim($('#orginPwd').val());
        var newPwd = $.trim($('#newPwd').val());
        var confirmPwd = $.trim($('#confirmPwd').val());
        if(orginPwd == null || orginPwd == ''){
            layer.msg("Original password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#orginPwd").focus();
            return;
        }
        if(newPwd == null || newPwd == ''){
            layer.msg("New password cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#newPwd").focus();
            return;
        }
        if(confirmPwd == null || confirmPwd == ''){
            layer.msg("New password confirmation cannot be empty！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#confirmPwd").focus();
            return;
        }
        if(confirmPwd!=newPwd){
            layer.msg("Confirm the password must be consistent with the password！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#confirmPwd").focus();
            return;
        }
        var data = {'orginPwd':orginPwd,'newPwd':newPwd};
        $.ajax({
            url: '/user/updatePwd',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // Disable button to prevent duplicate submission
                $("#pwd_submit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    window.location.href = "/index.html";
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#pwd_submit").removeAttr("disabled");

            },
            complete: function () {
                $("#pwd_submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#pwd_submit").removeAttr("disabled");
            }
        });
    })
</script>
</body>
</html>