<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>blog</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
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
        Blog management
        <small>Blog management</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Blog management</a></li>
        <li class="active">Blog management</li>
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
                      <input type="text" class="form-control"  placeholder="Title name" id="title" autocomplete="off">
                    </div>
                    <div class="col-sm-2">
                      <select class="form-control" id="status" name="status" autocomplete="off">
                        <option value="">-- Please select status --</option>
                        <option value="0">Waiting for audit</option>
                        <option value="1">Pass</option>
                        <option value="2">Pass failed</option>
                      </select>
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
              </div>
              <table id="blogTable"></table>
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
<!-- Bootstrap-table -->
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript">

    $(function () {
      //Initialize the table
        var oTable = new TableInit();
        oTable.Init();

      //2. Initialize the click event of the Button
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();


    });

    var TableInit = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#blogTable').bootstrapTable({
                url: "/admin/blog/list",
                method: 'post',
                toolbar: '#toolbar',
                striped: true,
                cache: false,
                pagination: true,
                sortable: true,
                sortName: "create_time",
                sortOrder: "desc",
                queryParams: oTableInit.queryParams,
                queryParamsType: 'limit',
                sidePagination: "server",
                pageNumber: 1,
                pageSize: 10,
                pageList: [10, 30, 50, 100, 'ALL'],
                //search: true,
                //strictSearch: true,
                showColumns: true,
                showRefresh: true,
                minimumCountColumns: 2,
                clickToSelect: true,
                uniqueId: "id",
                showToggle: true,
                showPaginationSwitch: true,
                cardView: false,
                detailView: false,
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                showExport: false,
                columns: [
                    {checkbox: true},
                    {field: 'id', title: 'id'},
                    {field: 'title', title: 'title'},
                    {field: 'cover', title: 'cover',formatter:function (value,row,index) {
                            return html = '<img width="100px" height="50px" src="'+value+'">';
                        }},
                    {field: 'status', title: 'status',formatter:function (value,row,index) {
                            var html = '';
                            if(row.status==0){
                                html = '<span class="label label-default">Waiting for Audit</span>';
                            }else if(row.status == 1){
                                html = '<span class="label label-success">Pass</span>';
                            }else{
                                html = '<span class="label label-danger">Pass failed</span>';
                            }
                            return html;
                        }},
                    {field: 'createTime', title: 'time'},
                    {
                        field: 'operate',
                        title: 'operate',
                        width: '200px',
                        events: {
                            'click .remove': function(e, value, row, index) {
                                remove(row.id);
                            },
                            'click .pass': function(e, value, row, index) {
                                audit(row.id,1);
                            },
                            'click .unpass': function(e, value, row, index) {
                                audit(row.id,2);
                            },
                        },
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-xs">',
                                '<a href="/admin/blog/edit?id='+row.id+'" class="edit btn btn-info"><i class="fa fa-edit">Modify</i></a>',
                                '<a href="javascript:void(0);"  class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></a>',
                                '<a type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" id="audit"><span class="caret"></span>Manage</a>',
                                '<ul class="dropdown-menu" style="right:0"> <li><a href="javascript:void(0)" class="pass">Pass</a></li> <li><a href="javascript:void(0)" class="unpass">Pass failed</a></li> </ul>',
                                '</div>',
                            ].join('');
                        }
                    },
                ],
            });
        };


        oTableInit.queryParams = function (params) {

            var temp = {
                limit: params.limit,
                start: params.offset,
                sort: params.sort,
                order: params.order,
                search: params.search,
                status: $("#status").val(),
                title: $("#title").val(),
            };
            return temp;
        };
        return oTableInit;
    };

    var ButtonInit = function () {
        var oInit = new Object();
        var postdata = {};

        oInit.Init = function () {
            $("#btn_search").click(function () {
                $('#blogTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };

    function remove(id) {


        var index = layer.confirm();
        layer.confirm('Data cannot be recovered from delete operation. Are you sure you want to delete？', {
            btn: ['Yes', 'No']
        }, function () {
            var data={"id":id};
            $.ajax({
                url: "/admin/blog/delete",
                type: "POST",
                dataType: "JSON",
                contentType: "application/json",
                data: JSON.stringify(data),
                beforeSend: function () {

                    $(".remove").attr({disabled: "disabled"});
                },
                success: function (data) {
                    if (data.code == "200") {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        $('#blogTable').bootstrapTable(('refresh'));
                    } else {
                        layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                        $(".remove").removeAttr("disabled");
                    }
                },
                complete: function () {
                    layer.close(index);
                    $(".remove").removeAttr("disabled");
                },
                error: function (data) {
                    layer.msg(data.body, {icon: 5, time: 2000})
                }
            });
        });
    }


    function audit(id,status) {

        var data = {"id":id,"status":status};
        $.ajax({
            url: "/admin/blog/audit",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                $("#audit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#blogTable').bootstrapTable(('refresh'));
                }else if(data.code == "403"){
                    $("#verifyCodeUrl").attr('src',"/captcha.jpg?t="+$.now());
                    $("#loginModal").modal("show");
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#audit").removeAttr("disabled");
            },
            complete: function () {
                $("#audit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000});
                $("#audit").removeAttr("disabled");
            }
        });
    }
</script>
</body>
</html>
