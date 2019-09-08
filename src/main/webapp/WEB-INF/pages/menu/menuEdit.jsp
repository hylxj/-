<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>菜单编辑</title>
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
		<label class="layui-form-label">菜单名称</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input title" lay-verify="required" placeholder="请输入菜单名称" value="${menu.title}">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">上级目录</label>
		<div class="layui-input-block">
			<input type="text" placeholder="请输入上级目录" lay-verify="required" class="layui-input parentId" value="${menu.parentId}">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
        <label class="layui-form-label">菜单图标</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input icon" lay-verify="required" placeholder="请输入菜单图标" value="">
        </div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<label class="layui-form-label">菜单地址</label>
		<div class="layui-input-block">
			<input type="text" class="layui-input href" lay-verify="required" placeholder="请输入菜单地址">
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-xs12">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="editMenu">立即更新</button>
			<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
		</div>
	</div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer'],function(){
		var form = layui.form,
		layer = parent.layer === undefined ? layui.layer : top.layer,
		$ = layui.jquery;

		form.on("submit(editMenu)",function(data){
			//弹出loading
			var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			// 实际使用时的提交信息
			$.post("/menu/updateMenu",{
				menuId:${menu.menuId},
				title : $(".title").val(),
				parentId : $(".parentId").val(),
				href:$(".href").val()
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