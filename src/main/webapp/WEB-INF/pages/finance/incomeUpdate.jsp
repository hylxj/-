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
					<label class="layui-form-label">车牌号</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busPlate" lay-verify="required" placeholder="请输入车辆车牌号" value="${income.busPlate}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">车辆收入结算时间</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input incomeTime" id="incomeTime" lay-verify="time" placeholder="请输入车辆收入结算时间" value="${income.incomeTime}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">现金收入</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input incomeCash" lay-verify="number" placeholder="请输入现金收入" value="${income.incomeCash}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">线上收入</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input incomeOnline" lay-verify="number" placeholder="请输入线上收入" value="${income.incomeOnline}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">刷卡收入</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input incomeCard" lay-verify="number" placeholder="请输入刷卡收入" value="${income.incomeCard}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">每日总额</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input incomedayTotal" lay-verify="number" placeholder="请输入每日总额" value="${income.incomedayTotal}">
					</div>
				</div>


			<hr class="layui-bg-gray" />
			<div class="layui-right">
				<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe609;</i>提交</a>
				<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-resert><i class="layui-icon">&#xe61c;</i>重置</a>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','layedit','laydate','upload'],function(){
		var form = layui.form
		layer = parent.layer === undefined ? layui.layer : top.layer,
				laypage = layui.laypage,
				upload = layui.upload,
				layedit = layui.layedit,
				laydate = layui.laydate,
				$ = layui.jquery;

		//执行日期时间转换
		laydate.render({
			elem: '#incomeTime' //指定元素
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
			var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			//实际使用时的提交信息
			console.log(data);
			$.post("/incomeUpdate",{
			    incomeId : ${income.incomeId},//id
				busPlate : $(".busPlate").val(),  //车牌号
				incomeTime : $(".incomeTime").val(),  //车辆收入结算时间
				incomeCash : $(".incomeCash").val(),  //现金收入
				incomeOnline : $(".incomeOnline").val(),  //线上收入
				incomeCard : $(".incomeCard").val(),  //刷卡收入
				incomedayTotal : $(".incomedayTotal").val(),  //每日总额
			},function(res){

			});
			setTimeout(function(){
				top.layer.close(index);
				top.layer.msg("收入信息修改成功！");
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