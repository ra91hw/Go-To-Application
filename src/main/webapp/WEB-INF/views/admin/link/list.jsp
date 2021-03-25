<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Link Management</title>
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
                Link Management
                <small>Link Management</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Link Management</a></li>
                <li class="active">Link Management</li>
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
                                            <input type="text" class="form-control" placeholder="Please enter Friendly Link name" id="title"
                                                   autocomplete="off">
                                        </div>
                                        <div class="col-sm-2">
                                            <button type="button" class="btn btn-default" id="btn_search">
                                                <span class="fa fa-search" aria-hidden="true"></span>search
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div id="toolbar">
                                <a data-toggle="modal" data-target="#linkEditModal" class="btn btn-primary btn-sm"
                                   id="add"><i
                                        class="fa fa-plus">Add</i></a>
                            </div>
                            <table id="linkTable"></table>
                        </div>
                    </div>

                </div>
                <!-- /.col -->
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
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
</div>
<!-- /wrapper -->

<!-- -->
<div class="modal fade" id="linkEditModal" tabindex="-1" role="dialog" aria-labelledby="linkEditModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="modelLabel_edit">
                    <i class="fa fa-edit">Edit link</i>
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="hidden" class="form-control" id="id_edit"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Title</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="title_edit" autocomplete="off" placeholder="Please enter a link title"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">link</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="link_edit" autocomplete="off" placeholder="Please enter a link" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><i class="fa fa-close">Close</i></button>
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="save()" id="save"><i class="fa fa-save">Submit</i>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- Bootstrap-table -->
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript">


    $(function () {

        var oTable = new TableInit();
        oTable.Init();

        var oButtonInit = new ButtonInit();
        oButtonInit.Init();


    });

    var TableInit = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#linkTable').bootstrapTable({
                url: "/admin/link/list",
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
                showExport: true,
                exportDataType: "basic",
                columns: [
                    {checkbox: true},
                    {field: 'id', title: 'id',visible: false},
                    {field: 'title', title: 'link',formatter:function (value,row,index) {
                            return '<a href="'+row.link+'" target="_blank"><span style="word-break: break-all"> '+row.title+'</span></a>'
                        }},
                    {field: 'createTime', title: 'createTime', width: '150px'},
                    {
                        field: 'operation',
                        title: 'operation',
                        width: '280px',
                        events: {
                            'click .edit': function (e, value, row, index) {
                                $("#id_edit").val(row.id);
                                $("#title_edit").val(row.title);
                                $("#link_edit").val(row.link);
                                $('#linkEditModal').modal('show');
                            },
                            'click .remove': function (e, value, row, index) {
                                remove(row.id);
                            },
                        },
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-xs">',
                                '<button class="edit btn btn-success"><i class="fa fa-edit">Modify</i></button>',
                                '<button class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></button>',
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
                $('#linkTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };

    function save() {

        var id = $("#id_edit").val();
        var title = $("#title_edit").val();
        var link = $.trim($("#link_edit").val());
        if (title == "" || title == null) {
            layer.msg("Please enter a link title！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#title_edit").focus();
            return;
        }
        if (link == "" || link == null) {
            layer.msg("Please enter a link！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#link_edit").focus();
            return;
        }
        var data = {};
        data.title = title;
        data.link = link;
        var url = "/admin/link/save";
        if (id != null && id != "") {
            data.id = id;
            url = "/admin/link/update";
        }

        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                $(".edit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#linkTable').bootstrapTable(('refresh'));
                } else if (data.code == "403") {
                    $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
                    $("#loginModal").modal("show");
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $(".edit").attr({disabled: "disabled"});
            },
            complete: function () {
                $(".edit").attr({disabled: "disabled"});
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000})
                $(".edit").attr({disabled: "disabled"});
            }
        });

    }

    function remove(id) {
        var index = layer.confirm();
        layer.confirm('Are you sure to delete it？', {
            btn: ['Yes', 'No']
        }, function (index) {
            layer.close(index);
            var data = {"id": id};
            $.ajax({
                url: "/admin/link/remove",
                type: "POST",
                dataType: "JSON",
                contentType: "application/json",
                data: JSON.stringify(data),
                beforeSend: function () {
                    $("#remove").attr({disabled: "disabled"});
                },
                success: function (data) {
                    if (data.code == "200") {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        $('#linkTable').bootstrapTable(('refresh'));
                    } else if (data.code == "403") {
                        $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
                        $("#loginModal").modal("show");
                    } else {
                        layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                        $("#remove").removeAttr("disabled");
                    }
                },
                complete: function () {
                    $("#remove").removeAttr("disabled");
                },
                error: function (data) {
                    layer.msg(data.body, {icon: 5, time: 2000})
                }
            });
        });

    }

</script>
</body>
</html>
