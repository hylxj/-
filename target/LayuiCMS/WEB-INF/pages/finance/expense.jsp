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
				<a class="layui-btn layui-btn-normal addNews_btn">添加支出信息</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="newsList" lay-filter="newsList"></table>
	<!--审核状态-->
	<script type="text/html" id="newsStatus">
		{{#  if(d.newsStatus == "1"){ }}
		<span class="layui-red">等待审核</span>
		{{#  } else if(d.newsStatus == "0"){ }}
		<span class="layui-blue">已存草稿</span>
		{{#  } else { }}
			审核通过
		{{#  }}}
	</script>

	<!--操作-->
	<script type="text/html" id="newsListBar">
		<a class="layui-btn layui-btn-xs" lay-event="showDetail">查看详情</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
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
	layui.use(['form','layer','laydate','table','laytpl'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;

		//新闻列表
		let tableIns = table.render({
			elem: '#newsList',
			url : 'expense',
			cellMinWidth : 95,
			page : true,
			height : "full-125",
			limit : 10,
			limits : [5,10,15,20],
			id : "newsListTable",
			cols : [[
				{type: "checkbox", fixed:"left", width:50},
				{field: 'fundOutId', title: 'ID', width:60, hide: true,align:"center"},
				{field: 'type', title: '支出类型', align:'center', templet:function(d){
                        if(d.type==1){
                            return "车辆维修费用";
                        }else if(d.type==2) {
                            return "其他";
                        }
                    }},
				{field: 'fundOutTime', title: '支出时间', align:'center',templet:function (d){
                        if(d.fundOutTime!=null){
                            let date = new Date(d.fundOutTime);
                            let  str = formatDate(date);
                            return str;
                        }
                        return "没有数据";
                    }},

				{field: 'fundOutMoney', title: '支出金额',  align:'center'},
				{field: 'operator', title: '操作人', align:'center'},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
			]]
		});

		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("newsListTable",{
					url : "expenseSel",
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						expenseId: $(".searchVal").val()  //搜索的关键字
					}
				})
			}else{
				layer.msg("请输入查询ID");
			}
		});

		//批量删除
		$(".delAll_btn").click(function(){
			let checkStatus = table.checkStatus('newsListTable'),
					data = checkStatus.data,
					newsId = [];
			if(data.length > 0) {
				for (let i in data) {
					newsId.push(data[i].expenseId);
				}
				layer.confirm('确定删除选中的信息？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("expenseDels",{
						ids : newsId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除收入信息");
			}
		})

		//列表操作
		table.on('tool(newsList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'showDetail'){ //编辑
				let index = layui.layer.open({
					title : "查看收入信息详情",
					type : 2,
					content : "/expenseShowDetail?id="+data.fundOutId,
					success : function(layero, index) {
						setTimeout(function () {
							layui.layer.tips('点击此处返回收入列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						}, 500)
					}
				})
				layui.layer.full(index);//窗口铺满
			} else if(layEvent === 'del'){ //删除
				layer.confirm('确定删除此条信息？',{icon:3, title:'提示信息'},function(index){
					$.get("expenseDel",{
					    id : data.expenseId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				});
			} else if(layEvent === 'look'){ //预览
				layer.alert("此功能需要前台展示，实际开发中传入对应的必要参数进行文章内容页面访问")
			}
		});

	})
</script>
</body>
</html>
