<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>修改密码</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form layui-row changePwd">
	<div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
		<div class="layui-input-block layui-red pwdTips">请输入旧密码，新密码必须两次输入一致才能提交</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input type="text" value="${username}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">旧密码</label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请输入旧密码" id="oldPwd" lay-verify="required|oldPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请输入新密码" lay-verify="required|newPwd" id="newPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码</label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','laydate','table','laytpl'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;
		//添加验证规则
		let bool=false;
		$("#oldPwd").blur(function () {
			$.get("/user/verifyOldPwd", {
				username:"${username}",
				password:$(this).val()
			},function (data) {
				if(data.code===200){
					bool=true;
				}
			});
		});
		form.verify({
			oldPwd : function(value, item){
				if (!bool){
					return "旧密码错误,请重新输入";
				}
			},
			newPwd : function(value, item){
				if(value.length < 6){
					return "密码长度不能小于6位";
				}
			},
			confirmPwd : function(value, item){
				if(!new RegExp($("#newPwd").val()).test(value)){
					return "两次输入密码不一致，请重新输入！";
				}
			}
		});
		form.on("submit(changePwd)",function(data){
			//弹出loading
			let index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			// 实际使用时的提交信息
			$.post("/user/changePwd",{
				username : "${username}",  //登录名
				password:$('#newPwd').val()
			},function(res){
				top.layer.close(index);
				if (res.code===200){
					top.layer.msg(res.msg);
				}else {
					top.layer.msg(res.msg);
				}
				layer.closeAll("iframe");
				//刷新父页面
				parent.location.reload();
			});
			return false;
		});
	})
</script>
</body>
</html>
