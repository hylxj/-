<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户编辑</title>
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
			<input type="text" class="layui-input userName" lay-verify="required" placeholder="请输入用户名" value="${user.username}">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">出生日期</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input birthday" id="birthday" lay-verify="required" placeholder="请选择用户出生日期" value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" />">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">联系方式</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input phone" lay-verify="phone" placeholder="请输入用户联系方式" value="${user.phone}">
		</div>
	</div>
	<div class="layui-row">
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block userSex">
				<input type="radio" name="sex" value="1" title="男" ${user.sex==1?"checked":""}>
				<input type="radio" name="sex" value="2" title="女" ${user.sex==2?"checked":""}>
				<input type="radio" name="sex" value="0" title="保密" ${user.sex==0?"checked":""}>
			</div>
		</div>
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">用户类型</label>
			<div class="layui-input-block">
				<select name="userType" class="userType" lay-filter="userType">
					<option value="0" ${user.type==0?"selected":""}>超级管理员</option>
					<option value="1" ${user.type==1?"selected":""}>调度中心管理员</option>
					<option value="2" ${user.type==2?"selected":""}>调度中心外勤人员</option>
					<option value="3" ${user.type==3?"selected":""}>调度中心财务人员</option>
					<option value="4" ${user.type==4?"selected":""}>调度中心调度人员</option>
				</select>
			</div>
		</div>
		<div class="magb15 layui-col-md4 layui-col-xs12">
			<label class="layui-form-label">用户状态</label>
			<div class="layui-input-block">
				<select name="locked" class="locked" lay-filter="locked">
					<option value="0" ${user.locked==0?"selected":""}>锁定状态</option>
					<option value="1" ${user.locked==1?"selected":""}>正常状态</option>
				</select>
			</div>
		</div>
	</div>
	<div class="magb15 layui-col-md4 layui-col-xs12">
		<label class="layui-form-label">用户所在调度中心</label>
		<div class="layui-input-block">
			<select name="busCen" class="busCen" lay-filter="busCen">
				<option value="0" ${user.belongId==0?"selected":""}>超级管理员</option>
				<c:forEach items="${busCens}" let="busCen">
					<option value="${busCen.id}" ${user.belongId==busCen.id?"selected":""}>${busCen.title}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">用户简介</label>
		<div class="layui-input-block">
			<textarea placeholder="请输入用户简介" class="layui-textarea userDesc">${user.userDesc}</textarea>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="editUser">立即更新</button>
			<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','laydate'],function(){
		let form = layui.form,
		layer = parent.layer === undefined ? layui.layer : top.layer,
		$ = layui.jquery,
		laydate=layui.laydate;
		laydate.render({
			elem:"#birthday",
			format:"yyyy/MM/dd"
		});
		form.on("submit(editUser)",function(data){
			//弹出loading
			let index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			// 实际使用时的提交信息
			$.post("/user/userEdit",{
				id:${user.id},
			    username : $(".userName").val(),  //登录名
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
		let time = new Date();
		let submitTime = time.getFullYear()+'-'+filterTime(time.getMonth()+1)+'-'+filterTime(time.getDate())+' '+filterTime(time.getHours())+':'+filterTime(time.getMinutes())+':'+filterTime(time.getSeconds());

	})
</script>
</body>
</html>
