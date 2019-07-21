<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.ldu.pojo.User" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    User cur_admin = (User)request.getSession().getAttribute("cur_admin");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Squirrel后台管理系统</title>
    <script src="../js/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/jquery.bootgrid.min.css">
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.bootgrid.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css" type="text/css"></link>
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" href="../css/emoji.css" />
    <link rel="stylesheet" href="../css/userhome.css" />
    <link rel="stylesheet" href="../css/user.css" />

</head>
<body>
<div class="pre-2" id="big_img">
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">

    <div id="user_area">
        <div class="row">
            <div class="col-md-12">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar">*****</span>
                            </button>
                            <a class="navbar-brand" href="/admin/adminIndex">Squirrel后台管理系统</a>
                        </div>
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li><a href="#">${cur_admin.username}</a></li>
                                <li><a href="/admin/logout">logout</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!--
            作者：David Wang
            时间：2018-11-25
            描述：左侧个人中心栏
        -->
        <div id="user_nav">

            <div class="home_nav">
                <ul>
                    <a href="#">
                        <li class="notice">
                            <div></div>
                            <span>留言板管理</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/admin/userList">
                        <li class="fri">
                            <div></div>
                            <span>用户管理</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="">
                        <li class="set">
                            <div></div>
                            <span>公告管理</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/admin/goodsList">
                        <li class="store">
                            <div></div>
                            <span>商品管理</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="/admin/catelogList">
                        <li class="second">
                            <div></div>
                            <span>商品类别管理</span>
                            <strong></strong>
                        </li>
                    </a>
                </ul>
            </div>
        </div>


        <div id="user_content">

            <h1 align="center">欢迎来到Squirrel后台管理系统</h1>


        </div>
    </div>

</div>
</div>
</body>
</html>