<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>菜单列表</title>
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
				<a class="layui-btn layui-btn-normal addMenu_btn">添加菜单</a>
			</div>
		</form>
	</blockquote>
	<table id="menuList" lay-filter="menuList"></table>

	<!--操作-->
	<script type="text/html" id="menuListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-green" lay-event="distributed">已分配角色</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','layer','table'],function(){
		var form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				table = layui.table;
		//用户列表
		var tableIns = table.render({
			elem: '#menuList',
			url : '/menu/menuList',
			height:480,
            page: true,
			limit:10,
			limits:[5,10],
            title: '菜单表',
			id : "menuListTable",
			cols : [[
				{field: 'menuId', title: 'ID', align:"center"},
				{field: 'parentId', title: '父级菜单', align:'center'},
				{field: 'title', title: '菜单名称',align:'center'},
				{field: 'icon', title: '菜单图标',align:'center',templet:function(d){
					return '<i class="layui-icon" data-icon="'+d.icon+'">'+d.icon+'</i>';
				}},
				{field: 'href', title: '菜单地址',align:'center'},
				{field: 'spread', title: '默认展开',align:'center',templet:function(d){
					return d.spread==1?"展开":"收起";
				}},
				{field: 'available', title: '是否禁用', align:'center', templet:function(d){
						var status=d.available==1?"":"checked";
						return '<input type="checkbox" name="available" lay-filter="available" lay-skin="switch" lay-text="是|否" '+status+'>'
				}},
				{title: '操作', width:200, templet:'#menuListBar',fixed:"right",align:"center"}
			]]
		});
		//是否锁定
		form.on('switch(available)', function(data){
			var isAvailable;
			if(data.elem.checked){
				isAvailable=2;
			}else {
				isAvailable=1;
			}
			var menuId=$(this).parents("tr").children("td[data-field=menuId]").children()[0].innerText;
			var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
			$.get("/menu/updateMenu",{
				menuId:menuId,
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
				table.reload("menuListTable",{
					url:"/menu/search",
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

		//添加菜单
		$(".addMenu_btn").click(function(){
			var index = layui.layer.open({
				title : "添加菜单",
				type : 2,
				content : "/menu/menuAddPage",
				success : function(){
					setTimeout(function(){
						layui.layer.tips('点击此处返回菜单列表', '.layui-layer-setwin .layui-layer-close', {
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
		table.on('tool(menuList)', function(obj){
			var layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				var index = layui.layer.open({
					title : "编辑菜单",
					type : 2,
					content : "/menu/menuEditPage?menuId="+data.menuId,
					success : function(){
						setTimeout(function(){
							layui.layer.tips('点击此处返回菜单列表', '.layui-layer-setwin .layui-layer-close', {
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
				layer.confirm('确定删除此菜单？',{icon:3, title:'删除菜单'},function(index){
					$.get("/menu/delMenu",{
						menuId : data.menuId  //将需要删除的Id作为参数传入
					},function(data){
						layer.msg(data.msg);
                        tableIns.reload();
                        layer.close(index);
					})
				});
			}else if(layEvent === 'distributed'){ //删除
				var index = layui.layer.open({
					title : "已分配角色",
					type : 2,
					content : "/menu/menuRolePage?menuId="+data.menuId,
					success : function(){
						setTimeout(function(){
							layui.layer.tips('点击此处返回菜单列表', '.layui-layer-setwin .layui-layer-close', {
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