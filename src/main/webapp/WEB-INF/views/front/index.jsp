<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HOME page-GOTO</title>
    <meta name="keywords" content="GOTO"/>
    <meta name="description" content="GOTO"/>
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
    <!--banner begin-->
    <div class="banner">
        <%--<div id="zyupload" class="zyupload">--%>
        <%--</div>--%>

        <div id="banner" class="fader">
            <c:forEach var="banner" items="${bannerList}">
                <li class="slide" ><a href="${banner.link}" target="_blank"><img src="${banner.url}"><span class="imginfo">${banner.title}</span></a></li>
            </c:forEach>
            <div class="fader_controls">
                <div class="page prev" data-target="prev">&lsaquo;</div>
                <div class="page next" data-target="next">&rsaquo;</div>
                <ul class="pager_list">
                </ul>
            </div>
        </div>
    </div>
    <!--banner end-->
    <div class="toppic">
        <div class="xtgg">
            <h2><i class="fa fa-bullhorn"></i> Announcement</h2>
            <ul class="news">
                <c:forEach var="noticeVo" items="${noticeList}">
                    <li>
                        <a href="/notice/view/${noticeVo.id}.html">${noticeVo.title}</a>
                        <span class="date"><fmt:formatDate value="${noticeVo.createTime}" pattern="dd-MM-yyyy"/></span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <main>

        <div class="news_box">
            <h2 class="htitle"><i class="fa fa-fire"> Popular Album</i></h2>
            <ul>
                <c:forEach var="hotestAlbumVo" items="${hotestAlbumList}">
                    <li><i><a href="/album/piclist.html?id=${hotestAlbumVo.id}"><img src="${hotestAlbumVo.cover}"></a></i>
                        <h3><a href="/album/piclist.html?id=${hotestAlbumVo.id}">${hotestAlbumVo.title}</a></h3>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="picbox index">
            <h2 class="htitle"><i class="fa fa-list"> Latest Album</i></h2>
            <ul>
                <c:forEach var="album" items="${latestAlbumList}">
                    <li data-scroll-reveal="enter bottom over 1s" style="width: 44.5%">
                        <a href="/album/piclist.html?id=${album.id}"><i><img src="${album.cover}"></i>
                        <div class="picinfo">
                            <h3>${album.title}（${album.totalNumber}）</h3>
                            <span><i class="fa fa-tag" style="margin: 0px;"> ${album.description}</i></span> </div>
                    </a></li>
                </c:forEach>
            </ul>
            <c:if test="${page.rows.size()<=0}">
                <div class="empty">
                    No data, go to add my album... <a class="btn btn-info btn-xs" href="/user/album/edit.html" ><i class="fa fa-edit">Add</i></a>
                </div>
            </c:if>
        </div>
    </main>
    <aside class="r_box">
        <div class="hothub">
            <h2><i class="fa fa-fire"> Like Ranking List</i></h2>
            <ul>
                <c:forEach var="lotTopAlbumVo" items="${likeTopList}">
                    <li><i><a href="/album/piclist.html?id=${lotTopAlbumVo.id}"><img src="${lotTopAlbumVo.cover}"></a></i>
                        <h3><a href="/album/piclist.html?id=${lotTopAlbumVo.id}">${lotTopAlbumVo.title}</a></h3>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="hotarticle">
            <h2><i class="fa fa-comments"> Latest Comments</i></h2>
            <ul>
                <c:forEach var="discussVo" items="${latestDiscussList}">
                    <li>
                        <i></i>
                        <a href="/album/piclist.html?id=${discussVo.albumId}">${discussVo.content}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div class="xtgg">
            <h2><i class="fa fa-link"></i>Link</h2>
            <ul class="news">
                <c:forEach var="linkVo" items="${linkList}">
                    <li>
                        <a href="${linkVo.link}">${linkVo.title}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </aside>
</article>
<%@include file="/static/comm/front/footer.jsp" %>

<script src="/static/chat/js/index.js"></script>

</body>
</html>
