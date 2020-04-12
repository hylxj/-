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
					<label class="layui-form-label">员工工资</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseSalary" lay-verify="number" placeholder="请输入员工工资" value="${expense.expenseSalary}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">车辆维修</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseFix" lay-verify="number" placeholder="请输入车辆维修费用" value="${expense.expenseFix}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">日常支出</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseDaily" lay-verify="number" placeholder="请输入日常支出金额" value="${expense.expenseDaily}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">支出时间</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseTime" id="expenseTime" lay-verify="time" placeholder="请输入支出时间" value="${expense.expenseTime}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">支出站点</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseStaId" lay-verify="required" placeholder="请输入支出站点" value="${expense.expenseStaId}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">经手人</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expenseHendler" lay-verify="required" placeholder="请输入经手人" value="${expense.expenseHendler}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">支出总额</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input expanseTotal" lay-verify="number" placeholder="请输入支出总额" value="${expense.expanseTotal}">
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
			$.post("/expenseUpdate",{
				expenseId : ${expense.expenseId},
				expenseSalary : $(".expenseSalary").val(),  //员工工资
				expenseFix : $(".expenseFix").val(),  //维修费用
				expenseDaily : $(".expenseDaily").val(),  //日常支出
				expenseTime : $(".expenseTime").val(),  //支出时间
				expenseStaId : $(".expenseStaId").val(),  //支出站点
				expenseHendler : $(".expenseHendler").val(),  //经手人
				expanseTotal : $(".expanseTotal").val(),  //支出总额
			},function(res){

			});
			setTimeout(function(){
				top.layer.close(index);
				top.layer.msg("支出信息添加成功！");
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
