<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>blog</title>
    <link rel="stylesheet" href="/static/css/bootstrap-fileinput.css">
    <%@include file="/static/comm/admin/taglib.jsp" %>
    <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/static/js/bootstrap-fileinput.js"></script>
    <style type="text/css">
        .fileinput-add,.fileinput-change,.fileinput-remove{
            border-radius: 3px;
            padding: 6px 12px;
            border:1px solid transparent;
            border-color: #4cae4c;
            background-color: #5cb85c;
            color: #fff;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <%@include file="/static/comm/admin/header.jsp" %>
    <%@include file="/static/comm/admin/left.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Blog management
                <small>Edit blog</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Blog management</a></li>
                <li class="active">Edit blog</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <form role="form" action="/admin/blog/save" method="post" enctype="multipart/form-data" id="blog_form">
                                <div class="form-group">
                                    <div class="alert alert-danger alert-dismissable" style="margin-top: 20px">
                                        <button type="button" class="close" data-dismiss="alert"
                                                aria-hidden="true">
                                            &times;
                                        </button>
                                        You can edit the user's blog here to remove illegal content!
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="hidden" class="form-control" id="id" name="id" value="${blog.id}">
                                    <input type="hidden" class="form-control" id="cid" name="cid" value="${blog.categoryId}">
                                </div>
                                <div class="form-group">
                                    <label for="pid">Blog Category</label>
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
                                    <label for="categoryId"> Blog Category</label>
                                    <select class="form-control" id="categoryId" name="categoryId">
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="title">Blog Title</label>
                                    <input type="text" class="form-control" id="title" name="title" placeholder="Please enter the blog title"

                                           value="${blog.title}">
                                </div>
                                <div class="form-group">
                                    <label for="banner">Blog covers：750 x 300px</label>
                                    <div id="banner" style="display: block">
                                        <div class="fileinput fileinput-new" data-provides="fileinput"
                                             id="uploadImageDiv">
                                            <div class="fileinput-new thumbnail">
                                                <img src="${blog.cover==null?'/static/images/1.jpg':blog.cover}" alt=""/>
                                            </div>
                                            <div class="fileinput-preview fileinput-exists thumbnail"
                                                 style="min-width: 750px; min-height: 300px;"></div>
                                            <div>
                                                <span class="btn default btn-file">
                                                    <span class="fileinput-new fileinput-add">Choose photo</span>
                                                    <span class="fileinput-exists fileinput-change">Modify</span>
                                                    <input type="file" name="file" id="file"/>
                                                </span>
                                                <span href="#" class="fileinput-exists fileinput-remove"
                                                      data-dismiss="fileinput">Move</span>
                                                <span>Please select images less than 1M</span>
                                            </div>
                                        </div>
                                        <div id="titleImageError" style="color: #a94442"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="editor">Blog content</label>
                                    <!-- Loading the editor container -->
                                    <textarea id="editor" name="content"></textarea>
                                    <textarea id="article" style="display: none">${blog.content}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="tags">Blog tag</label>
                                    <div id="tags">
                                        <c:forEach var="tag" items="${alltags}">
                                            <label class="checkbox-inline" style="margin: 0px;padding: 0 20px">
                                                <input type="checkbox" name="tags" value="${tag.id}" <c:if test="${tag.checked==1}"> checked="checked"</c:if> /> ${tag.title}
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="categoryId">Audit</label>
                                    <select class="form-control" id="status" name="status">
                                        <option value="0" <c:if test="${blog.status==0}">selected</c:if>>Waiting for Audit</option>
                                        <option value="1" <c:if test="${blog.status==1}">selected</c:if>>Pass</option>
                                        <option value="2" <c:if test="${blog.status==2}">selected</c:if>>Pass failed</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-info" id="btn-post">
                                        <i class="fa fa-save">Release</i>
                                    </button>
                                    <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);">
                                        <i class="fa fa-reply"></i> Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
                <!-- /.col -->
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 1.0.0
        </div>
        <strong>
            <p>

            </p>
        </strong>
    </footer>
    <div class="control-sidebar-bg"></div>
</div>
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
        //Set the content of the editor
        ue.setContent(content);
    });
    //Image and file upload interface
    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function (action) {
        if (action == 'uploadimage' || action == 'uploadfile') {
            return '/admin/ueditorUpload/1';  //Change here to which Action (Controller) the picture needs to be uploaded
        } else {
            return this._bkGetActionUrl.call(this, action);
        }
    };

    function getByPid(pid) {

        var cid = $('#cid').val();
        $.get("/admin/category/getByPid", {"pid": pid}, function (result) {
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

        //Blog subcategory default
        var id = $('#id').val();
        var first = $("#pid option:first").val();
        if(id != null){
            first = $('#pid').val();
        }
        getByPid(first);

        //Blog sub-categories switch according to major categories
        $('#pid').change(function () {
            var pid = $('#pid').val();
            getByPid(pid);
        });

        $("#blog_form").submit(function (e) {

            var form = new FormData(document.getElementById("blog_form"));
            // Prevent forms from submitting by default
            e.preventDefault();
            // Parameter verification
            var id = $("#id").val();
            var title = $("#title").val();
            var fileInput = $('#file').get(0).files[0];
            var content = ue.getContent();
            var contentTxt = ue.getContentTxt();
            if (title == "" || title == null) {
                layer.msg("Please enter a blog title！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#title").focus();
                return;
            }

            if ((id == null || id == '') && !fileInput) {
                layer.msg("Please select pictures！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                return;
            }

            if (content == "" || content == null) {
                layer.msg("Please enter blog content！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                return;
            }

            form.append("content", content);
            form.append("contentTxt", contentTxt);

            //Interact with the background
            $.ajax({
                url: "/admin/blog/update",
                type: "post",
                data: form,
                processData: false,
                contentType: false,
                success: function (data) {
                    if (data.code == 200) {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        window.location.href = "/admin/blog";
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
