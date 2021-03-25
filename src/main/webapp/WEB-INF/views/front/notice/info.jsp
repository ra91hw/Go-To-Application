<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<head>
  <meta charset="gbk">
  <title>${notice.title}</title>
  <meta name="keywords" content="Announcement of the details" />
  <meta name="description" content="Announcement of the details" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <%@include file="/static/comm/front/taglib.jsp" %>
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article>
  <div class="location" style="">
    <i class="fa fa-home"></i>
    <a href="/index.html">Home</a>
    <span>[Announcement]${notice.title}</span>
  </div>
  <main>
    <div class="infosbox">
      <div class="newsview">
        <h3 class="news_title">${notice.title}</h3>
        <div class="bloginfo">
          <ul>
            <li class="author"><a href="/">GO-TO</a></li>
            <li class="timer"><fmt:formatDate value="${notice.createTime}" pattern="dd-MM-yyyy"/></li>
          </ul>
        </div>
        <div class="news_con"> ${notice.content}</div>
      </div>

    </div>
  </main>
  <%@include file="/static/comm/front/right.jsp" %>
</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">

    $("#btn-join").on("mouseenter",function(){
        var tips = layer.tips('Join us to post and reply.', '#btn-join',{
            tips: [1, '#555555']
        });
    });
</script>
</body>
</html>
