<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="/static/images/avatar.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>${admin.username}</p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">Navigation bar</li>
            <li><a href="/admin/index"><i class="fa fa-dashboard"> </i> <span>HOME</span></a></li>

            <li class="treeview">
                <a href="javascript:void(0)">
                    <i class="fa fa-list"></i> <span>Category Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/admin/category/"><i class="fa fa-circle-o"></i>Category Management</a></li>
                </ul>
            </li>


            <li class="treeview">
                <a href="javascript:void(0)">
                    <i class="fa fa-book"></i>
                    <span>Loop Player Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/admin/banner"><i class="fa fa-circle-o"></i> <span>Loop Player Management</span></a></li>
                    <li><a href="/admin/banner/edit"><i class="fa fa-circle-o"></i> <span>Loop Player Add</span></a></li>
                </ul>
            </li>


            <li class="treeview">
                <a href="javascript:void(0)">
                    <i class="fa fa-list"></i>
                    <span>Announcement Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/admin/notice"><i class="fa fa-circle-o"></i> <span>Announcement Management</span></a></li>
                    <li><a href="/admin/notice/edit"><i class="fa fa-circle-o"></i> <span>Announcement Add</span></a></li>
                </ul>
            </li>

            <li class="treeview">
                <a href="javascript:void(0)">
                    <i class="fa fa-list"></i>
                    <span>Link Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/admin/link"><i class="fa fa-circle-o"></i> <span>Links Management</span></a></li>
                </ul>
            </li>


            <li class="treeview">
                <a href="javascript:void(0)">
                    <i class="fa fa-list"></i> <span>System User</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/admin/user"><i class="fa fa-circle-o"></i>User management</a></li>
                </ul>
            </li>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>