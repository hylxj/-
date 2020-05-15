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
				<a class="layui-btn layui-btn-normal addRole_btn">添加角色</a>
			</div>
		</form>
	</blockquote>
	<table id="roleList" lay-filter="roleList"></table>

	<!--操作-->
	<script type="text/html" id="roleListBar">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="status">删除角色</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','table'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				table = layui.table;
		//角色列表
		let tableIns = table.render({
			elem: '#roleList',
			url : '${pageContext.request.contextPath}/user/roleUserList?id=${id}',
			height:480,
            page: true,
			limit:5,
			limits:[5,10],
            title: '已分配角色表',
			id : "roleListTable",
			cols : [[
				{field: 'roleId', title: 'ID',hide:true, align:"center"},
				{field: 'roleName', title: '角色名称',align:'center'},
				{field: 'roleDesc',width:400, title: '角色描述', align:'center'},
				{field: 'available', title: '角色状态', align:'center', templet:function(d){
						return d.available==='1'?"正常":"锁定";
				}},
				{title: '操作', width:200, templet:'#roleListBar',fixed:"right",align:"center"}
			]]
		});

		//添加用户
		$(".addRole_btn").click(function(){
			let index = layui.layer.open({
				title : "添加角色",
				type : 2,
				offset: 'auto',
				area: ['500px', '300px'],
				content : "/user/roleUserAddPage?userId=${id}"
			})
		})

		//列表操作
		table.on('tool(roleList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'status'){
				layer.confirm("是否确定删除该用户赋予的角色？",{
					icon: 3,
					title:'系统提示',
					cancel : function(index){
						layer.close(index);
					}
				},function(index){
					$.get("/user/deleteUserByRoleId",{
                        userId:${id},
						roleId:data.roleId
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
