<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
				<a class="layui-btn layui-btn-normal addRole_btn">添加用户</a>
			</div>
		</form>
	</blockquote>
	<table id="roleList" lay-filter="roleList"></table>

	<!--操作-->
	<script type="text/html" id="roleListBar">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="status">取消授权</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','table'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				table = layui.table;
		//用户列表
		let tableIns = table.render({
			elem: '#roleList',
			url : '/role/roleUserList?roleId=${roleId}',
			height:480,
            page: true,
			limit:5,
			limits:[5,10],
            title: '已分配用户表',
			id : "roleListTable",
			cols : [[
				{field: 'id', title: 'ID', align:"center"},
				{field: 'username', title: '用户名称',align:'center'},
				{field: 'userDesc',width:400, title: '用户描述', align:'center'},
				{field: 'locked', title: '用户状态', align:'center', templet:function(d){
						return d.locked==0?"锁定":"正常";
				}},
				{title: '操作', width:200, templet:'#roleListBar',fixed:"right",align:"center"}
			]]
		});

		//添加用户
		$(".addRole_btn").click(function(){
			let index = layui.layer.open({
				title : "添加用户",
				type : 2,
				offset: 'auto',
				area: ['500px', '300px'],
				content : "/role/roleUserAddPage?roleId=${roleId}"
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
					$.get("/role/deleteUserByRoleId",{
						roleId:${roleId},
						userId:data.id
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
