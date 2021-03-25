<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Top navigation -->
<header class="header-navigation" id="header">
    <nav>
        <div class="logo" style="margin-top: 0px"><a href="/index.html">GOTO</a></div>
        <h2 id="mnavh"><span class="navicon"></span></h2>
        <div class="nav-left">
            <ul id="starlist">
                <li><a href="/index.html"><i class="fa fa-home">Home</i></a></li>
                <c:forEach var="menu" items="${categoryList}">
                    <li><a href="/album.html?type=${menu.id}"><i class="${menu.icon}"></i> ${menu.name}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="nav-right">
            <ul id="rightlist">
                <li>
                    <div class="searchbox">
                        <div id="search_bar" class="search_bar">
                            <form id="searchform" action="/album.html" method="post" name="searchform" onsubmit="return checkForm();">
                                <input type="hidden" name="type" value="${type}"/>
                                <input class="input" placeholder="Search" type="text" name="wd" id="wd"/>
                                <p class="search_ico"><span></span></p>
                            </form>
                        </div>
                    </div>
                </li>
                <c:choose>
                    <c:when test="${user==null}">
                        <li><a class="login_btn" data-toggle="modal" data-target="#loginModal" class="btn btn-primary">Sign in</a></li>
                        <li><a class="register_btn" data-toggle="modal" data-target="#registerModal" class="btn btn-default">Create account </a></li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="/user/album/edit.html"><i class="fa fa-plus"></i></a>
                        </li>
                        <li class="menu">
                            <a href="/user/profile.html">
                                <img src="${user==null ? '/static/images/avatar.jpg' : user.avatar}"/>
                            </a>
                            <ul class="sub">
                                <li><a href="/user/profile.html"><i class="fa fa-user">&nbsp;Me</i></a></li>
                                <li><a href="/user/album.html"><i class="fa fa-edit">&nbsp;My photo album</i></a></li>
                                <li><a href="/user/logout"><i class="fa fa-sign-out">&nbsp;Sign out</i></a></li>
                            </ul>
                            <span></span></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </nav>
</header>


<!--Login to register the modal box-->
<div class="modal fade user-select" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
    <div class="modal-dialog" role="document" style="margin-top: 10%;max-width: 400px;">
        <div class="modal-content">
            <form action="/Admin/Index/login" method="post" id="login_form" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="loginModalLabel">Sign in</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="loginUsername">Username</label>
                        <input type="text" class="form-control" id="loginUsername" placeholder="Please enter your username" autofocus
                               maxlength="15" autocomplete="off" required>
                    </div>
                    <div class="form-group">
                        <label for="loginPassword">Password</label>
                        <input type="password" class="form-control" id="loginPassword" placeholder="Please enter your password"
                               maxlength="18" autocomplete="new-password" required>
                    </div>
                    <div class="text-right">
                        <div class="modal-footer" style="padding: 15px 0px 15px 0px">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Delete</button>
                            <button type="submit" class="btn btn-primary" id="login_submit">Sign in</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Registration window -->
<div id="registerModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog" style="margin-top: 10%;max-width: 400px;">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
                <h4 class="modal-title" id="registerModalLabel">Create account</h4>
            </div>

            <div class="modal-body">
                <form class="form-group" action="" id="register_form">
                    <div class="form-group">
                        <label for="registerUsername">Username</label>
                        <input class="form-control" type="text" placeholder="Please enter your username" autocomplete="off" id="registerUsername">
                    </div>
                    <div class="form-group">
                        <label for="registerNickname">Nickname</label>
                        <input class="form-control" type="text" placeholder="Please enter your nickname" autocomplete="off" id="registerNickname">
                    </div>
                    <div class="form-group">
                        <label for="registerPassword">Password</label>
                        <input class="form-control" type="password" placeholder="Please enter your password" autocomplete="new-password" id="registerPassword">
                    </div>
                    <div class="form-group">
                        <label for="registerConfirmPassword">Confirm password</label>
                        <input class="form-control" type="password" placeholder="Please enter your confirmation password" autocomplete="new-password" id="registerConfirmPassword">
                    </div>
                    <div class="text-right">
                        <div class="modal-footer" style="padding: 15px 0px 15px 0px">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Delete</button>
                            <button type="submit" class="btn btn-primary" id="register_submit">Create my account</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>