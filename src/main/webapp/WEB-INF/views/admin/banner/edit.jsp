<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Loops editing</title>
    <link rel="stylesheet" href="/static/css/bootstrap-fileinput.css">
    <%@include file="/static/comm/admin/taglib.jsp" %>
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
                Loop Player Management
                <small>Edit Loop</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Loop Player Management</a></li>
                <li class="active">Edit Loop</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-body">
                            <form role="form" action="/banner/post" method="post" enctype="multipart/form-data" id="banner_form">
                                <div class="form-group">
                                    <input type="text" class="form-control" id="id" name="id" value="${banner.id}"
                                           style="display: none">
                                </div>
                                <div class="form-group">
                                    <label for="title">title</label>
                                    <input style="width: 504px" type="text" class="form-control" id="title" name="title" placeholder="Please enter the title"
                                           value="${banner.title}">
                                </div>
                                <div class="form-group">
                                    <label for="title">Link</label>
                                    <input style="width: 504px" type="text" class="form-control" id="link" name="link" placeholder="Please enter the link"
                                           value="${banner.link}">
                                </div>
                                <div class="form-group">
                                    <label for="banner">Photo：750 x 300px</label>
                                    <div   id="banner" style="display: block">
                                        <div class="fileinput fileinput-new" data-provides="fileinput" id="uploadImageDiv" >
                                            <div class="fileinput-new thumbnail" style="width: 750px; height: 300px;">
                                                <img src="${banner.url==null?'/static/images/1.jpg':banner.url}" alt="" />
                                            </div>
                                            <div class="fileinput-preview fileinput-exists thumbnail" style="min-width: 750px; min-height: 300px;"></div>
                                            <div>
                                                <span class="btn default btn-file">
                                                    <span class="fileinput-new fileinput-add">Choose picture</span>
                                                    <span class="fileinput-exists fileinput-change">Modify</span>
                                                    <input type="file" name="file" id="file" />
                                                </span>
                                                <span href="#" class="fileinput-exists fileinput-remove" data-dismiss="fileinput">remove</span>
                                                <span>Please select images less than 1M</span>
                                            </div>
                                        </div>
                                        <div id="titleImageError" style="color: #a94442"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-info" id="btn-post"><i class="fa fa-save">Submit</i></button>
                                    <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);"><iv><i class="fa fa-reply">Delete</i></iv></button>
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

    $(function () {
        $("#banner_form").submit(function (e) {
            var form = new FormData(document.getElementById("banner_form"));
            // Prevents the form from submitting by default
            e.preventDefault();
            // Parameter verification
            var id = $("#id").val();
            var title = $("#title").val();
            var link = $("#link").val();
            var fileInput = $('#file').get(0).files[0];

            if (title == "" || title == null) {
                layer.msg("Please enter title！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#title").focus();
                return;
            }

            if (link == "" || link == null) {
                layer.msg("Please enter the link！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                $("#title").focus();
                return;
            }

            if((id==null||id=='')&&!fileInput){
                layer.msg("Please select a picture！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                return;
            }
            var url = '';
            if (id == null || id == "") {
                url = "/admin/banner/save";
            } else {
                url = "/admin/banner/update";
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
                        layer.msg(data.message, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        window.location.href="/admin/banner";
                    }
                },
                error:function(e){
                    layer.msg("Upload failed, network exception！", {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                }
            });
        });
    });
</script>
</body>
</html>
