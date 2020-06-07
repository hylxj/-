<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="../404.jsp" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>文章列表--layui后台管理模板 2.0</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/public.css" media="all" />
</head>
<body class="childrenBody" >
<form class="layui-form layui-row layui-col-space10" style="margin-left:400px">
	<div class="layui-col-md9 layui-col-xs12" >
		<div class="layui-row layui-col-space10">
			<div class="layui-col-md9 layui-col-xs7">
				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机姓名</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverName" lay-verify="required" placeholder="请输入司机姓名" value="${busDriver.busdriverName}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机年龄</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverAge" lay-verify="number" placeholder="请输入司机年龄" value="${busDriver.busdriverAge}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机性别</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverSex" lay-verify="number" placeholder="请输入司机性别" value="${busDriver.busdriverSex}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机联系方式</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverPhone" lay-verify="required" placeholder="请输入司机联系方式" value="${busDriver.busdriverPhone}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机驾驶公交编号</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverBusid" lay-verify="number" placeholder="请输入司机驾驶公交编号" value="${busDriver.busdriverBusid}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机所属调度中心</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverBelongid" lay-verify="number" placeholder="请输入司机所属调度中心" value="${busDriver.busdriverBelongid}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机工作年限</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverInitime"  id="expenseTime" lay-verify="time" placeholder="请输入司机工作年限" value="${busDriver.busdriverInitime}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">司机状态</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverStatus" lay-verify="number" placeholder="请输入司机状态" value="${busDriver.busdriverStatus}">
					</div>
				</div>
			<hr class="layui-bg-gray" />
			<div class="layui-right">
				<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe609;</i>提交</a>
				<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe61c;</i>重置</a>
			</div>
		</div>
	</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','layedit','laydate','upload'],function(){
		let form = layui.form
		layer = parent.layer === undefined ? layui.layer : top.layer,
				laypage = layui.laypage,
				upload = layui.upload,
				layedit = layui.layedit,
				laydate = layui.laydate,
				$ = layui.jquery;
		//执行一个laydate实例
		laydate.render({
			elem: '#expenseTime' //指定元素
			,format:'yyyy/MM/dd'
		});

		//格式化时间
		function filterTime(val){
			if(val < 10){
				return "0" + val;
			}else{
				return val;
			}
		}
		form.on("submit(addNews)",function(data){

			//弹出loading
			let index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			//实际使用时的提交信息
			$.post("/driverUpdate",{
				busdriverId : ${busDriver.busdriverId},
				busdriverName : $(".busdriverName").val(),  //司机姓名
				busdriverAge : $(".busdriverAge").val(),  //司机年龄
				busdriverSex : $(".busdriverSex").val(),  //司机性别
				busdriverPhone : $(".busdriverPhone").val(),  //司机联系方式
				busdriverBusid : $(".busdriverBusid").val(),  //司机驾驶公交编号
				busdriverBelongid : $(".busdriverBelongid").val(),  //司机所属站点
				busdriverInitime : $(".busdriverInitime").val(),  //司机工作年限
				busdriverStatus : $(".busdriverStatus").val()  //司机状态
			},function(res){

			});
			setTimeout(function(){
				top.layer.close(index);
				top.layer.msg("司机信息修改成功！");
				layer.closeAll("iframe");
				//刷新父页面
				parent.location.reload();
			},500);
			return false;
		});

	});
</script>
</body>
</html>
