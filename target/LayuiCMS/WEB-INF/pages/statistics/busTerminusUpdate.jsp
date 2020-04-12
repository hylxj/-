<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
					<label class="layui-form-label">公交总站名称</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input buscenName" lay-verify="required" placeholder="请输入总站名称" value="${buscenter.buscenName}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交总站所属区</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input buscenDistrict" lay-verify="required" placeholder="请输入总站所属区" value="${buscenter.buscenDistrict}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交总站负责人编号</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input buscenManagerid" lay-verify="number" placeholder="请输入总站负责人编号" value="${buscenter.buscenManagerid}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交总站创建时间</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input buscenCreatetime" id="expenseTime" lay-verify="time" placeholder="请选择总站创建时间" value="${buscenter.buscenCreatetime}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交总站状态</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input buscenStatus" lay-verify="number" placeholder="请输入总站状态" value="${buscenter.buscenStatus}">
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
			$.post("/busTerminusUpdate",{
				buscenId : ${buscenter.buscenId},//id
				buscenName : $(".buscenName").val(),  //公交车调度中心名称
				buscenDistrict : $(".buscenDistrict").val(),  //公交车调度中心所属区
				buscenManagerid : $(".buscenManagerid").val(),  //公交车调度中心负责人编号
				buscenCreatetime : $(".buscenCreatetime").val(),  //公交总站创建时间
				buscenStatus : $(".buscenStatus").val(),  //公交总站状态
			},function(res){

			});
			setTimeout(function(){
				top.layer.close(index);
				top.layer.msg("总站信息添加成功！");
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
