<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="../404.jsp" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>机构已分配角色列表</title>
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
				<a class="layui-btn layui-btn-normal addBusCen_btn">添加角色</a>
			</div>
		</form>
	</blockquote>
	<table id="busCenList" lay-filter="busCenList"></table>

	<!--操作-->
	<script type="text/html" id="busCenListBar">
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
		//角色列表
		let tableIns = table.render({
			elem: '#busCenList',
			url : '/busCen/busCenRoleList?buscenId=${buscenId}',
			height:480,
            page: true,
			limit:5,
			limits:[5,10],
            title: '已分配角色表',
			id : "busCenListTable",
			cols : [[
				{field: 'roleId', title: 'ID', align:"center"},
				{field: 'roleName', title: '角色名称',align:'center'},
				{field: 'roleDesc',width:400, title: '角色描述', align:'center'},
				{field: 'available', title: '角色状态', align:'center', templet:function(d){
						return d.available==0?"锁定":"正常";
				}},
				{title: '操作', width:200, templet:'#busCenListBar',fixed:"right",align:"center"}
			]]
		});

		//添加角色
		$(".addBusCen_btn").click(function(){
			let index = layui.layer.open({
				title : "添加角色",
				type : 2,
				offset: 'auto',
				area: ['500px', '300px'],
				content : "/busCen/busCenRoleAddPage?buscenId=${buscenId}"
			})
		})

		//列表操作
		table.on('tool(busCenList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'status'){
				layer.confirm("是否确定取消授权此角色？",{
					icon: 3,
					title:'系统提示',
					cancel : function(index){
						layer.close(index);
					}
				},function(index){
					$.get("/busCen/deleteRoleByBusCenId",{
						buscenId:${buscenId},
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
