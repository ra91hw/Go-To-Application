<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Personal data</title>
    <%@include file="/static/comm/front/taglib.jsp" %>
    <link rel="stylesheet" href="/static/css/bootstrap-fileinput.css">
    <script type="text/javascript" src="/static/js/bootstrap-fileinput.js"></script>
    <link rel="stylesheet" href="/static/css/user-center.css">
    <style type="text/css">
        .fileinput{
            display: block;
        }
        .fileinput-add, .fileinput-change, .fileinput-remove {
            border-radius: 3px;
            padding: 6px 12px;
            border: 1px solid transparent;
            border-color: #4cae4c;
            background-color: #5cb85c;
            color: #fff;
        }
    </style>
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article class="user-center">
    <div class="location" style="">
        <i class="fa fa-home"></i>
        <a href="/index.html">Home</a>
        <span>My account</span>
    </div>
    <%@include file="/static/comm/front/left.jsp"%>
    <div class="rbox">
        <div class="whitebg bloglist">
            <form action="" id="user-basic">
                <div class="row">

                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="username">Account</label>
                            <input type="text" class="form-control" id="username" name="username" value="${user.username}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="telphone">Telephone number</label>
                            <input type="text" class="form-control" id="telphone" name="telphone" value="${user.telphone}" placeholder="Please enter telephone number">
                        </div>
                        <div class="form-group">
                            <label for="school">Please enter the name of your city</label>
                            <input type="text" class="form-control" id="school" name="school" value="${user.school}" placeholder="Please enter the name of your city">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="nickname">Nickname</label>
                            <input type="text" class="form-control" id="nickname" name="nickname" value="${user.nickname}" placeholder="Please enter a nickname">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" class="form-control" id="email" name="email" value="${user.email}" placeholder="Please input your email">
                        </div>
                        <div class="form-group">
                            <label for="professional">Hobby</label>
                            <input type="text" class="form-control" id="professional" name="professional" value="${user.professional}" placeholder="Please enter your hobby">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="nickname">Profile picture (Best size 140 x 140px)</label>
                            <div class="fileinput fileinput-new" data-provides="fileinput" id="uploadImageDiv">
                                <div class="fileinput-new thumbnail" style="width: 150px; height: 150px;">
                                    <img src="${user.avatar==null?'/static/images/avatar.jpg':user.avatar}" alt=""/>
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="width: 150px; height: 150px;"></div>
                                <div>
                                <span class="btn default btn-file">
                                <span class="fileinput-new fileinput-add">Choose Photos</span>
                                    <span class="fileinput-exists fileinput-change">Modify</span>
                                                    <input type="file" name="file" id="file"/>
                                                </span>
                                    <span href="#" class="fileinput-exists fileinput-remove"
                                          data-dismiss="fileinput">Remove</span>
                                    <span>Please select a picture within 1M</span>
                                </div>
                            </div>
                            <div id="titleImageError" style="color: #a94442"></div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="introduce">Self introduction</label>
                            <textarea class="form-control" id="introduce" name="introduce" rows="5">${user.introduce}</textarea>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-sm btn-info"><i class="fa fa-save">&nbsp;Save</i> </button>
                        <a type="button" class="btn btn-sm btn-default" onclick="javascript:history.back(-1);">
                            <i class="fa fa-reply"></i> Return
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>

</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">


    $("#user-basic").submit(function (e) {
        var form = new FormData(document.getElementById("user-basic"));
        // Prevent forms from submitting by default
        e.preventDefault();
        //Interact with the background
        $.ajax({
            url:"/user/updateBasicInfo",
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                if(data.code==200){
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    window.location.href="/user/profile.html";
                }
            },
            error:function(e){
                layer.msg("Failed to save, the network is abnormal！", {icon: 1, time: 2000, shade: [0.5, '#393D49']});
            }
        });
    });
</script>
</body>
</html>