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
				<a class="layui-btn layui-btn-normal addUser_btn">添加用户</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="userList" lay-filter="userList"></table>

	<!--操作-->
	<script type="text/html" id="userListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	/*根据出生日期算出年龄*/
	function jsGetAge(strBirthday) {
		var returnAge;
		var strBirthdayArr = strBirthday.split("-");
		var birthYear = strBirthdayArr[0];
		var birthMonth = strBirthdayArr[1];
		var birthDay = strBirthdayArr[2];

		d = new Date();
		var nowYear = d.getFullYear();
		var nowMonth = d.getMonth() + 1;
		var nowDay = d.getDate();

		if (nowYear == birthYear) {
			returnAge = 0;//同年 则为0岁
		} else {
			var ageDiff = nowYear - birthYear; //年之差
			if (ageDiff > 0) {
				if (nowMonth == birthMonth) {
					var dayDiff = nowDay - birthDay;//日之差
					if (dayDiff < 0) {
						returnAge = ageDiff - 1;
					} else {
						returnAge = ageDiff;
					}
				} else {
					var monthDiff = nowMonth - birthMonth;//月之差
					if (monthDiff < 0) {
						returnAge = ageDiff - 1;
					} else {
						returnAge = ageDiff;
					}
				}
			} else {
				returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
			}
		}

		return returnAge;//返回周岁年龄
	}
	/*date转字符串*/
	function formatDate(date) {
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		m = m < 10 ? ('0' + m) : m;
		var d = date.getDate();
		d = d < 10 ? ('0' + d) : d;
		// var h = date.getHours();
		// var minute = date.getMinutes();
		// minute = minute < 10 ? ('0' + minute) : minute;
		// var second= date.getSeconds();
		// second = minute < 10 ? ('0' + second) : second;
		return y + '-' + m + '-' + d/*+' '+h+':'+minute+':'+ second*/;
	}
	layui.use(['form','layer','laydate','table','laytpl'],function(){
		var form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;
		//用户列表
		var tableIns = table.render({
			elem: '#userList',
			url : '${pageContext.request.contextPath}/user/list',
            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']//自定义分页布局
                    ,limit:5
					,limits:[5,10,15]
                    ,first: true //不显示首页
                    ,last: true //不显示尾页
            },
            title: '用户表',
			id : "userListTable",
			cols : [[
				{type: "checkbox", fixed:"left", width:50},
				{field: 'id', title: 'ID', align:"center"},
				{field: 'username', title: '用户名称',align:'center'},
				{field: 'password', title: '用户密码', align:'center'},
				{field: 'salt', title: '密码盐值',  align:'center'},
				{field: 'locked', title: '是否锁定', align:'center', templet:function(d){
						var status=d.locked==1?"":"checked";
						return '<input type="checkbox" name="locked" lay-filter="locked" lay-skin="switch" lay-text="是|否" '+status+'>'
				}},
				{field:'birthday',title:'年龄',align:'center',templet:function (d) {
					if (d.birthday != null) {
						var date=new Date(d.birthday);
						var str=formatDate(date);
						return jsGetAge(str);
					}
					return "没有数据";
				}},
				{field:'sex',title:'性别',align:'center',templet:function(d){
					var sex='保密';
					if (d.sex==1){
						sex='男';
					} else if(d.sex==2){
						sex='女';
					}
					return sex;
				}},
				{field:'phone',title:'电话',minWidth:150,align:'center'},
				{field:'type',title:'员工类型',align:'center'},
				{field:'belongId',title:'所属总站',align:'center'},
				{title: '操作', width:120, templet:'#userListBar',fixed:"right",align:"center"}
			]]
		});
		//是否锁定
		form.on('switch(locked)', function(data){
			var isLocked;
			if(data.elem.checked){
				isLocked=0;
			}else {
				isLocked=1;
			}
			var userId=$(this).parents("tr").children("td[data-field=id]").children()[0].innerText;
			var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
			$.get("/user/updateLocked",{
				id:userId,
				isLocked:isLocked
			},function () {
				layer.close(index);
				if(data.elem.checked){
					layer.msg("锁定成功！");
				}else{
					layer.msg("取消锁定成功！");
				}
			});
		});
		//搜索
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("userListTable",{
					url:"/user/search",
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

		//添加用户
		$(".addUser_btn").click(function(){
			var index = layui.layer.open({
				title : "添加用户",
				type : 2,
				content : "/user/userAddPage",
				success : function(){
					setTimeout(function(){
						layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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

		//批量删除
		$(".delAll_btn").click(function(){
			var checkStatus = table.checkStatus('userListTable'),
					data = checkStatus.data,
					userId = [];
			if(data.length > 0) {
				for (var i in data) {
					userId.push(data[i].id);
				}
				layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("/user/batchDelUser",{
					    userId :userId  //将需要删除的userId作为参数传入
					},function(data){
						layer.msg(data.msg);
						tableIns.reload();
						layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除的用户");
			}
		})

		//列表操作
		table.on('tool(userList)', function(obj){
			var layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				var index = layui.layer.open({
					title : "编辑用户",
					type : 2,
					content : "/user/userEditPage?id="+data.id,
					success : function(){
						setTimeout(function(){
							layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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
				layer.confirm('确定删除此用户？',{icon:3, title:'删除用户'},function(index){
					$.get("/user/delUser",{
					    id : data.id  //将需要删除的Id作为参数传入
					},function(data){
						layer.msg(data.msg);
                        tableIns.reload();
                        layer.close(index);
					})
				});
			}
		});

	})
</script>
</body>
</html>