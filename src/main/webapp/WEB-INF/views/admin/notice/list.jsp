<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Announcement of the management</title>
  <%@include file="/static/comm/admin/taglib.jsp" %>
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
        Announcement of the management
        <small>Announcement of the management</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Announcement of the management</a></li>
        <li class="active">Announcement of the management</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-header">
              <div class="panel panel-default" style="margin-bottom: -10px;">
                <div class="panel-body">
                  <div class="form-group">
                    <div class="col-sm-2">
                      <input type="text" class="form-control"  placeholder="Please enter the title of the announcement" id="title" autocomplete="off">
                    </div>
                    <div class="col-sm-2">
                      <button  type="button" class="btn btn-default" id="btn_search">
                        <span class="fa fa-search" aria-hidden="true"></span>Search
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="box-body">
              <div id="toolbar">
                <a href="/admin/notice/edit" class="btn btn-primary btn-sm" target="_blank"><i class="fa fa-plus"></i>Add</a>
              </div>
              <table id="noticeTable"></table>
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
                 maxlength="18" autocomplete="new-password" required>
        </div>
        <div class="form-group ">
          <label class="control-label" for="loginModalVerifyCode">Verification code</label>
          <div class="input-group">
            <input class="form-control" id="loginModalVerifyCode"  type="text" placeholder="Please enter the verification code">
            <span class="input-group-addon"><img id="verifyCodeUrl" src="" height="30px" width="100px" alt="Click to refrsh" onclick="refresh()"></span>
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
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="/static/js/admin/notice_list.js"></script>
<script>




</script>
</body>
</html>
