<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<meta charset="gbk">
<title>${album.title}GOTO</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/static/emoji/css/jquery.mCustomScrollbar.min.css">
  <link rel="stylesheet" href="/static/emoji/css/jquery.emoji.css">
  <link rel="stylesheet" href="/static/css/say.css">
  <%@include file="/static/comm/front/taglib.jsp" %>
  <script src="/static/emoji/js/jquery.mCustomScrollbar.min.js"></script>
  <script src="/static/emoji/js/jquery.emoji.js"></script>
  <script src="/static/emoji/js/emoji.list.js"></script>
  <script src="/static/js/piccontent.min.js" type="text/javascript"></script>
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article>
  <div class="location" style="">
    <i class="fa fa-home"></i>
    <a href="/index.html">HOME</a> >
    <a href="/album.html?type=${album.category.id}">${album.category.name}</a>
    <span>${album.title}</span>
  </div>
  <main>
    <div class="picsbox">
      <div class="bodymodal"></div>
      <! Play to the first image ->
      <div class="firsttop">
        <div class="firsttop_right">
          <div class="close2"> <a class="closebtn1" title="Close" href="javascript:void(0)"></a> </div>
          <div class="replay">
            <h2 id="div-end-h2"> This is already the first picture. </h2>
            <p> <a class="replaybtn1" href="javascript:;">Replay</a> </p>
          </div>
        </div>
      </div>
      <! - Play to the last image ->
      <div class="endtop">
        <div class="firsttop_right">
          <div class="close2"> <a class="closebtn2" title="Close" href="javascript:void(0)"></a> </div>
          <div class="replay">
            <h2 id="H1">This is the last picture. </h2>
            <p> <a class="replaybtn2" href="javascript:;">Replay</a> </p>
          </div>
        </div>
      </div>
      <!--End of eject layer -->
      <!--Image effects content begins-->
      <div class="piccontext">
        <h2> ${album.title} </h2>
        <div class="source">
          <div class="source_left">
            <span><i class="fa fa-clock-o"> <fmt:formatDate value="${album.createTime}" pattern="dd-MM-yyyy"/></i></span>
            <span><i class="fa fa-heart-o"> ${album.agreeNumber}</i></span>
            <span><i class="fa fa-comment-o"> ${album.discussNumber}</i></span>
            <span><i class="fa fa-eye"> ${album.clickNumber}</i></span>
          </div>
          <div class="source_right"> <a href="javascript:;" class="list">List view</a> </div>
          <div class="source_right1"> <a href="javascript:;" class="gaoqing">HD</a> </div>
        </div>
        <!--A larger display-->
        <c:if test="${page.rows.size()>0}">
          <div class="picshow">
            <div class="picshowtop">
              <a href="#"><img src="images/1.jpg" alt="" id="pic1" curindex="0"></a>
              <a id="preArrow" href="javascript:void(0)" class="contextDiv" title="Previous">
                <span id="preArrow_A" style="display: none;"></span>
              </a>
              <a id="nextArrow" href="javascript:void(0)" class="contextDiv" title="Next">
                <span id="nextArrow_A" style="display: none;"></span>
              </a>
            </div>
            <div class="picshowtxt">
              <div class="picshowtxt_left"><span>1</span>/<i>${album.totalNumber}</i></div>
              <div class="picshowtxt_right">${album.title}</div>
            </div>
            <div class="picshowlist">
              <div class="picshowlist_mid">
                <div class="picmidleft"> <a href="javascript:void(0)" id="preArrow_B"><span class="sleft"></span></a> </div>
                <div class="picmidmid">
                  <ul>
                    <c:forEach var="image" items="${page.rows}">
                      <li> <a href="javascript:void(0);"><img src="${image.albumImage}" alt="" bigimg="${image.albumImage}" text="${album.title}" class="selectpic"></a></li>
                    </c:forEach>
                  </ul>
                </div>
                <div class="picmidright"> <a href="javascript:void(0)" id="nextArrow_B"><span class="sright"></span></a> </div>
              </div>
            </div>
          </div>

          <!--List display-->
          <div class="piclistshow">
            <ul>
              <c:forEach var="image" items="${page.rows}" varStatus="status">
                <li>
                  <div class="picimg"><img src="${image.albumImage}" alt=""></div>
                  <div class="pictxt">
                    <h3>${album.title}<span>(${status.index + 1}/${album.totalNumber})</span></h3>
                  </div>
                </li>
              </c:forEach>
            </ul>
          </div>
        </c:if>

        <c:if test="${page.rows.size()<=0}">
          <div class="empty">
            No data, go to add my album... <a class="btn btn-info btn-xs" href="/user/album/upload.html?id=${album.id}" ><i class="fa fa-upload">Upload</i></a>
          </div>
        </c:if>

      </div>
      <div class="pictext">
        <ul>
          ${album.description}
        </ul>
      </div>
      <div class="share">
        <p class="diggit">
          <c:choose>
            <c:when test="${album.isAgree == 0}">
              <a class="btn-blue" id="btn-like" data-id="${album.id}"><i class="fa fa-heart-o"> Love it（<span>${album.agreeNumber}</span>)</i></a>
            </c:when>
            <c:otherwise>
              <a class="not-allow"><i class="fa fa-heart-o"> You've already clicked on it.（<span>${album.agreeNumber}</span>)</i></a>
            </c:otherwise>
          </c:choose>
        </p>
      </div>
      <div class="nextinfo">
        <c:choose>
          <c:when test="${preAlbum == null}">
            <p>上一个：<a href="javascript:void(0)">This is already the first picture.</a></p>
          </c:when>
          <c:otherwise>
            <p>上一个：<a href="/album/piclist.html?id=${preAlbum.id}">${preAlbum.title}</a></p>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${nextAlbum == null}">
            <p>下一个：<a href="javascript:void(0)">This is the last picture.</a></p>
          </c:when>
          <c:otherwise>
            <p>下一个：<a href="/album/piclist.html?id=${nextAlbum.id}">${nextAlbum.title}</a></p>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="news_pl">
        <h2 class="htitle">Comments</h2>
        <form action="" method="post" name="saypl" class="saypl">
          <div class="plbox">
            <div contenteditable="true" name="saytext" rows="6" class="saytext"
                 placeholder="Add a pubilc comment..."></div>
            <div class="pl_ctrl">
              <a href="javascript:void(0)" class="emotion"></a>
              <button type="submit" name="pl-submit" class="pl_submit" tabindex="5" data-album="${album.id}" data-pid="0">Post</button>
            </div>
          </div>
        </form>
        <div class="pls" style="margin-top: 10px">
          <c:forEach var="discussVo" items="${album.discussList}">
            <div class="fb">
              <img class="pl-img" src="${discussVo.disAvatar}"/>
              <ul>
                <p class="fbtime">
                  <span><fmt:formatDate value="${discussVo.createTime}" pattern="HH:mm:ss dd-MM-yyyy "/></span>
                  <strong class="nickname">${discussVo.disNickname}</strong>
                </p>
                <p class="fbinfo">
                  <c:if test="${discussVo.disType==1}">
                    <span class="label label-info" style="margin-right: 10px">#reply【${discussVo.beReplyNickname}】</span>
                  </c:if>
                    ${discussVo.content}
                  <span class="reply" data-album="${album.id}" data-discuss="${discussVo.id}"><i class="fa fa-reply"></i></span>
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

    //Binding event, newly added comment reply function
    $(document).on('click','.reply',function(){

        var fb = $(this).parents('.fb');
        //Respondent
        var beReplyNickname = fb.find('.nickname').text();
        var albumId = $(this).attr('data-album');
        var pid = $(this).attr('data-discuss');
        $('.pls .saypl').remove();  //Move out to avoid repeated additions.
        var plcom = $('<form action="" method="post" name="saypl" class="saypl">\n' +
            '                        <div class="plbox" style="margin-left: 40px;">\n' +
            '                            <div contenteditable="true" name="saytext" rows="6" class="saytext"\n' +
            '                                 placeholder="#replay'+beReplyNickname+'"></div>\n' +
            '                            <div class="pl_ctrl">\n' +
            '                                <a href="javascript:void(0)" class="emotion"></a>\n' +
            '                                <button type="submit" name="pl-submit" class="pl_submit" tabindex="5" data-album="'+albumId+'" data-pid="'+pid+'" data-beReplyNickname="'+beReplyNickname+'">Comment</button>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </form>');
        plcom.appendTo(fb);
    });


    //submit comments
    $(document).on('click','.pl_submit',function (e) {
        //Prevent forms from submitting by default
        e.preventDefault();
        var o = $(this);
        var saypl = o.parents('.saypl');
        var saytext = saypl.find('.saytext');
        var content = saytext.html();
        if (content == null || content == '') {
            layer.msg("Add a pubilc comment...", {icon: 0, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            saytext.focus();
            return;
        }
        if (content.length > 200) {
            layer.msg("Comments should not be longer than 200 characters！", {icon: 0, time: 2000, shift: 6, shade: [0.5, '#393D49']});
            saytext.focus();
            return;
        }
        //Prevent forms from submitting by default
        var data = {};
        data.albumId = o.attr('data-album');
        data.pid = o.attr('data-pid');
        data.content = content;
        var pls;
        if(data.pid == 0){
            pls = saypl.next();
        }else{
            pls = saypl.parents('.pls');
        }
        $.ajax({
            url: "/album/discuss",
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
                        '<span class="reply" data-album="'+discuss.albumId+'" data-discuss="'+discuss.id+'"><i class="fa fa-reply"></i></span></p>' +
                        '</ul>' +
                        '</div>');
                    var msg = discuss.pid == 0 ? 'comment' : 'replay';
                    layer.msg(msg + 'successful！', {icon: 1, time: 2000, shade: [0.5, '#393D49']});
                    //Put the new element to the first
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



    //Submit like
    $("#btn-like").click(function (e) {

        //Interact with the background
        var like = $(this);
        var data = {};
        data.albumId = like.attr('data-id');
        $.ajax({
            url: "/album/like",
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
                    like.find('i').html('You have already clicked（<span>'+(parseInt(like.find('span').text()+1))+'）');
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
