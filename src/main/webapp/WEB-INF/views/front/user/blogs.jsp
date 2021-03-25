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
<title></title>
  <%@include file="/static/comm/front/taglib.jsp" %>
  <link rel="stylesheet" href="/static/css/user-center.css">
</head>
<body>
<%@include file="/static/comm/front/header.jsp" %>
<article class="user-center">
  <div class="location" style="">
    <i class="fa fa-home"></i>
    <a href="/index.html">Home</a>
    <span>My blog</span>
  </div>
  <%@include file="/static/comm/front/left.jsp"%>
  <div class="rbox">
      <div class="whitebg bloglist">
        <h2 class="htitle">
          <a class="btn btn-sm btn-info" href="/blog/edit.html" style="float: right"><i class="fa fa-plus">Write something you want to say</i></a>
        </h2>
        <div class="table-responsive">
          <table class="table">
            <thead>
            <tr>
              <th>Title</th>
              <th>Like</th>
              <th>Comments</th>
              <th>Status</th>
              <th>Create time</th>
              <th>Operation</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${page.rows.size() > 0}">
            <c:forEach var="blog" items="${page.rows}" varStatus="status">
            <tr>
              <td>${blog.title}</td>
              <td>${blog.agreeNumber}</td>
              <td>${blog.discussNumber}</td>
              <td>
                <c:if test="${blog.status==0}"><label class="label label-default">Pending review</label></c:if>
                <c:if test="${blog.status==1}"><label class="label label-primary">Pass</label></c:if>
                <c:if test="${blog.status==2}"><label class="label label-success">Failed</label></c:if>
              </td>
              <td><fmt:formatDate value="${blog.createTime}" pattern="HH:mm:ss dd-MM-yyyy "/></td>
              <td>
                <div class="btn-group btn-group-xs">
                  <button type="button" class="btn btn-default" data-id="${blog.id}" id="edit"><i class="fa fa-edit">&nbsp;Edit</i></button>
                  <button type="button" class="btn btn-danger" data-id="${blog.id}" id="remove"><i class="fa fa-remove">&nbsp;Delete</i></button>
                </div>
              </td>
            <tr>
              </c:forEach>
            </c:if>
                <c:if test="${page.rows.size() <= 0 }">
            <tr>
              <td colspan="6" style="text-align: center;line-height: 40px">Temporarily no data</td>
            </tr>
            </c:if>
            </tbody>
          </table>
        </div>
        <!--pagelist-->
        <div class="pagelist">
          <c:choose>
            <c:when test="${page.isFirst}">
              <a href="javascript:void(0);" disabled="disabled" class="disabled">Home</a>
              <a href="javascript:void(0);" disabled="disabled" class="disabled">Previous</a>
            </c:when>
            <c:otherwise>
              <a href="${basePath}/user/blogs.html?pageNo=1" disabled="disabled">Home</a>
              <a href="${basePath}/user/blogs.html?pageNo=${page.pageNo-1}">Previous</a>
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

          <!-- Cycle through page numbers -->
          <c:if test="${begin>1}">
            <span>...</span>
          </c:if>

          <c:forEach begin="${begin}" end="${end}" var="i">
            <c:choose>
              <c:when test="${i eq page.pageNo}">
                <a href="javascript:void(0)" class="curPage" disabled="">${i}</a>
              </c:when>
              <c:otherwise>
                <a href="${basePath}/user/blogs.html?pageNo=${i}">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>

          <c:if test="${end<page.totalPage}">
            <span>...</span>
          </c:if>
          <c:choose>
            <c:when test="${page.isLast}">
              <a href="javascript:void(0);" disabled="disabled" class="disabled">Next</a>
              <a href="javascript:void(0);" disabled="disabled" class="disabled">Last page</a>

            </c:when>
            <c:otherwise>
              <a href="${basePath}/user/blogs.html?pageNo=${page.pageNo+1}">Next</a>
              <a href="${basePath}/user/blogs.html?pageNo=${page.totalPage}" disabled="disabled">Last page</a>
            </c:otherwise>
          </c:choose>
        </div>
        <!--pagelist end-->
      </div>
  </div>

</article>
<%@include file="/static/comm/front/footer.jsp" %>
<script type="text/javascript">

    //Edit post
    $("#edit").click(function (e) {

        var o = $(this);
        var id = o.attr('data-id');
        var index = layer.confirm();
        layer.confirm('The blog needs to be reviewed again after editing, are you sure to edit？', {
            btn: ['Yes', 'No']//Button
        }, function (index) {
            layer.close(index);
            window.location.href="/blog/edit.html?id="+id;
        });

    });



    //Delete self-published posts
    $("#remove").click(function (e) {

        var o = $(this);
        var index = layer.confirm();
        layer.confirm('Are you sure you want to delete the article？', {
            btn: ['Yes', 'No']//Button
        }, function (index) {
            layer.close(index);

            var data = {"id": o.attr('data-id')};
            $.ajax({
                url: "/user/blog/remove",
                type: "POST",
                dataType: "JSON",
                contentType: "application/json",
                data: JSON.stringify(data),
                beforeSend: function () {
                    // Disable button to prevent duplicate submission
                    o.attr({disabled: "disabled"});
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
                    o.removeAttr("disabled");
                },
                complete: function () {
                    o.removeAttr("disabled");
                },
                error: function (data) {
                    layer.msg(data.body, {icon: 5, time: 2000});
                    o.removeAttr("disabled");
                }
            });
        });

    });
</script>
</body>
</html>