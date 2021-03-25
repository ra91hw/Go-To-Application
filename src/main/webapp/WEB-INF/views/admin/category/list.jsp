<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> Blog category</title>
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
                Blog category
                <small> Blog category</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Blog category</a></li>
                <li class="active">Blog category</li>
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
                                            <input type="text" class="form-control" placeholder="Please enter a category name" id="keyword"
                                                   autocomplete="off">
                                        </div>
                                        <div class="col-sm-2">
                                            <select class="form-control" id="status" name="status" autocomplete="off">
                                                <option value="">-- Class status --</option>
                                                <option value="1">Start</option>
                                                <option value="2">Disable</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2">
                                            <button type="button" class="btn btn-default" id="btn_search">
                                                <span class="fa fa-search" aria-hidden="true"></span>Search
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="box-body">
                            <div id="toolbar">
                                <a  class="btn btn-primary btn-sm" id="add"><i class="fa fa-plus">Add</i></a>
                            </div>
                            <table id="categoryTable"></table>
                        </div>
                    </div>

                </div>
                <!-- /.col -->
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <%@include file="/static/comm/admin/footer.jsp" %>
</div>
<!-- /wrapper -->

<!-- Modify or add user modal box -->
<div class="modal fade" id="categoryEditModal" tabindex="-1" role="dialog" aria-labelledby="categoryEditModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="modelLabel_edit">
                    <i class="fa fa-edit">Category editing</i>
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <div class="col-sm-10">
                            <input type="hidden" class="form-control" id="id"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Category name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control widthx" id="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Sort</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control widthx" id="sort"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Icon</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control widthx" id="icon"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Describe</label>
                        <div class="col-sm-10">
                            <textarea class="form-control widthx" id="description"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal"><i class="fa fa-close"> Close</i></button>
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" onclick="save()" id="save"><i class="fa fa-save">Submit</i></button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>



<!-- Bootstrap-table -->
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table.min.js"></script>
<script type="text/javascript" src="/static/js/admin/lib/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript">


    $("#notice").on("mouseenter",function(){
        var tips = layer.tips('No indication that the added category is a superior category！', '#notice',{
            tips: [1, '#3595CC']
            // Four directions of upper right, lower left, direction setting through 1-4
        });
    });

    $(function () {

        var oTable = new TableInit();
        oTable.Init();

        var oButtonInit = new ButtonInit();
        oButtonInit.Init();

        $("#add").click(function () {
            $('#id').val('');
            $('#name').val('');
            $('#sort').val('');
            $('#icon').val('');
            $('#description').val('');
            $('#categoryEditModal').modal('show');
        });

    });

    var TableInit = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#categoryTable').bootstrapTable({
                url: "/admin/category/list",
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
                exportDataType: "basic",             //basic', 'all', 'selected'. Indicates whether the exported schema is the current page, all data, or selected data.
                columns: [
                    {checkbox: true},
                    {field: 'id', title: 'id'},
                    {field: 'name', title: 'name'},
                    {field: 'sort', title: 'sort'},
                    {field: 'icon', title: 'icon'},
                    {
                        field: 'status', title: 'status', formatter: function (value, row, index) {
                            if (value == 1) {
                                return '<span class="label label-success">Start</span>';
                            } else{
                                return '<span class="label label-danger">Disable</span>';
                            }
                        }
                    },
                    {field: 'createTime', title: 'createTime', width: '150px'},
                    {
                        field: 'operation',
                        title: 'operation',
                        width: '280px',
                        events: {
                            'click .edit': function (e, value, row, index) {

                                $("#id").val(row.id);
                                $("#name").val(row.name);
                                $("#sort").val(row.sort);
                                $("#icon").val(row.icon);
                                $("#description").val(row.description);

                                $('#categoryEditModal').modal('show');
                            },
                            'click .reset': function (e, value, row, index) {
                                reset(row.id);
                            },
                            'click .remove': function (e, value, row, index) {
                                remove(row.id);
                            },
                            'click .pass': function (e, value, row, index) {
                                audit(row.id, 1);
                            },
                            'click .unpass': function (e, value, row, index) {
                                audit(row.id, 2);
                            },
                        },
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-xs">',
                                '<button class="edit btn btn-success"><i class="fa fa-edit">Modify</i></button>',
                                '<button class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></button>',
                                '<button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" id="audit"><span class="caret"></span>Manage</button>',
                                '<ul class="dropdown-menu" style="right:0;left:inherit"> <li><a href="javascript:void(0)" class="pass">Start</a></li> <li><a href="javascript:void(0)" class="unpass">Disable</a></li> </ul>',
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
                name: $("#keyword").val(),
                status: $("#status").val(),
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
                $('#categoryTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };

    function save() {

        var id = $("#id").val();
        var name = $.trim($("#name").val());
        var sort = $("#sort").val();
        var icon = $("#icon").val();
        var description = $("#description").val();

        if (name == "" || name == null) {
            layer.msg("Please enter a type name！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#name").focus();
            return;
        }

        if (sort == "" || sort == null) {
            layer.msg("Please enter the order of arrangement！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#sort").focus();
            return;
        }


        var data = {};
        data.id = id;
        data.name = name;
        data.sort = sort;
        data.icon = icon;
        data.description = description;
        var url = "/admin/category/save";
        if (id != null && id != "") {
            url = "/admin/category/update";
        }
        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // Disable button prevents duplicate submissions
                $(".edit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#categoryTable').bootstrapTable(('refresh'));
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
                url: "/admin/category/remove",
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
                        $('#categoryTable').bootstrapTable(('refresh'));
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


    function audit(id, status) {

        var data = {"id": id, "status": status};
        $.ajax({
            url: "/admin/category/audit",
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
                    $('#categoryTable').bootstrapTable(('refresh'));
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
