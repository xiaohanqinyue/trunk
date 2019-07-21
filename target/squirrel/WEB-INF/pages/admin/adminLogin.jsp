
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>内蒙古大学二手书店登录界面</title>
    <link rel="stylesheet" href="../../css/index.css" />
    <script type="text/javascript" src="../../js/jquery.js" ></script>
    <script type="text/javascript" src="../../js/materialize.min.js" ></script>
    <script type="text/javascript" src="../../js/index.bundle.js" ></script>
    <link rel="stylesheet" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../css/font-awesome.min.css" />

    <style>
        body{
            background: url("../../../img/w.jpg");
            animation-name:myfirst;
            animation-duration:10s;
            /*变换时间*/
            animation-delay:1s;
            /*动画开始时间*/
            animation-iteration-count:infinite;
            /*下一周期循环播放*/
            animation-play-state:running;
            /*动画开始运行*/
        }
        @keyframes myfirst
        {
            0%   {background:url("../../../img/w.jpg");width: 100%;height: 100%;background-size: cover;background-repeat: no-repeat}
            34%  {background:url("../../../img/y.jpg");width: 100%;height: 100%;background-size: cover;background-repeat: no-repeat}
            67%  {background:url("../../../img/z.jpg");width: 100%;height: 100%;background-size: cover;background-repeat: no-repeat}
            100% {background:url("../../../img/w.jpg");width: 100%;height: 100%;background-size: cover;background-repeat: no-repeat}
        }
        .form{background: rgba(255,255,255,0.2);width:400px;margin:40px auto;}
        /*阴影*/
        .fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}
        input[type="text"],input[type="password"]{padding-left:26px;}
    </style>
</head>
<body>
<div class="container">
    <div class="col-md-offset-0"  style="margin-top: 80px">
        <p style="font-style: italic;font-family: 华文行楷;font-size: 50px">内大二手预交易后台管理</p>
    </div>
    <div class="form row">
        <div class="form-horizontal col-md-offset-1" id="login_form">
            <h3 class="form-title">管理员登录</h3>
            <form method="get" action="/admin/adminLoginTo">
            <div class="col-md-9">
                <div class="form-group" >
                    <i class="fa fa-user fa-lg"></i>
                    <input class="form-control required  text-danger" type="text" placeholder="Phone" id="username" name="username" autofocus="autofocus" maxlength="20" style="font-size: 20px;font-family: 'Adobe 黑体 Std R';color: black"/>
                </div>
                <div class="form-group">
                    <i class="fa fa-lock fa-lg"></i>
                    <input class="form-control required text-danger" type="password" placeholder="Password" id="password" name="password" maxlength="20" style="font-size: 20px; font-family: 'Adobe 黑体 Std R';color: black"/>
                </div>
                <div class="form-group col-md-offset-9">

                    <button type="submit" class="btn btn-success pull-right" name="submit">登录</button>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
