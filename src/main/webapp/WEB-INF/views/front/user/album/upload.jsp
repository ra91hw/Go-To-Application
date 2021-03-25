<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Photos uploaded</title>
    <%@include file="/static/comm/front/taglib.jsp" %>
    <link rel="stylesheet" href="/static/css/user-center.css">
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article class="user-center">
    <div class="location" style="">
        <i class="fa fa-home"></i>
        <a href="/index.html">Home</a> >
        <a href="/user/album.html"> My Photo Album</a>
        <a href="/user/album/piclist.html?id=${album.id}">${album.title}</a> >>
        <span> Photo upload</span>
    </div>
    <%@include file="/static/comm/front/left.jsp"%>
    <div class="rbox">
        <div class="whitebg bloglist">
            <div class="row">
                <div class="col-md-12">
                    <input type="hidden" value="${album.id}" id="id" name="id"/>
                    <div id="zyupload" class="zyupload">
                    </div>
                </div>
                <div class="col-md-12">
                    <a type="button" class="btn btn-sm btn-default" onclick="javascript:history.back(-1);">
                        <i class="fa fa-reply"></i> return
                    </a>
                </div>
            </div>
        </div>
    </div>

</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">

    $("#zyupload").zyUpload({
        width            :   "100%",
        height           :   "",
        itemWidth        :   "140px",
        itemHeight       :   "115px",
        url              :   "/user/album/batchUpload",
        fileType         :   ["jpg","png","txt","js","exe"],
        fileSize         :   51200000,
        multiple         :   true,
        dragDrop         :   true,
        tailor           :   true,
        del              :   true,
        finishDel        :   false,
        // User-defined attached value
        customData       :   {},
        /* Externally obtained callback interface */
        onSelect: function(selectFiles, allFiles){    //
            console.info("The following files are currently selected：");
            console.info(selectFiles);
        },
        onDelete: function(file, files){              //
            console.info("This file is currently deleted：");
            console.info(file.name);
        },
        onSuccess: function(file, response){          // Callback method for successful file upload
            console.info("This file was uploaded successfully：");
            console.info(response);
            var res = JSON.parse(response);
            if(res.code == 200){
                $('#preview').empty();
                layer.msg(res.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                window.location.href="/user/album/piclist.html?id="+$('#id').val();
            }else{
                layer.msg(res.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            }


        },
        onFailure: function(file, response){          // Callback method for failed file upload
            console.info("This file upload failed：");
            console.info(file.name);
        },
        onComplete: function(response){           	  // Callback method for upload completion
            console.info("File upload completed");
            console.info(response);
        }
    });

    $("#album-form").submit(function (e) {
        var form = new FormData(document.getElementById("album-form"));
        // Prevent forms from submitting by default
        e.preventDefault();

        var id = $("#id").val();
        var title = $("#title").val();
        var fileInput = $('#file').get(0).files[0];
        var description = $("#description").val();

        if (title == "" || title == null) {
            layer.msg("Please enter the title of the album！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#title").focus();
            return;
        }

        if((id==null||id=='')&&!fileInput){
            layer.msg("Please select photos！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            return;
        }

        if (description == "" || description == null) {
            layer.msg("Please enter a description of the album！", {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            $("#description").focus();
            return;
        }
        var url = '';
        if (id == null || id == "") {
            url = "/user/album/save";
        } else {
            url = "/user/album/update";
        }
        //Interact with the background
        $.ajax({
            url:url,
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                if(data.code==200){
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    window.location.href="/user/album.html";
                }
            },
            error:function(e){
                layer.msg("Failed to save, the network is abnormal！", {icon: 1, time: 2000, shade: [0.5, '#393D49']});
            }
        });
    });
</script>
</body>
</html>