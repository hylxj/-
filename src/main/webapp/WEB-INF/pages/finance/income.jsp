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
					<input type="text" class="layui-input searchVal" placeholder="请输入车牌号" />
				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加收入信息</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="newsList" lay-filter="newsList"></table>

	<!--操作-->
	<script type="text/html" id="newsListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
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

		//信息列表
		var tableIns = table.render({
			elem: '#newsList',
			url : 'income',
			page : true,
			height : "full-125",
			limit : 10,
			limits : [5,10,15,20],
			id : "newsListTable",
			cols : [[
				{type: "checkbox", fixed:"left", width:50},
				{field: 'incomeId', title: 'ID', width:60, align:"center"},
				{field: 'busPlate', title: '车牌号', align:'center'},
				{field: 'incomeTime', title: '车辆收入结算时间', align:'center',templet:function (d) {
						return formatDate(new Date(d.incomeTime));
					}},
				{field: 'incomeCash', title: '现金收入',  align:'center'},
				{field: 'incomeOnline', title: '线上收入', align:'center'},
				{field: 'incomeCard', title: '刷卡收入', align:'center'},
				{field: 'incomedayTotal', title: '每日总额', align:'center'},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
			]]
		});

		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("newsListTable",{
					url : "incomeSel", //搜索接口
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						busPlate: $(".searchVal").val()  //搜索的关键字
					}
				})
			}else{
				layer.msg("请输入车牌号");
			}
		});

		//添加收入信息
		function addNews(edit){
			var index = layui.layer.open({
				title : "添加收入信息",
				type : 2,
				content : "/incomeAddPage",
				success : function(layero, index){
					// var body = layui.layer.getChildFrame('body', index);
					// if(edit){
					// 	body.find(".newsName").val(edit.newsName);
					// 	body.find(".abstract").val(edit.abstract);
					// 	body.find(".thumbImg").attr("src",edit.newsImg);
					// 	body.find("#news_content").val(edit.content);
					// 	body.find(".newsStatus select").val(edit.newsStatus);
					// 	body.find(".openness input[name='openness'][title='"+edit.newsLook+"']").prop("checked","checked");
					// 	body.find(".newsTop input[name='newsTop']").prop("checked",edit.newsTop);
					// 	form.render();
					// }
					setTimeout(function(){
						layui.layer.tips('点击此处返回收入列表', '.layui-layer-setwin .layui-layer-close', {
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
		$(".addNews_btn").click(function(){
			addNews();
		})

		//批量删除
		$(".delAll_btn").click(function(){
			var checkStatus = table.checkStatus('newsListTable'),
					data = checkStatus.data,
					newsId = [];
			if(data.length > 0) {
				for (var i in data) {
					newsId.push(data[i].incomeId);
				}
				layer.confirm('确定删除选中的信息？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("incomeDels",{
					    ids : newsId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除的信息");
			}
		})

		//列表操作
		table.on('tool(newsList)', function(obj){
			var layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				var index = layui.layer.open({
					title : "编辑收入信息",
					type : 2,
					content : "/incomeUpdatePage?id="+data.incomeId,
					success : function(layero, index) {
						// var body = layui.layer.getChildFrame('body', index);
						// if(edit){
						// 	body.find(".newsName").val(edit.newsName);
						// 	body.find(".abstract").val(edit.abstract);
						// 	body.find(".thumbImg").attr("src",edit.newsImg);
						// 	body.find("#news_content").val(edit.content);
						// 	body.find(".newsStatus select").val(edit.newsStatus);
						// 	body.find(".openness input[name='openness'][title='"+edit.newsLook+"']").prop("checked","checked");
						// 	body.find(".newsTop input[name='newsTop']").prop("checked",edit.newsTop);
						// 	form.render();
						// }
						setTimeout(function () {
							layui.layer.tips('点击此处返回收入列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						}, 500)
					}
				})
				layui.layer.full(index);//窗口铺满
			} else if(layEvent === 'del'){ //删除
				layer.confirm('确定删除此信息？',{icon:3, title:'提示信息'},function(index){
					$.get("incomeDel",{
					    id : data.incomeId //将需要删除的newsId作为参数传入
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