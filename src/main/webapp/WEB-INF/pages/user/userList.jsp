<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/public.css" media="all" />
	<style>
		#treeDiv{
			float: left;
			padding: 100px 0px;
			width: 180px;
		}
		#layui-table-page1{
			margin-left: 200px;
		}
	</style>
</head>
<body class="childrenBody">
<div id="treeDiv"></div>
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
            <shiro:hasRole name="admin">
                <div class="layui-inline">
                    <a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
                </div>
            </shiro:hasRole>
		</form>
	</blockquote>
	<table id="userList" lay-filter="userList"></table>

	<!--操作-->
	<script type="text/html" id="userListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-xs layui-btn-green" lay-event="distributed">已分配角色</a>
        <shiro:hasRole name="admin">
            <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
        </shiro:hasRole>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
	/*根据出生日期算出年龄*/
	function jsGetAge(strBirthday) {
		let returnAge;
		let strBirthdayArr = strBirthday.split("-");
		let birthYear = strBirthdayArr[0];
		let birthMonth = strBirthdayArr[1];
		let birthDay = strBirthdayArr[2];

		d = new Date();
		let nowYear = d.getFullYear();
		let nowMonth = d.getMonth() + 1;
		let nowDay = d.getDate();

		if (nowYear == birthYear) {
			returnAge = 0;//同年 则为0岁
		} else {
			let ageDiff = nowYear - birthYear; //年之差
			if (ageDiff > 0) {
				if (nowMonth == birthMonth) {
					let dayDiff = nowDay - birthDay;//日之差
					if (dayDiff < 0) {
						returnAge = ageDiff - 1;
					} else {
						returnAge = ageDiff;
					}
				} else {
					let monthDiff = nowMonth - birthMonth;//月之差
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
		let y = date.getFullYear();
		let m = date.getMonth() + 1;
		m = m < 10 ? ('0' + m) : m;
		let d = date.getDate();
		d = d < 10 ? ('0' + d) : d;
		// let h = date.getHours();
		// let minute = date.getMinutes();
		// minute = minute < 10 ? ('0' + minute) : minute;
		// let second= date.getSeconds();
		// second = minute < 10 ? ('0' + second) : second;
		return y + '-' + m + '-' + d/*+' '+h+':'+minute+':'+ second*/;
	}
	layui.use(['form','layer','tree','table','laytpl'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				tree = layui.tree,
				laytpl = layui.laytpl,
				table = layui.table;
		//获取菜单树
		function getData(ids){
			let data = [];
			$.ajax({
				url: "/busCen/treeLoad?"+ids,    //后台数据请求地址
				async:false,
				success: function(res){
					data = res;
				}
			});
			return data;
		}
		let ids="";
		<c:forEach items="${roles}" var="role">
			ids+=("roleIds="+${role.roleId})+"&";
		</c:forEach>
		ids=ids.substr(0,ids.length-1);
		//树形图
		let treeIns=tree.render({
			elem:"#treeDiv",
			accordion: true,
			showLine:false,
			isJump:true,
			data:getData(ids)
			,click:function (item) {
				table.reload("userListTable",{
					url:"/user/listByType",
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						type:item.data.id
					}
				})
			}
		});
		//用户列表
		let tableIns = table.render({
			elem: '#userList',
			url : '${pageContext.request.contextPath}/user/list',
			height:480,
            page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']//自定义分页布局
                    ,limit:10
					,limits:[5,10,15]
            },
            title: '用户表',
			id : "userListTable",
			cols : [[
				{type: "checkbox", fixed:"left", width:50},
				{field: 'id', title: 'ID', align:"center",hide:true,width:50},
				{field: 'username', title: '用户名称',align:'center'},
				{field: 'userDesc',width:200, title: '用户描述', align:'center'},
				{field: 'locked', title: '是否锁定', align:'center', templet:function(d){
						let status=d.locked==1?"":"checked";
						return '<input type="checkbox" name="locked" lay-filter="locked" lay-skin="switch" lay-text="是|否" '+status+'>'
				}},
				{field:'birthday',title:'年龄',align:'center',templet:function (d) {
					if (d.birthday != null) {
						let date=new Date(d.birthday);
						let str=formatDate(date);
						return jsGetAge(str);
					}
					return "没有数据";
				}},
				{field:'sex',title:'性别',align:'center',templet:function(d){
					let sex='保密';
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
				{title: '操作', width:200, templet:'#userListBar',fixed:"right",align:"center"}
			]]
		});
		//是否锁定
		form.on('switch(locked)', function(data){
			let isLocked;
			if(data.elem.checked){
				isLocked=0;
			}else {
				isLocked=1;
			}
			let userId=$(this).parents("tr").children("td[data-field=id]").children()[0].innerText;
			let index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
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
			let index = layui.layer.open({
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
			let checkStatus = table.checkStatus('userListTable'),
					data = checkStatus.data,
					userId = [];
			if(data.length > 0) {
				for (let i in data) {
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
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				let index = layui.layer.open({
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
			}else if(layEvent === 'distributed'){
                let index = layui.layer.open({
                    title : "已分配角色",
                    type : 2,
                    content : "/user/roleUserPage?id="+data.id,
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
