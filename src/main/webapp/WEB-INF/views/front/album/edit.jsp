<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
    <meta charset="gbk">
    <title>Post My Blog</title>
    <meta name="keywords" content="Post My Blog"/>
    <meta name="description" content="Post My Blog"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="/static/comm/front/taglib.jsp" %>
    <link rel="stylesheet" href="/static/css/bootstrap-fileinput.css">
    <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/static/js/bootstrap-fileinput.js"></script>
    <style type="text/css">
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
<article>
    <div class="location" style="">
        <i class="fa fa-home"></i>
        <a href="/index.html">Home</a> >>
        <span>Post My Blog</span>
    </div>
    <main>
        <div class="infosbox">

            <div class="article_box" style="padding: 0 30px">
                <h2 class="htitle">Post My Blog</h2>
                <div class="alert alert-danger alert-dismissable" style="margin-top: 20px">
                    <button type="button" class="close" data-dismiss="alert"
                            aria-hidden="true">
                        &times;
                    </button>
                    Please be civilized, abide by relevant laws, and build a harmonious network.
                </div>
                <form role="form" action="/admin/blog/save" method="post" enctype="multipart/form-data" id="blog_form">
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="id" name="id" value="${blog.id}">
                        <input type="hidden" class="form-control" id="cid" name="cid" value="${blog.categoryId}">
                    </div>
                    <div class="form-group">
                        <label for="pid">Blog Categories</label>
                        <select class="form-control" id="pid" name="pid">
                            <c:forEach var="p" items="${fatherList}">
                                <c:choose>
                                    <c:when test="${p.id == blog.pid}">
                                        <option value="${p.id}" selected>${p.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${p.id}">${p.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="categoryId">Blog</label>
                        <select class="form-control" id="categoryId" name="categoryId">
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="title">Blog Title</label>
                        <input type="text" class="form-control" id="title" name="title" placeholder="Please enter blog title"
                               value="${blog.title}">
                    </div>
                    <div class="form-group">
                        <label for="banner">Blog cover: 750 x 300px</label>
                        <div id="banner" style="display: block">
                            <div class="fileinput fileinput-new" data-provides="fileinput"
                                 id="uploadImageDiv">
                                <div class="fileinput-new thumbnail">
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="min-width: 750px; min-height: 300px;"></div>
                                <div>
                                                <span class="btn default btn-file">
                                                    <span class="fileinput-new fileinput-add">Choose Photo</span>
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
                    <div class="form-group">
                        <label for="editor">Blog content</label>

                        <textarea id="editor" name="content"></textarea>
                        <textarea id="article" style="display: none">${blog.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="tags">Blog Tag</label>
                        <div id="tags">
                            <c:forEach var="tag" items="${alltags}">
                                <label class="checkbox-inline" style="margin: 0px;padding: 0 20px">
                                    <input type="checkbox" name="tags" value="${tag.id}" <c:if test="${tag.checked==1}"> checked="checked"</c:if> /> ${tag.title}
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-info" id="btn-post">
                            <i class="fa fa-save">Post</i>
                        </button>
                        <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);">
                            <i class="fa fa-reply"></i>Delete
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </main>
    <%@include file="/static/comm/front/right.jsp" %>
</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">

    var content = $("#article").text();
    var ue = UE.getEditor('editor', {
        toolbars: [
            ['source', 'undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'simpleupload', 'insertimage']
        ],
        autoHeightEnabled: true,
        autoFloatEnabled: true
    });

    ue.ready(function () {
        ue.setHeight(500);
        ue.setContent(content);
    });

    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function (action) {
        if (action == 'uploadimage' || action == 'uploadfile') {
            return '/ueditorUpload/1';
        } else {
            return this._bkGetActionUrl.call(this, action);
        }
    };



    function getByPid(pid) {

        var cid = $('#cid').val();
        $.get("/category/getByPid", {"pid": pid}, function (result) {
            $("#categoryId").empty();
            $.each(result.body, function (index, item) {
                if(item.id == cid){
                    $("#categoryId").append("<option value='" + item.id + "' selected>" + item.name + "</option>");
                }else{
                    $("#categoryId").append("<option value='" + item.id + "'>" + item.name + "</option>");
                }
            });
        });
    }

    $(function () {

        var id = $('#id').val();
        var first = $("#pid option:first").val();
        if(id != null){
            first = $('#pid').val();
        }
        getByPid(first);


        $('#pid').change(function () {
            var pid = $('#pid').val();
            getByPid(pid);
        });

        $("#blog_form").submit(function (e) {

            var form = new FormData(document.getElementById("blog_form"));
            e.preventDefault();
            var id = $("#id").val();
            var title = $("#title").val();
            var fileInput = $('#file').get(0).files[0];
            var content = ue.getContent();
            var contentTxt = ue.getContentTxt();
            if (title == "" || title == null) {
                layer.msg("Please enter your blog title！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#title").focus();
                return;
            }

            if ((id == null || id == '') && !fileInput) {
                layer.msg("Please select a picture！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                return;
            }

            if (content == "" || content == null) {
                layer.msg("Please enter blog content！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                return;
            }

            form.append("content", content);
            form.append("contentTxt", contentTxt);

            var url = '';
            if (id == null || id == "") {
                url = "/blog/save";
            } else {
                url = "/blog/update";
            }
            $.ajax({
                url: url,
                type: "post",
                data: form,
                processData: false,
                contentType: false,
                success: function (data) {
                    if (data.code == 200) {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        window.location.href = "/user/blogs.html";
                    }
                },
                error: function (e) {
                    layer.msg("Save failed, network exception！", {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                }
            });
        });
    });
</script>
</body>
</html>
