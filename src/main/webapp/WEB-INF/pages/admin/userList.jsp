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
			<a class="btn btn-primary" href="/admin/exportUser">导出数据为excel</a>
			<table id="grid-data" class="table table-condensed table-hover table-striped">
				<thead>
				<tr>
					<th data-column-id="id"  data-identifier="true" data-type="numeric">序号</th>
					<th data-column-id="phone">手机号</th>
					<th data-column-id="username">用户名</th>
					<th data-column-id="password">密码</th>
					<th data-column-id="qq">QQ</th>
					<th data-column-id="createAt">创建时间</th>
					<th data-column-id="goodsNum">商品数量</th>
					<th data-column-id="power">用户权限</th>
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
            url:"/admin/users",
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
                $.post("/admin/getUserInfo",{userId:$(this).data("row-id")},function(str){
                    $("#userId2").val(str.id);
                    $("#userPhone2").val(str.phone);
                    $("#userName2").val(str.username);
                    $("#userpassword2").val(str.password);
                    $("#userQQ2").val(str.qq);
                    $("#usercreateAt2").val(str.createAt);
                    $("#usergood_num2").val(str.goodsNum);
                    $("#userpower2").val(str.power);
                });
            }).end().find(".command-delete").on("click", function(e)
            {
                alert("You pressed delete on row: " + $(this).data("row-id"));
                $.post("/admin/delUser",{userId:$(this).data("row-id")},function(){
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
			<form action="/admin/UpdateUser" method="get">
				<div class="modal-body">
					<div class="form-group">
						<label for="userId2">userId</label>
						<input type="text" name="userId" class="form-control" id="userId2" readonly="true">
					</div>
					<div class="form-group">
						<label for="userPhone2">userPhone</label>
						<input type="text" name="userPhone" class="form-control" id="userPhone2">
					</div>
					<div class="form-group">
						<label for="userName2">userName</label>
						<input type="text" name="userName" class="form-control" id="userName2">
					</div>
					<div class="form-group">
						<label for="userpassword2">userPassword</label>
						<input type="text" name="userPassword" class="form-control" id="userpassword2" readonly="true">
					</div>
					<div class="form-group">
						<label for="userQQ2">userQQ</label>
						<input type="text" name="userQQ" class="form-control" id="userQQ2">
					</div>
					<div class="form-group">
						<label for="usercreateAt2">userCreateAt</label>
						<input type="text" name="userCreateAt" class="form-control" id="usercreateAt2" readonly="true">
					</div>
					<div class="form-group">
						<label for="usergood_num2">userGoodnums</label>
						<input type="text" name="userGoodnums" class="form-control" id="usergood_num2" readonly="true">
					</div>
					<div class="form-group">
						<label for="userpower2">userPower</label>
						<input type="text" name="userPower" class="form-control" id="userpower2">
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