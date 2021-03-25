<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <meta charset="gbk">
    <title>${blog.title}</title>
    <meta name="keywords" content="Blog details"/>
    <meta name="description" content="Blog details"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/emoji/css/jquery.mCustomScrollbar.min.css">
    <link rel="stylesheet" href="/static/emoji/css/jquery.emoji.css">
    <link rel="stylesheet" href="/static/css/say.css">
    <%@include file="/static/comm/front/taglib.jsp" %>
    <script src="/static/emoji/js/jquery.mCustomScrollbar.min.js"></script>
    <script src="/static/emoji/js/jquery.emoji.js"></script>
    <script src="/static/emoji/js/emoji.list.js"></script>
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article>
    <div class="location" style="">
        <i class="fa fa-home"></i>
        <a href="/index.html">Home</a> >
        <a href="/blog.html?type=${blog.category.father.id}">${blog.category.father.name}</a> >>
        <a href="/blog.html?type=${blog.category.id}">${blog.category.name}</a> >>
        <span>${blog.title}</span>
    </div>
    <main>
        <div class="infosbox">
            <div class="newsview">
                <h3 class="news_title">${blog.title}</h3>
                <div class="bloginfo">
                    <ul>
                        <li class="author">Author：<a href="">${blog.user.nickname}</a></li>
                        <li class="timer">Time：<fmt:formatDate value="${blog.createTime}" pattern="dd-MM-yyyy"/></li>
                        <li><i class="fa fa-heart-o"> ${blog.agreeNumber}Like</i></li>
                        <li><i class="fa fa-comment-o"> ${blog.discussNumber}Comment</i></li>
                        <li><i class="fa fa-eye"> ${blog.clickNumber}Check</i></li>
                    </ul>
                </div>
                <div class="tags">
                    <c:forEach var="tag" items="${blog.tagList}">
                        <a href="javascript:void(0)">${tag.title}</a> &nbsp;
                    </c:forEach>

                </div>
                <div class="news_about"><strong>Introduction</strong>${blog.contentTxt}
                </div>
                <div class="news_con">
                    ${blog.content}
                </div>
            </div>
            <div class="share">
                <p class="diggit">
                    <c:choose>
                        <c:when test="${blog.isAgree == 0}">
                            <a class="btn-blue" id="btn-like" data-id="${blog.id}"><i class="fa fa-heart-o"> Awesome（<span>${blog.agreeNumber}</span>)</i></a>
                        </c:when>
                        <c:otherwise>
                            <a class="not-allow"><i class="fa fa-heart-o"> Already liked（<span>${blog.agreeNumber}</span>)</i></a>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="nextinfo">
                <c:choose>
                    <c:when test="${preBlog == null}">
                        <p>Previous：<a href="javascript:void(0)">This is already the first.</a></p>
                    </c:when>
                    <c:otherwise>
                        <p>Previous：<a href="/blog/view/${preBlog.id}.html">${preBlog.title}</a></p>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${nextBlog == null}">
                        <p>Next：<a href="javascript:void(0)">This is the last one.</a></p>
                    </c:when>
                    <c:otherwise>
                        <p>Next：<a href="/blog/view/${nextBlog.id}.html">${nextBlog.title}</a></p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="news_pl">
                <h2 class="htitle">Comment</h2>
                <form action="" method="post" name="saypl" class="saypl">
                    <div class="plbox">
                        <div contenteditable="true" name="saytext" rows="6" class="saytext"
                             placeholder="Enter here to comment..."></div>
                        <div class="pl_ctrl">
                            <a href="javascript:void(0)" class="emotion"></a>
                            <button type="submit" name="pl-submit" class="pl_submit" tabindex="5" data-blog="${blog.id}" data-pid="0">Comment</button>
                        </div>
                    </div>
                </form>
                <div class="pls" style="margin-top: 10px">
                    <c:forEach var="discussVo" items="${blog.discussList}">
                        <div class="fb">
                            <img class="pl-img" src="${discussVo.disAvatar}"/>
                            <ul>
                                <p class="fbtime">
                                    <span><fmt:formatDate value="${discussVo.createTime}" pattern="HH:mm:ss dd-MM-yyyy"/></span>
                                    <strong class="nickname">${discussVo.disNickname}</strong>
                                </p>
                                <p class="fbinfo">
                                    <c:if test="${discussVo.disType==1}">
                                        <span class="label label-info" style="margin-right: 10px">#Reply【${discussVo.beReplyNickname}】</span>
                                    </c:if>
                                        ${discussVo.content}
                                    <span class="reply" data-blog="${blog.id}" data-discuss="${discussVo.id}"><i class="fa fa-reply"></i></span>
                                </p>
                            </ul>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
    <%@include file="/static/comm/front/right.jsp" %>
</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">
    $(".saytext").emoji({
        addlocation: '.plbox',
        showTab: true,
        animation: 'fade',
        basePath: '/static/js/emoji/img',
        icons: emojiLists
    });

    $(".saytext").emojiParse({
        icons: emojiLists
    });

    // Bind events, new comment reply function
    $(document).on('click','.reply',function(){

        var fb = $(this).parents('.fb');
        // The person to whom the reply is made
        var beReplyNickname = fb.find('.nickname').text();
        var blogId = $(this).attr('data-blog');
        var pid = $(this).attr('data-discuss');
        $('.pls .saypl').remove();  // Move it out to avoid duplicate additions.
        var plcom = $('<form action="" method="post" name="saypl" class="saypl">\n' +
            '                        <div class="plbox" style="margin-left: 40px;">\n' +
            '                            <div contenteditable="true" name="saytext" rows="6" class="saytext"\n' +
            '                                 placeholder="#reply'+beReplyNickname+'"></div>\n' +
            '                            <div class="pl_ctrl">\n' +
            '                                <a href="javascript:void(0)" class="emotion"></a>\n' +
            '                                <button type="submit" name="pl-submit" class="pl_submit" tabindex="5" data-blog="'+blogId+'" data-pid="'+pid+'" data-beReplyNickname="'+beReplyNickname+'">Comment</button>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </form>');
        plcom.appendTo(fb);
    });


    // Submit comments
    $(document).on('click','.pl_submit',function (e) {
        // Prevents the form from submitting by default
        e.preventDefault();
        var o = $(this);
        var saypl = o.parents('.saypl');
        var saytext = saypl.find('.saytext');
        var content = saytext.html();
        if (content == null || content == '') {
            layer.msg("Please say something！", {icon: 0, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            saytext.focus();
            return;
        }
        if (content.length > 200) {
            layer.msg("Comment content cannot be greater than 200 characters！", {icon: 0, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            saytext.focus();
            return;
        }
        // Interact with the background
        var data = {};
        data.blogId = o.attr('data-blog');
        data.pid = o.attr('data-pid');
        data.content = content;
        var pls;
        if(data.pid == 0){
            pls = saypl.next();
        }else{
            pls = saypl.parents('.pls');
        }
        $.ajax({
            url: "/blog/discuss",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function () {

                o.attr({disabled: "disabled"});
            },
            success: function (data) {
                if (data.code == "200") {
                    var discuss = data.body;
                    var beReplyNickname = o.attr('data-beReplyNickname');
                    var reply = discuss.pid == 0 ? discuss.content : '<span class="label label-info" style="margin-right: 10px">#reply【'+beReplyNickname+'】</span>' + discuss.content;
                    var fbDiv  = $('<div class="fb">'+
                        '<img class="pl-img" src="'+discuss.user.avatar+'" />' +
                        '<ul>' +
                        '<p class="fbtime"><span>'+discuss.createTime+'</span><strong class="nickname">'+discuss.user.nickname+'</strong></p>' +
                        '<p class="fbinfo">' + reply +
                        '<span class="reply" data-blog="'+discuss.blogId+'" data-discuss="'+discuss.id+'"><i class="fa fa-reply"></i></span></p>' +
                        '</ul>' +
                        '</div>');
                    var msg = discuss.pid == 0 ? 'Comment' : 'Reply';
                    layer.msg(msg + 'Comment successful！', {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    //Put the new element in the first
                    var fb0 = pls.find('.fb')[0];
                    if(fb0 == null){
                        fbDiv.appendTo(pls);
                    }else{
                        fbDiv.insertBefore(fb0);
                    }
                    saytext.html('');
                }else if(data.code == 403){
                    $('#loginModal').modal('show');
                }else{
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                o.removeAttr("disabled");
            },
            complete: function () {
                o.removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 2, time: 2000})
            }
        });
    });



    // Submit a thumb up
    $("#btn-like").click(function (e) {

        //Interacting with the background
        var like = $(this);
        var data = {};
        data.blogId = like.attr('data-id');
        $.ajax({
            url: "/blog/like",
            type: "POST",
            dataType: "JSON",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (data) {
                if (data.code == "200") {
                    layer.msg(data.body, {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    like.attr('class','not-allow');
                    like.find('i').attr('class','fa fa-heart');
                    like.unbind('click');
                    like.find('i').html(' You already liked it（<span>'+(parseInt(like.find('span').text()+1))+'）');
                }else if(data.code == 403){
                    $('#loginModal').modal('show');
                }else{
                    layer.msg(data.body, {icon: 5, time: 2000, shift: 6, shade: [0.5, '#393D49']});
                }
                $("#pl-submit").removeAttr("disabled");
            },
            complete: function () {
                $("#pl-submit").removeAttr("disabled");
            },
            error: function (data) {
                layer.msg(data.body, {icon: 2, time: 2000})
            }
        });
    });


</script>
</body>
</html>
