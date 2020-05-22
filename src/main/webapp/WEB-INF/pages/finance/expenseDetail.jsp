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
					<label class="layui-form-label">车牌号</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busPlate" disabled="true" lay-verify="number" value="${map.get('busPlate')}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">线路</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input lineName" disabled="true" lay-verify="number" value="${map.get('lineName')}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交车司机</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busdriverName" disabled="true" lay-verify="number" value="${map.get('busdriverName')}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">报修原因</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input fixReason" id="fixReason" disabled="true" lay-verify="time" value="${map.get('fixReason')}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">报修时间</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input fixtime" disabled="true" lay-verify="required" value="${map.get('fixtime')}">
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">维修人员</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input operator" disabled="true" lay-verify="required" value="${map.get('operator')}">
					</div>
				</div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">维修时间</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input fixLogTime" disabled="true" lay-verify="required" value="${map.get('fixLogTime')}">
                    </div>
                </div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">维修总额</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input fixMoney" disabled="true" lay-verify="number" value="${map.get('fixMoney')}">
					</div>
				</div>


			<hr class="layui-bg-gray" />
			<div class="layui-right">
				<a class="layui-btn layui-btn-sm" lay-filter="close" id="close"><i class="layui-icon">&#xe609;</i>返回</a>
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
        $('#close').click(function () {
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
        })

	});
</script>
</body>
</html>
