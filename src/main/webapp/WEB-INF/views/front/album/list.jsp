<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
<meta charset="gbk">
<title>Album list</title>
  <meta name="keywords" content="Album list- GOTO" />
  <meta name="description" content="Album list- GOTO" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <%@include file="/static/comm/front/taglib.jsp" %>
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article>
  <div class="location" style="">
    <i class="fa fa-home"></i>
    <a href="/index.html">HOME</a>
    <c:choose>
      <c:when test="${category == null}">
        <span>Photo album search</span>
      </c:when>
      <c:otherwise>
        <a href="/album.html?type=${category.id}">${category.name}</a>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="picbox">
    <c:if test="${page.rows.size()>0}">
      <ul>
        <c:forEach var="album" items="${page.rows}">
          <li data-scroll-reveal="enter bottom over 1s" ><a href="/album/piclist.html?id=${album.id}"><i><img src="${album.cover}"></i>
            <div class="picinfo">
              <h3>${album.title}（${album.totalNumber}）</h3>
              <span><i class="fa fa-tag" style="margin: 0px;"> ${album.description}</i></span> </div>
          </a></li>
        </c:forEach>
      </ul>
      <div class="pagelist">
        <c:choose>
          <c:when test="${wd==null}">
            <c:set var="wd" value=""/>
          </c:when>
          <c:otherwise>
            <c:set var="wd" value="&wd=${wd}"/>
          </c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${page.isFirst}">
            <a href="javascript:void(0);" disabled="disabled" class="disabled">HOME</a>
            <a href="javascript:void(0);" disabled="disabled" class="disabled">Previous</a>
          </c:when>
          <c:otherwise>
            <a href="${basePath}/album.html?type=${type}&pageNo=1${wd==null?'':wd}" disabled="disabled">HOME</a>
            <a href="${basePath}/album.html?type=${type}&pageNo=${page.pageNo-1}${wd==null?'':wd}">Previous</a>
          </c:otherwise>
        </c:choose>

        <c:choose>
          <c:when test="${page.totalPage<=5}">
            <c:set var="begin" value="1"/>
            <c:set var="end" value="${page.totalPage}"/>
          </c:when>
          <c:otherwise>
            <c:set var="begin" value="${page.pageNo-2}"/>
            <c:set var="end" value="${page.pageNo+2}"/>
            <c:if test="${begin<1}">
              <c:set var="begin" value="1"/>
              <c:set var="end" value="5"/>
            </c:if>
            <c:if test="${end>page.totalPage}">
              <c:set var="begin" value="${page.totalPage-4}"/>
              <c:set var="end" value="${page.totalPage}"/>
            </c:if>
          </c:otherwise>
        </c:choose>

        <c:if test="${begin>1}">
          <span>...</span>
        </c:if>

        <c:forEach begin="${begin}" end="${end}" var="i">
          <c:choose>
            <c:when test="${i eq page.pageNo}">
              <a href="javascript:void(0)" class="curPage" disabled="">${i}</a>
            </c:when>
            <c:otherwise>
              <a href="${basePath}/album.html?type=${type}&pageNo=${i}${wd==null?'':wd}">${i}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${end<page.totalPage}">
          <span>...</span>
        </c:if>
        <c:choose>
          <c:when test="${page.isLast}">
            <a href="javascript:void(0);" disabled="disabled" class="disabled">Next</a>
            <a href="javascript:void(0);" disabled="disabled" class="disabled">Last Page</a>

          </c:when>
          <c:otherwise>
            <a href="${basePath}/album.html?type=${type}&pageNo=${page.pageNo+1}${wd==null?'':wd}">Next</a>
            <a href="${basePath}/album.html?type=${type}&pageNo=${page.totalPage}${wd==null?'':wd}" disabled="disabled">Last Page</a>
          </c:otherwise>
        </c:choose>
      </div>
    </c:if>
    <c:if test="${page.rows.size()<=0}">
      <div class="empty">
        No data, please add my album...<a class="btn btn-info btn-xs" href="/user/album/edit.html" ><i class="fa fa-edit">Add</i></a>
      </div>
    </c:if>
  </div>

  <%--<%@include file="/static/comm/front/right.jsp" %>--%>
</article>
<%@include file="/static/comm/front/footer.jsp" %>
</body>
</html>
