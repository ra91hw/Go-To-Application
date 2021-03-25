<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Loop Play Management</title>
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
        Loop Player Management
        <small>Loop Player Management</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Loop Player Management</a></li>
        <li class="active">Loop Player Management</li>
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
                      <input type="text" class="form-control"  placeholder="Subject name" id="title" autocomplete="off">
                    </div>
                    <div class="col-sm-2">
                      <select class="form-control" id="status" name="status" autocomplete="off">
                        <option value="0">-- Please select status --</option>
                        <option value="1">Start</option>
                        <option value="2">Close</option>
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
                <a href="${webRoot}/admin/banner/edit" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>Add</a>
              </div>
              <table id="bannerTable"></table>
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
        ////Initialize the table
        var oTable = new TableInit();
        oTable.Init();

        //2. Initialize the click event of the Button
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();


    });

    var TableInit = function () {
        var oTableInit = new Object();
        //Initialize the table
        oTableInit.Init = function () {
            $('#bannerTable').bootstrapTable({
                //The ones with * must be configured for paging
                url: "/admin/banner/list",         //Request the URL of the backend (*)
                method: 'post',                      //Request method (*)
                toolbar: '#toolbar',                //Request method (*) Which container is used for the tool button
                striped: true,                      //Whether to display line spacing color
                cache: false,                       //Whether to use the cache, the default is true, so in general, you need to set this property (*)
                pagination: true,                   //Whether to display page breaks (*)
                sortable: true,                     //Whether to enable sorting
                sortName: "create_time",
                sortOrder: "desc",                   //Sort by
                queryParams: oTableInit.queryParams,//Pass parameters (*)
                queryParamsType: 'limit',
                sidePagination: "server",           //Paging mode: client client paging, server server paging (*)
                pageNumber: 1,                       //Initially load the first page, the default first page
                pageSize: 10,                       //Number of records per page (*)
                pageList: [10, 30, 50, 100, 'ALL'],        //Number of rows per page available for selection (*)

                showColumns: true,                  //Whether to show all columns
                showRefresh: true,                  //Whether to show the refresh button
                minimumCountColumns: 2,             //Minimum number of columns allowed
                clickToSelect: true,                //Whether to enable click to select rows
                //height: 500,                        //Row height, if the height property is not set, the table automatically thinks the height of the table according to the number of records
                uniqueId: "id",                     //The unique identifier of each row, generally the primary key column
                showToggle: true,                    //Whether to display the switch button between the detailed view and the list view
                showPaginationSwitch: true,          //Whether to display the number of data selection box
                cardView: false,                    //Whether to show detailed view
                detailView: false,                   //Whether to display the parent-child table
                contentType: "application/x-www-form-urlencoded;charset=UTF-8", //Solve the POST submission problem
                showExport: false,                     //Whether to show export
                // exportDataType: "basic",              //basic', 'all', 'selected'.Indicates whether the export mode is the current page, all data or selected data.
                columns: [
                    {checkbox: true},
                    {field: 'id', title: 'id'},
                    {field: 'title', title: 'title'},
                    {field: 'url', title: 'url',formatter:function (value,row,index) {
                            return html = '<img width="100px" height="50px" src="'+value+'">';
                        }},
                    {field: 'status', title: 'status',formatter:function (value,row,index) {
                            var html = '';
                            if(row.status==1){
                                html = '<span class="label label-success">Start</span>';
                            }else{
                                html = '<span class="label label-danger">Close</span>';
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
                                '<a href="/admin/banner/edit?id='+row.id+'" class="edit btn btn-info"><i class="fa fa-edit">Modify</i></a>',
                                '<a href="javascript:void(0);"  class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></a>',
                                '<a type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" id="audit"><span class="caret"></span>Manage</a>',
                                '<ul class="dropdown-menu" style="right:0"> <li><a href="javascript:void(0)" class="pass">Start</a></li> <li><a href="javascript:void(0)" class="unpass">Close</a></li> </ul>',
                                '</div>',
                            ].join('');
                        }
                    },
                ],
              // paginationHAlign:'right', //Specify the horizontal position of the paging bar. 'left' or'right'
              // paginationVAlign:'bottom', //Specify the vertical position of the paging bar. 'top' or'bottom' or'bonth'
              // paginationDetailHAlign:'left', //Specify the horizontal position of pagination details. 'left' or'right'
              // paginationPreText:'?',//Specify the icon or text of the previous page button in the pagination bar
              // paginationNextText:'?',//Specify the icon or text of the next page button in the pagination bar
            });
        };

      //Get the query parameters
        oTableInit.queryParams = function (params) {
          // Special Note:
          // If queryParamsType=limit, params contains {limit, offset, search, sort, order}
          // If queryParamsType!=limit, params contains {pageSize, pageNumber, searchText, sortName, sortOrder}
            var temp = {   //The name of the key here and the variable name of the controller must be the same. If you change here, the controller also needs to be changed to the same
                limit: params.limit,   ////Page size
                start: params.offset, //page number
                sort: params.sort,	//Page number sorting column name
                order: params.order,	//Sort by
                search: params.search,//Search box parameters
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
          //Initialize the button event on the page
            $("#btn_search").click(function () {
                $('#bannerTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };

    function remove(id) {


        var index = layer.confirm();
        layer.confirm('Data cannot be recovered from delete operation. Are you sure you want to delete？', {
            btn: ['Yes', 'No']//Button
        }, function () {
            var data={"id":id};
            $.ajax({
                url: "/admin/banner/delete",
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
                        $('#bannerTable').bootstrapTable(('refresh'));
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
            url: "/admin/banner/audit",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
              // Disable the button to prevent repeated submissions
                $("#audit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#bannerTable').bootstrapTable(('refresh'));
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
