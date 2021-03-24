$(function () {

    //Initialize the table
    var oTable = new TableInit();
    oTable.Init();

    // Initialize the click event of the Button
    var oButtonInit = new ButtonInit();
    oButtonInit.Init();


});

var TableInit = function () {
    var oTableInit = new Object();
    //Initialize Table
    oTableInit.Init = function () {
        $('#noticeTable').bootstrapTable({
            //The ones with * must be configured for paging
            url: "/admin/notice/list",         // request background url (*)
            method: 'post',                      // request method (*)
            toolbar: '#toolbar',                // which container to use for the tool button
            striped: true,                      // Whether to display line spacing colors
            cache: false,                       // The default is true, so in general you need to set this property (*).
            pagination: true,                   // Display pagination (*)
            sortable: true,                     // whether sorting is enabled
            sortName:"create_time",
            sortOrder: "desc",
            queryParams: oTableInit.queryParams,// pass parameters (*)
            queryParamsType: 'limit',           //imit or ''
            sidePagination: "server",           //paging: client paging, server paging (*）
            pageNumber:1,                       //PageNumber :1
            pageSize:20,                       //Number of rows per page (*)
            pageList: [10, 30, 50, 100,'ALL'],        //The number of rows per page available (*)
            showColumns: true,                  //Show all columns
            showRefresh: true,                  //Whether to display the refresh button
            minimumCountColumns: 2,             //Minimum number of columns allowed
            clickToSelect: true,                //Enable clicktoSelect rows
            uniqueId: "id",                     //Unique identification of each row, usually primary key column
            showToggle:true,                    //Show the toggle button between detail view and list view
            showPaginationSwitch:true,          // display the data selection box
            cardView: false,                    //Whether to display verbose view
            detailView: false,                   // Whether to display parent-child tables
            contentType: "application/x-www-form-urlencoded;charset=UTF-8", //Resolve the POST submission problem
            showExport: true,                     //Show the export
            exportDataType: "basic",              //basic', 'all', 'selected'. Indicates whether the exported schema is the current page, all data, or selected data.
            columns: [
                {checkbox: true},
                {field: 'id', title: 'id'},
                {field: 'title', title: 'title',formatter:function (value,row,index) {
                        return '<a href="/admin/notice/view?id=' + row.id + '" target="_blank">' + row.title + '</a>';
                    }},
                {field: 'createTime', title: 'createTime'},
                {
                    field: 'operator',
                    title: 'operator',
                    width:'250px',
                    events:{
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
                    formatter:function (value,row,index) {
                        return [
                            '<div class="btn-group btn-group-xs">',
                            '<a class="btn btn-success" href="/admin/notice/edit?id='+row.id+'"><i class="fa fa-edit">Modify</i></a>',
                            '<button class="remove btn btn-danger"><i class="fa fa-remove">Delete</i></button>',
                            '</div>',
                        ].join('');
                    }},
            ],
        });
    };

    //Get query parameters
    oTableInit.queryParams = function (params) {
        // Special Note:
        // If queryParamsType=limit, params contains {limit, offset, search, sort, order}
        // If queryParamsType!=limit, params contains {pageSize, pageNumber, searchText, sortName, sortOrder}
        var temp = {   //The name of the key here and the variable name of the controller must be the same. If you change here, the controller also needs to be changed to the same c
            limit: params.limit,   //Page size
            start:params.offset, //page number
            sort: params.sort,	//Sort column name
            order:params.order,	//Sort by
            search:params.search,//Search box parameters
            title:$("#title").val(),
            status:$("#status").val(),
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
            $('#noticeTable').bootstrapTable(('refresh'));
        })
    };
    return oInit;
};



function remove(id) {

    layer.confirm('Are you sure to delete it？', {
        btn : [ 'Yes', 'No' ]//Button
    }, function() {
        var data = {"id":id};
        $.ajax({
            url: "/admin/notice/remove",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                $("#remove").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.message, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    $('#noticeTable').bootstrapTable(('refresh'));
                } else {
                    layer.msg(data.message, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                    $("#remove").removeAttr("disabled");
                }
            },
            complete: function () {
                layer.close(index);
                $("#remove").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.message, {icon: 5, time: 2000})
            }
        });
    });
}