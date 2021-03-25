<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Edit the announcement</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/static/comm/admin/taglib.jsp" %>
  <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" src="${basePath}/static/plugins/ueditor/ueditor.all.js"></script>
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
        Announcement Management
        <small>Announcement</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Announcement Management</a></li>
        <li class="active">Announcement</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
              <form role="form" action="/notice/post" method="post" enctype="multipart/form-data" id="notice_form">
                <div class="form-group">
                  <input type="text" class="form-control" id="id" name="id" value="${notice.id}" style="display: none">
                </div>
                <div class="form-group">
                  <label for="title">Title</label>
                  <input type="text" class="form-control" id="title" name="title" placeholder="Please enter the title of the announcement" value="${notice.title}">
                </div>

                <div class="form-group">
                  <label for="editor">Body</label>
                  <!-- The container that loads the editor -->
                  <textarea id="editor" name="content" ></textarea>
                  <textarea id="content" style="display: none" >${notice.content}</textarea>
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
<!-- /wrapper -->

<div class="modal fade user-select" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
  <div class="modal-dialog" role="document" style="max-width: 420px;margin-top: 100px">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="loginModalLabel">Administrator login</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="loginModalUserNmae">Username</label>
          <input type="text" class="form-control" id="loginModalUserNmae" placeholder="Please enter a user name" autofocus
                 maxlength="15" autocomplete="off" required>
        </div>
        <div class="form-group">
          <label for="loginModalUserPwd">Password</label>
          <input type="password" class="form-control" id="loginModalUserPwd" placeholder="Please enter your password"
                 maxlength="18" autocomplete="off" required>
        </div>
        <div class="form-group ">
          <label class="control-label" for="loginModalVerifyCode">Verification code</label>
          <div class="input-group">
            <input class="form-control" id="loginModalVerifyCode"  type="text" placeholder="Please enter the verification code">
            <span class="input-group-addon"><img id="verifyCodeUrl" src="" height="30px" width="100px" alt="Click to refresh" onclick="refresh()"></span>
          </div>
        </div>
        <div class="form-group ">
          <label>
            <input type="checkbox" name="rememberMe" value="1" id="rememberMe" checked="checked"> Remember me
          </label>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Delete</button>
        <button type="button" class="btn btn-primary" onclick="login4Admin()" id="login4Admin">Login</button>
      </div>
    </div>
  </div>
</div>
<!-- Bootstrap-table -->
<script type="text/javascript" src="/static/js/admin/notice_edit.js"></script>
</body>
</html>
