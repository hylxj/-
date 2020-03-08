<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户添加</title>
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
<form class="layui-form" style="width:80%;">
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">用户名</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input userName" lay-verify="required" placeholder="请输入用户名">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">初始密码</label>
		<div class="layui-input-block">
			<input type="password" class="layui-input password" lay-verify="password" placeholder="请输入初始密码">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">出生日期</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input birthday" id="birthday" lay-verify="required" placeholder="请选择出生日期">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">联系方式</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input phone" lay-verify="phone" placeholder="请输入用户联系方式">
		</div>
	</div>
	<div class="layui-row">
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block userSex">
				<input type="radio" name="sex" value="1" title="男" checked>
				<input type="radio" name="sex" value="2" title="女">
				<input type="radio" name="sex" value="0" title="保密">
			</div>
		</div>
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">用户类型</label>
			<div class="layui-input-block">
				<select name="userType" class="userType" lay-filter="userType">
					<c:forEach items="${roles}" var="role">
						<option value="${role.roleId}">${role.roleDesc}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">用户状态</label>
			<div class="layui-input-block">
				<select name="locked" class="locked" lay-filter="locked">
					<option value="0">锁定状态</option>
					<option value="1">正常状态</option>
				</select>
			</div>
		</div>
	</div>
	<div class="magb15 layui-col-md4 layui-col-xs12">
		<label class="layui-form-label">用户所在组织机构</label>
		<div class="layui-input-block">
			<select name="busCen" class="busCen" lay-filter="busCen">
				<c:forEach items="${busCens}" var="busCen">
					<option value="${busCen.id}">${busCen.title}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">用户简介</label>
		<div class="layui-input-block">
			<textarea placeholder="请输入用户简介" class="layui-textarea userDesc"></textarea>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addUser">立即添加</button>
			<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','laydate'],function(){
		var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : top.layer,
		$ = layui.jquery,
		laydate=layui.laydate;
		laydate.render({
			elem:"#birthday",
			format:"yyyy/MM/dd"
		});

		form.on("submit(addUser)",function(data){
			//弹出loading
			var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			// 实际使用时的提交信息
			$.post("/user/userAdd",{
			    username : $(".userName").val(),  //登录名
			    password : $(".password").val(),  //密码
			    sex: data.field.sex,  //性别
			    locked : data.field.locked,    //用户状态
			    type:data.field.userType,
				birthday : $(".birthday").val(),
				phone:$(".phone").val(),
				belongId:data.field.busCen,
			    userDesc : $(".userDesc").val()   //用户简介
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

		//格式化时间
		function filterTime(val){
			if(val < 10){
				return "0" + val;
			}else{
				return val;
			}
		}
		//定时发布
		var time = new Date();
		var submitTime = time.getFullYear()+'-'+filterTime(time.getMonth()+1)+'-'+filterTime(time.getDate())+' '+filterTime(time.getHours())+':'+filterTime(time.getMinutes())+':'+filterTime(time.getSeconds());

	})
</script>
</body>
</html>