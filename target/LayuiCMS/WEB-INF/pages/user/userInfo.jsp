<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>个人资料</title>
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
<form class="layui-form layui-row">
	<div class="layui-col-md3 layui-col-xs12 user_right">
		<div class="layui-upload-list">
			<img class="layui-upload-img layui-circle userFaceBtn userAvatar" id="userFace" src="data:image/jpg;base64,${icon}">
		</div>
		<button type="button" class="layui-btn layui-btn-primary userFaceBtn"><i class="layui-icon">&#xe67c;</i> 掐指一算，我要换一个头像了</button>
	</div>
	<div class="layui-col-md6 layui-col-xs12">
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input type="text" value="${user.username}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户类型</label>
			<div class="layui-input-block">
				<input type="text" value="${user.type}" disabled class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">真实姓名</label>
			<div class="layui-input-block">
				<input type="text" value="" placeholder="请输入真实姓名" lay-verify="required" class="layui-input realName">
			</div>
		</div>
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block userSex">
				<input type="radio" name="sex" value="1" title="男" ${user.sex==1?"checked":""}>
				<input type="radio" name="sex" value="2" title="女" ${user.sex==2?"checked":""}>
				<input type="radio" name="sex" value="0" title="保密" ${user.sex==0?"checked":""}>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机号码</label>
			<div class="layui-input-block">
				<input type="tel" value="${user.phone}" placeholder="请输入手机号码" lay-verify="phone" class="layui-input phone">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">出生日期</label>
			<div class="layui-input-block">
				<input type="text" value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" />" placeholder="请输入出生年月" lay-verify="birthday" readonly class="layui-input birthday">
			</div>
		</div>
		<div class="layui-form-item layui-row layui-col-xs12">
			<label class="layui-form-label">用户简介</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入用户简介" class="layui-textarea userDesc">${user.userDesc}</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	let form, $;
	layui.use(['form','layer','upload','laydate'],function(){
		form = layui.form;
		$ = layui.jquery;
		let layer = parent.layer === undefined ? layui.layer : top.layer,
				upload = layui.upload,
				laydate = layui.laydate;

		//上传头像
		upload.render({
			elem: '.userFaceBtn',
			url: '/user/uploadIcon',
			method : "post",
			data: {
				id: "${user.id}"
			},
			done: function(res, index, upload){
				layer.msg(res.msg);
				$('#userFace').attr('src',"data:image/jpg;base64,"+res.data);
			}
		});

		//添加验证规则
		form.verify({
			birthday : function(value){
				if(!/^(\d{4})[\u4e00-\u9fa5]|[-\/](\d{1}|0\d{1}|1[0-2])([\u4e00-\u9fa5]|[-\/](\d{1}|0\d{1}|[1-2][0-9]|3[0-1]))*$/.test(value)){
					return "出生日期格式不正确！";
				}
			}
		});
		//选择出生日期
		laydate.render({
			elem: '.birthday',
			format: 'yyyy/MM/dd',
			trigger: 'click'
		});
		//提交个人资料
		form.on("submit(changeUser)",function(data){
			let index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
			$.post("/user/userEdit",{
				id:${user.id},
				realName:$(".realName").val(),
				sex: data.field.sex,  //性别
				phone:$(".phone").val(),
				birthday : $(".birthday").val(),
				userDesc : $(".userDesc").text()   //用户简介
			},function(data) {
				layer.close(index);
				layer.msg(data.msg);
			});
			return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
		});
	})
</script>
</body>
</html>
