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
            <h2>Squirrel商品类别信息</h2>
            <a class="btn btn-primary" href="">导出数据为excel</a>
            <a class="btn btn-primary" href="#" id="add">新增类别</a>
            <table id="grid-data" class="table table-condensed table-hover table-striped">
                <thead>
                <tr>
                    <th data-column-id="id"  data-identifier="true" data-type="numeric">序号</th>
                    <th data-column-id="name">类别名称</th>
                    <th data-column-id="number">商品数量</th>
                    <th data-column-id="status">status</th>
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
            url:"/admin/catelogs",
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
                $.post("/admin/getCatelogInfo",{catelogId:$(this).data("row-id")},function(str){
                    $("#catelogId2").val(str.id);
                    $("#catelogName2").val(str.name);
                    $("#catelogNum2").val(str.number);
                    $("#catelogSta2").val(str.status);
                });
            }).end().find(".command-delete").on("click", function(e)
            {
                alert("You pressed delete on row: " + $(this).data("row-id"));
                $.post("/admin/delCatelog",{catelogId:$(this).data("row-id")},function(){
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
            <form action="/admin/UpdateCatelog" method="get">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="catelogId2">catelogId</label>
                        <input type="text" name="catelogId" class="form-control" id="catelogId2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="catelogName2">catelogName</label>
                        <input type="text" name="catelogName" class="form-control" id="catelogName2">
                    </div>
                    <div class="form-group">
                        <label for="catelogNum2">catelogNum</label>
                        <input type="text" name="catelogNum" class="form-control" id="catelogNum2" readonly="true">
                    </div>
                    <div class="form-group">
                        <label for="catelogSta2">catelogSta</label>
                        <input type="text" name="catelogSta" class="form-control" id="catelogSta2" readonly="true">
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
                <h4 class="modal-title">添加类别</h4>
            </div>
            <form action="/admin/addCatelog" method="get" role="form">
                <div class="modal-body">

                    <div class="form-group">
                        <label for="catelogName1">catelogName</label>
                        <input type="text" name="catelogName" class="form-control" id="catelogName1">
                    </div>

                    <div class="form-group">
                        <input type="hidden" name="Id" class="form-control" id="Id">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add Catelog</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>