<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>User management</title>
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
                User management
                <small>User management</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>User management</a></li>
                <li class="active">User management</li>
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
                                            <input type="text" class="form-control" placeholder="Please enter a user name" id="username"
                                                   autocomplete="off">
                                        </div>
                                        <div class="col-sm-2">
                                            <select class="form-control" id="status" name="status" autocomplete="off">
                                                <option value="0">--Account status--</option>
                                                <option value="1">Start</option>
                                                <option value="2">Banned</option>
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
                                <a data-toggle="modal" data-target="#userEditModal" class="btn btn-primary btn-sm"
                                   id="add"><i
                                        class="fa fa-plus">Add</i></a>
                            </div>
                            <table id="userTable"></table>
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
            <b>Version</b> 1.0
        </div>
    </footer>

    <div class="control-sidebar-bg"></div>
</div>
<!-- /wrapper -->

<div class="modal fade" id="userEditModal" tabindex="-1" role="dialog" aria-labelledby="userEditModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="modelLabel_edit">
                    <i class="fa fa-edit">Edit the user</i>
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
                        <label class="col-sm-2 control-label">Role</label>
                        <div class="col-sm-10">
                            <select class="form-control" id="type_edit" name="type_edit" autocomplete="off">
                                <option value="0">--Role type--</option>
                                <option value="1" selected>Management</option>
                                <option value="2">User</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Account</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username_edit"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Nickname</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="nickname_edit"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Phone number</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="telphone_edit"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email_edit"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Attentio</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" style="padding-top: 8px"><strong>Initial password:123456</strong></p>
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
                    <input type="text" class="form-control" id="loginModalUserNmae" placeholder="Please enter your username" autofocus
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
                        <input class="form-control" id="loginModalVerifyCode" type="text" placeholder="Please enter the verification code">
                        <span class="input-group-addon"><img id="verifyCodeUrl" src="" height="30px" width="100px"
                                                             alt="Click to refresh" onclick="refresh()"></span>
                    </div>
                </div>
                <div class="form-group ">
                    <label>
                        <input type="checkbox" name="rememberMe" value="1" id="rememberMe" checked="checked">
                       Remember me
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
<script type="text/javascript">


    $(function () {

        var oTable = new TableInit();
        oTable.Init();

        var oButtonInit = new ButtonInit();
        oButtonInit.Init();

        $("#add").click(function () {
            $('#id').val('');
            $('#type_edit').val(1);
            $('#username_edit').val('');
            $('#nickname_edit').val('');
            $('#telphone_edit').val('');
            $('#email_edit').val('');
            $('#userEditModel').modal('show');
        });

    });

    var TableInit = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#userTable').bootstrapTable({
                url: "/admin/user/list",
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
                    {field: 'username', title: 'username'},
                    {field: 'avatar', title: 'avatar',formatter:function (value,row,index) {
                            var avatar = value == null ? '/static/images/avatar.jpg':value;
                            return [
                                '<img src="'+avatar+'" style="width: 80px;height: 40px;"/>',
                            ].join('');
                        }},
                    {
                        field: 'type', title: 'role', formatter: function (value, row, index) {
                            if (value == 1) {
                                return '<span class="label label-success">Management</span>';
                            } else if (value == 2) {
                                return '<span class="label label-primary">Owner</span>';
                            } else {
                                return '<span class="label label-default">Design</span>';
                            }
                        }
                    },
                    {field: 'telphone', title: 'telphone'},
                    {field: 'email', title: 'email'},
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
                                $("#id_edit").val(row.id);
                                $("#type_edit").val(row.type);
                                $("#username_edit").val(row.username);
                                $("#nickname_edit").val(row.nickname);
                                $("#telphone_edit").val(row.telphone);
                                $("#email_edit").val(row.email);
                                $('#userEditModal').modal('show');
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
                                '<button class="reset btn btn-primary"><i class="fa fa-retweet">Reset your password</i></button>',
                                '<button class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></button>',
                                '<button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" id="audit"><span class="caret"></span>Managment</button>',
                                '<ul class="dropdown-menu" style="right:0;left:inherit"> <li><a href="javascript:void(0)" class="pass">Start</a></li> <li><a href="javascript:void(0)" class="unpass">Banned</a></li> </ul>',
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
                username: $("#username").val(),
                type: $("#type").val(),
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
            //初始化页面上面的按钮事件
            $("#btn_search").click(function () {
                $('#userTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };

    function save() {

        var id = $("#id_edit").val();
        var type = $("#type_edit").val();
        var username = $.trim($("#username_edit").val());
        var nickname = $.trim($("#nickname_edit").val());
        var companyId = $("#company_edit").val();
        var level = $("#level_edit").val();
        var telphone = $("#telphone_edit").val();
        var email = $("#email_edit").val();
        if (type == "" || type == null || type == 0) {
            layer.msg("Please select a role！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#type_edit").focus();
            return;
        }
        if (username == "" || username == null) {
            layer.msg("Please enter a user name！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#username_edit").focus();
            return;
        }
        var data = {};
        data.type = type;
        data.username = username;
        data.nickname = nickname;
        data.telphone = telphone;
        data.email = email;
        var url = "/admin/user/save";
        if (id != null && id != "") {
            data.id = id;
            url = "/admin/user/update";
        }

        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // 禁用按钮防止重复提交
                $(".edit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#userTable').bootstrapTable(('refresh'));
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
                url: "/admin/user/remove",
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
                        $('#userTable').bootstrapTable(('refresh'));
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


    function audit(id, status) {

        var data = {"id": id, "status": status};
        $.ajax({
            url: "/admin/user/audit",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // 禁用按钮防止重复提交
                $("#audit").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#userTable').bootstrapTable(('refresh'));
                } else if (data.code == "403") {
                    $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
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


    function reset(id) {

        var data = {'id': id};
        $.ajax({
            url: '/admin/user/reset',
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                $(".reset").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#userTable').bootstrapTable(('refresh'));
                } else if (data.code == "403") {
                    $("#verifyCodeUrl").attr('src', "/captcha.jpg?t=" + $.now());
                    $("#loginModal").modal("show");
                } else {
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $(".reset").attr({disabled: "disabled"});
            },
            complete: function () {
                $(".reset").attr({disabled: "disabled"});
            },
            error: function (data) {
                layer.msg(data.body, {icon: 5, time: 2000})
                $(".reset").attr({disabled: "disabled"});
            }
        });

    }
</script>
</body>
</html>
