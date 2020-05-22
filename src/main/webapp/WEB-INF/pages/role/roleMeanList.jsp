<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="../404.jsp" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>角色已分配用户列表</title>
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
<form class="layui-form">
	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form">
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addRole_btn">添加菜单</a>
			</div>
		</form>
	</blockquote>
	<table id="roleList" lay-filter="roleList"></table>

	<!--操作-->
	<script type="text/html" id="roleListBar">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="status">删除授权</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','table'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				table = layui.table;
		//菜单列表
		let tableIns = table.render({
			elem: '#roleList',
			url : '/role/roleMeanList?roleId=${roleId}',
			height:480,
            page: true,
			limit:5,
			limits:[5,10],
            title: '已分配菜单表',
			id : "roleListTable",
			cols : [[
				{field: 'menuId', title: 'ID',align:"center"},
				{field: 'parentId', title: '父级菜单ID',align:'center'},
				{field: 'title', title: '菜单名称', align:'center'},
				{field: 'href', title: '菜单地址', align:'center'},
                {field: 'icon', title: '菜单图标',align:'center',templet:function(d){
                        return '<i class="layui-icon" data-icon="'+d.icon+'">'+d.icon+'</i>';
                    }},
                {field: 'spread', title: '默认展开',align:'center',templet:function(d){
                        return d.spread==1?"展开":"收起";
                    }},
                {field: 'available', title: '是否禁用', align:'center', templet:function(d){
                        let status=d.available==1?"":"checked";
                        return '<input type="checkbox" name="available" lay-filter="available" lay-skin="switch" lay-text="是|否" '+status+'>'
                    }},
				{title: '操作', width:200, templet:'#roleListBar',fixed:"right",align:"center"}
			]]
		});

		//添加菜单
		$(".addRole_btn").click(function(){
			let index = layui.layer.open({
				title : "添加菜单",
				type : 2,
				offset: 'auto',
				area: ['500px', '300px'],
				content : "${pageContext.request.contextPath}/role/roleMeanAddPage?roleId=${roleId}"
			})
		})

		//列表操作
		table.on('tool(roleList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'status'){
				layer.confirm("是否确定取消授权此用户？",{
					icon: 3,
					title:'系统提示',
					cancel : function(index){
						layer.close(index);
					}
				},function(index){
					$.get("/role/deleteMeanByRoleId",{
						roleId:${roleId},
						menuId:data.menuId
					},function (data) {
						if (data.code===200){
							layer.msg(data.msg);
							tableIns.reload();
						}else {
							layer.msg("系统出错了");
						}
					});
				});
			}
		});

	})
</script>
</body>
</html>
