var content = $("#content").text();
var ue = UE.getEditor('editor',{
    toolbars: [
        ['fullscreen', 'source', 'undo', 'redo', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc']
    ],
    autoHeightEnabled: true,
    autoFloatEnabled: true
});

ue.ready(function () {
    ue.setHeight(500);
    //Set the content of the editor
    ue.setContent(content);
    //Get html content, return: <p>hello</p>
    // var html = ue.getContent();
    //Get the plain text content, return: hello
    // var txt = ue.getContentTxt();
});



$(function () {
    $("#notice_form").submit(function (e) {
        var form = $(this);
        // Prevent forms from submitting by default
        e.preventDefault();
        // Parameter verification
        var id = $("#id").val().trim();
        var title = $("#title").val().trim();
        var content = ue.getContent();
        if (title == "" || title == null) {
            layer.msg("Please enter the title of the announcement！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#title").focus();
            return;
        }
        if (content == "" || content == null) {
            layer.msg("Please enter the content of the announcement！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#content").focus();
            return;
        }

        //Interact with the background
        var data = {"id":id,"title":title,"content":content};
        var url = '';
        if(id == null || id == ""){
            url = "/admin/notice/post";
        }else{
            url = "/admin/notice/update";
        }
        $.ajax({
            url: url,
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {
                // Disable button to prevent duplicate submission
                $("#btn-post").attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.message, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    location.href = "/admin/notice";
                }else {
                    layer.msg(data.message, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                    $("#btn-post").removeAttr("disabled");
                }
            },
            complete: function () {
                $("#btn-post").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.message, {icon: 5, time: 2000})
            }
        });
    });
});