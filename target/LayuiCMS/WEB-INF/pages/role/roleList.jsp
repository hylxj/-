<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="../404.jsp" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>角色列表</title>
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
				<div class="layui-input-inline">
					<input type="text" class="layui-input searchVal" placeholder="请输入搜索的内容" />
				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addRole_btn">添加角色</a>
			</div>
		</form>
	</blockquote>
	<table id="roleList" lay-filter="roleList"></table>

	<!--操作-->
	<script type="text/html" id="roleListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-green" lay-event="distributed">已分配菜单</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
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
			url : '/role/roleList',
			height:480,
            page: true,
			limit:5,
			limits:[5,10],
            title: '角色表',
			id : "roleListTable",
			cols : [[
				{field: 'roleId', title: 'ID', align:"center"},
				{field: 'roleName', title: '角色名称',align:'center'},
				{field: 'roleDesc',width:400, title: '角色描述', align:'center'},
				{field: 'available', title: '是否禁用', align:'center', templet:function(d){
						let status=d.available==1?"":"checked";
						return '<input type="checkbox" name="available" lay-filter="available" lay-skin="switch" lay-text="是|否" '+status+'>'
				}},
				{title: '操作', width:200, templet:'#roleListBar',fixed:"right",align:"center"}
			]]
		});
		//是否锁定
		form.on('switch(available)', function(data){
			let isAvailable;
			if(data.elem.checked){
				isAvailable=0;
			}else {
				isAvailable=1;
			}
			let roleId=$(this).parents("tr").children("td[data-field=roleId]").children()[0].innerText;
			let index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
			$.get("/role/updateRole",{
				roleId:roleId,
				available:isAvailable
			},function () {
				layer.close(index);
				if(data.elem.checked){
					layer.msg("禁用成功！");
				}else{
					layer.msg("取消禁用成功！");
				}
			});
		});
		//搜索
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("roleListTable",{
					url:"/role/search",
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						key: $(".searchVal").val()  //搜索的关键字
					}
				})
			}else{
				layer.msg("请输入搜索的内容");
			}
		});

		//添加角色
		$(".addRole_btn").click(function(){
			let index = layui.layer.open({
				title : "添加角色",
				type : 2,
				content : "/role/roleAddPage",
				success : function(){
					setTimeout(function(){
						layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})
			layui.layer.full(index);
			//改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
			$(window).on("resize",function(){
				layui.layer.full(index);
			})
		})

		//列表操作
		table.on('tool(roleList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				let index = layui.layer.open({
					title : "编辑角色",
					type : 2,
					content : "/role/roleEditPage?roleId="+data.roleId,
					success : function(){
						setTimeout(function(){
							layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})
				layui.layer.full(index);
				//改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
				$(window).on("resize",function(){
					layui.layer.full(index);
				})
			} else if(layEvent === 'del'){ //删除
				layer.confirm('确定删除此角色？',{icon:3, title:'删除角色'},function(index){
					$.get("/role/delRole",{
						roleId : data.roleId  //将需要删除的Id作为参数传入
					},function(data){
						layer.msg(data.msg);
                        tableIns.reload();
                        layer.close(index);
					})
				});
			}else if(layEvent === 'distributed'){
				let index = layui.layer.open({
					title : "已分配菜单",
					type : 2,
					content : "/role/roleMeanPage?roleId="+data.roleId,
					success : function(){
						setTimeout(function(){
							layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})
				layui.layer.full(index);
				//改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
				$(window).on("resize",function(){
					layui.layer.full(index);
				})
			}
		});

	})
</script>
</body>
</html>
