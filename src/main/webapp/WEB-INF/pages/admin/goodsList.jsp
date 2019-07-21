<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.ldu.pojo.User" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    User cur_admin = (User)request.getSession().getAttribute("cur_admin");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <title>Squirrel后台管理系统</title>
    <script src="../js/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/jquery.bootgrid.min.css">
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.bootgrid.min.js"></script>
    <script src="../js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="../css/bootstrap-datetimepicker.min.css" type="text/css"></link>
</head>
<body>
<div class="container">
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
    <div class="row">
        <div class="col-md-12">
            <h2>Squirrel用户信息</h2>
            <a class="btn btn-primary" href="#">导出数据为excel</a>
            <table id="grid-data" class="table table-condensed table-hover table-striped">
                <thead>
                <tr>
                    <th data-column-id="id"  data-identifier="true" data-type="numeric">序号</th>
                    <th data-column-id="catelogId">类别ID</th>
                    <th data-column-id="userId">用户ID</th>
                    <th data-column-id="name">商品名称</th>
                    <th data-column-id="price">商品价格</th>
                    <th data-column-id="realPrice">商品原价</th>
                    <th data-column-id="startTime">开始时间</th>
                    <th data-column-id="polishTime">发布时间</th>
                    <th data-column-id="endTime">结束时间</th>
                    <th data-column-id="describle">商品描述</th>
                    <th data-column-id="commands" data-formatter="commands" data-sortable="false">Commands</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        var grid = $("#grid-data").bootgrid({
            ajax:true,
            post: function ()
            {
                return {
                    id: "b0df282a-0d67-40e5-8558-c9e93b7befed"
                };
            },
            url:"/admin/goods",
            formatters: {
                "commands": function(column, row)
                {
                    return "<button type=\"button\" class=\"btn btn-xs btn-default command-edit\" data-row-id=\"" + row.id + "\">编辑<span class=\"fa fa-pencil\"></span></button> " +
                        "<button type=\"button\" class=\"btn btn-xs btn-default command-delete\" data-row-id=\"" + row.id + "\">删除<span class=\"fa fa-trash-o\"></span></button>";
                }
            }
        }).on("loaded.rs.jquery.bootgrid", function()
        {
            grid.find(".command-edit").on("click", function(e)
            {
                $(".stumodal").modal();
                $.post("/admin/getGoodInfo",{goodId:$(this).data("row-id")},function(str){
                    $("#goodId2").val(str.id);
                    $("#catelogId2").val(str.catelogId);
                    $("#userId2").val(str.userId);
                    $("#goodsName2").val(str.name);
                    $("#goodsPrice2").val(str.price);
                    $("#realPrice2").val(str.realPrice);
                    $("#startTime2").val(str.startTime);
                    $("#publishTime2").val(str.polishTime);
                    $("#endTime2").val(str.endTime);
                    $("#describle2").val(str.describle);
                });
            }).end().find(".command-delete").on("click", function(e)
            {
                alert("You pressed delete on row: " + $(this).data("row-id"));
                $.post("/admin/delGood",{goodId:$(this).data("row-id")},function(){
                    alert("删除成功");
                    $("#grid-data").bootgrid("reload");
                });
            });
        });
    });

    $(document).ready(function(){
        $("#add").click(function(){
            $(".addmodal").modal();
        });
    });

</script>

<div class="modal fade stumodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">信息修改</h4>
            </div>
            <form action="/admin/UpdateGood" method="get">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="goodId2">goodId</label>
                        <input type="text" name="goodId" class="form-control" id="goodId2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="catelogId2">catelogId</label>
                        <input type="text" name="catelogId" class="form-control" id="catelogId2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="userId2">userId</label>
                        <input type="text" name="userId" class="form-control" id="userId2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="goodsName2">goodsName</label>
                        <input type="text" name="goodsName" class="form-control" id="goodsName2">
                    </div>
                    <div class="form-group">
                        <label for="goodsPrice2">goodsPrice</label>
                        <input type="text" name="goodsPrice" class="form-control" id="goodsPrice2" >
                    </div>
                    <div class="form-group">
                        <label for="realPrice2">realPrice</label>
                        <input type="text" name="realPrice" class="form-control" id="realPrice2">
                    </div>
                    <div class="form-group">
                        <label for="startTime2">startTime</label>
                        <input type="text" name="startTime" class="form-control" id="startTime2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="publishTime2">publishTime</label>
                        <input type="text" name="publishTime" class="form-control" id="publishTime2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="endTime2">endTime</label>
                        <input type="text" name="endTime" class="form-control" id="endTime2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="describle2">describle</label>
                        <input type="text" name="describle" class="form-control" id="describle2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade addmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加用户</h4>
            </div>
            <form action="" method="get">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="userName1">userName</label>
                        <input type="text" name="userName" class="form-control" id="userName1">
                    </div>
                    <div class="form-group">
                        <label for="userAge1">userAge</label>
                        <input type="text" name="userAge" class="form-control" id="userAge1">
                    </div>
                    <div class="form-group">
                        <label for="userMajor1">userMajor</label>
                        <input type="text" name="userMajor" class="form-control" id="userMajor1">
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="Id" class="form-control" id="Id">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>