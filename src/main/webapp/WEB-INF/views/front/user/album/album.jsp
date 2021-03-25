<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>My photo album</title>
  <%@include file="/static/comm/front/taglib.jsp" %>
  <link rel="stylesheet" href="/static/css/user-center.css">
  <link rel="stylesheet" href="/static/css/bootstrap-table.min.css">
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article class="user-center">
  <div class="location" style="">
    <i class="fa fa-home"></i>
    <a href="/index.html">Home</a>
    <span>My album </span>
  </div>
  <%@include file="/static/comm/front/left.jsp"%>
  <div class="rbox">
      <div class="whitebg bloglist">
        <div class="box-body">
          <div id="toolbar">
            <a href="/user/album/edit.html" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>Add</a>
          </div>
          <table id="albumTable"></table>
        </div>
      </div>
  </div>

</article>
<%@include file="/static/comm/front/footer.jsp" %>
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
            $('#albumTable').bootstrapTable({

                url: "/user/album",
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
                showExport: false,
                columns: [
                    {checkbox: true},
                    {field: 'id', title: 'id',visible: false},
                    {field: 'title', title: 'title'},
                    {field: 'category.name', title: 'category',formatter:function (value,row,index) {
                            return html = '<label class="label label-info">'+value+'</label>';
                        }},
                    {field: 'agreeNumber', title: 'like'},
                    {field: 'discussNumber', title: 'comments'},
                    {field: 'clickNumber', title: 'visit'},
                    {field: 'status', title: 'status',formatter:function (value,row,index) {
                            var html = '';
                            if(row.status==0){
                                html = '<span class="label label-success">public</span>';
                            }else{
                                html = '<span class="label label-default">private</span>';
                            }
                            return html;
                        }},
                    {field: 'createTime', title: 'createTime'},
                    {
                        field: 'operate',
                        title: 'operate',
                        events: {
                            'click .remove': function(e, value, row, index) {
                                remove(row.id);
                            },
                        },
                        formatter: function (value, row, index) {
                            return [
                                '<div class="btn-group btn-group-xs">',
                                '<a href="/user/album/edit.html?id='+row.id+'" class="btn btn-info"><i class="fa fa-edit">Modify</i></a>',
                                '<a href="/user/album/piclist.html?id='+row.id+'" class="view btn btn-success"><i class="fa fa-edit">Photos</i></a>',
                                '<button class="remove btn btn-danger" data-id="'+row.id+'" id="remove"><i class="fa fa-remove">Delete</i></button>',
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
            //Initialize the button event on the page
            $("#btn_search").click(function () {
                $('#albumTable').bootstrapTable(('refresh'));
            })
        };
        return oInit;
    };


    //Delete self-published posts
    function remove(id){

        var index = layer.confirm();
        layer.confirm('Are you sure you want to delete the album？', {
            btn: ['Yes', 'No']//Button
        }, function (index) {
            layer.close(index);
            var data = {"id": id};
            $.ajax({
                url: "/user/album/remove",
                type: "POST",
                dataType: "JSON",
                contentType: "application/json",
                data: JSON.stringify(data),
                beforeSend: function () {
                    // Disable button to prevent duplicate submission
                    $('.remove').attr({disabled: "disabled"});
                },
                success: function (data) {
                    if (data.code == "200") {
                        layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                        window.location.reload();
                    } else if (data.code == "403") {
                        $("#loginModal").modal("show");
                    } else {
                        layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                    }
                    $('.remove').removeAttr("disabled");
                },
                complete: function () {
                    $('.remove').removeAttr("disabled");
                },
                error: function (data) {
                    layer.msg(data.body, {icon: 5, time: 2000});
                    $('.remove').removeAttr("disabled");
                }
            });
        });
    }



</script>
</body>
</html>