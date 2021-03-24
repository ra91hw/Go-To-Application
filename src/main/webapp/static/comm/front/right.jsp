<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Front page right end page -->
<aside class="r_box" >

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

    <div class="hothub">
        <h2><i class="fa fa-fire"> Popular Album List</i></h2>
        <ul>
            <c:forEach var="likeTopAlbumVo" items="${likeTopList}">
                <li><i><a href="/album/piclist.html?id=${likeTopAlbumVo.id}"><img src="${likeTopAlbumVo.cover}"></a></i>
                    <h3><a href="/album/piclist.html?id=${likeTopAlbumVo.id}">${likeTopAlbumVo.title}</a></h3>
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
        <h2><i class="fa fa-link"></i> Links</h2>
        <ul class="news">
            <c:forEach var="linkVo" items="${linkList}">
                <li>
                    <a href="${linkVo.link}">${linkVo.title}</a>
                </li>
            </c:forEach>
        </ul>
    </div>

</aside>
