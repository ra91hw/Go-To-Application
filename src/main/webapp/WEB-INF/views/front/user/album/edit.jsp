<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Photo editor</title>
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
        <span>Album Editing</span>
    </div>
    <%@include file="/static/comm/front/left.jsp"%>
    <div class="rbox">
        <div class="whitebg bloglist">
            <form action="" id="album-form">
                <div class="row">
                    <div class="form-group">
                        <input type="hidden" value="${album.id}" id="id" name="id"/>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="categoryId">Album Type</label>
                            <select class="form-control" id="categoryId" name="categoryId">
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.id}" <c:if test="${album.categoryId == category.id}">selected</c:if>>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="title">Album Title</label>
                            <input type="text" class="form-control" id="title" name="title" value="${album.title}" placeholder="Please enter the title of the album">
                        </div>
                        <div class="form-group">
                            <label for="categoryId">Is it public</label>
                            <select class="form-control" id="status" name="status">
                                <option value="0" <c:if test="${album.status == 0}">selected</c:if>>public</option>
                                <option value="1" <c:if test="${album.status == 1}">selected</c:if>>private</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="banner">size：350 x 160</label>
                            <div id="banner" style="display: block">
                                <div class="fileinput fileinput-new" data-provides="fileinput"
                                     id="uploadImageDiv">
                                    <div class="fileinput-new thumbnail" style="width: 350px; height: 160px;">

                                    </div>
                                    <div class="fileinput-preview fileinput-exists thumbnail"
                                         style="width: 350px; height: 160px;"></div>
                                    <div>
                                                <span class="btn default btn-file">
                                                    <span class="fileinput-new fileinput-add">Choose photos</span>
                                                    <span class="fileinput-exists fileinput-change">modify</span>
                                                    <input type="file" name="file" id="file"/>
                                                </span>
                                        <span href="#" class="fileinput-exists fileinput-remove"
                                              data-dismiss="fileinput">remove</span>
                                        <span>Please select images within 1M</span>
                                    </div>
                                </div>
                                <div id="titleImageError" style="color: #a94442"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="description">Photo album description</label>
                            <textarea class="form-control" id="description" name="description" rows="5">${album.description}</textarea>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-sm btn-info" id="save"><i class="fa fa-save">Save</i> </button>
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



    $("#album-form").submit(function (e) {
        var form = new FormData(document.getElementById("album-form"));
        // Prevent forms from submitting by default
        e.preventDefault();

        var id = $("#id").val();
        var title = $("#title").val();
        var fileInput = $('#file').get(0).files[0];
        var description = $("#description").val();

        if (title == "" || title == null) {
            layer.msg("Please enter the title of the album！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#title").focus();
            return;
        }

        if((id==null||id=='')&&!fileInput){
            layer.msg("Please select the picture！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            return;
        }

        if (description == "" || description == null) {
            layer.msg("Please enter a description of the album！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#description").focus();
            return;
        }
        var url = '';
        if (id == null || id == "") {
            url = "/user/album/save";
        } else {
            url = "/user/album/update";
        }
        //Interact with the background
        $.ajax({
            url:url,
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                if(data.code==200){
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    window.location.href="/user/album.html";
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