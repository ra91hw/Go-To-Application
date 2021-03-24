<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Personal center left navigation -->
<div class="lbox">
    <div class="whitebg user-info">
        <img src="${user.avatar==null?'/static/images/avatar.jpg':user.avatar}"/>
        <a href="/user/profile.html"><i class="fa fa-home">&nbsp;${user.username}</i></a>
    </div>
    <ul class="pagemenu">
        <li><a href="/user/profile.html"><i class="fa fa-user"> My Detail</i></a></li>
        <li><a href="/user/album.html"><i class="fa fa-book"> My Photo Album</i></a></li>
        <li><a href="/user/updatePwd.html"><i class="fa fa-edit">&nbsp;Change My Password</i></a></li>
        <li><a href="/user/logout.html"><i class="fa fa-sign-out"> Sign Out</i></a></li>
    </ul>
</div>
