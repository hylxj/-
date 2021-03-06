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
					<input type="text" class="layui-input searchVal" placeholder="请输入司机姓名" />
				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加司机信息</a>
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
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
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
        return y
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
			url : 'driver',
			cellMinWidth : 95,
			page : true,
			height : "full-125",
			limit : 10,
			limits : [5,10,15,20],
			id : "newsListTable",
			cols : [[
				{type: "checkbox", fixed:"left", width:50},
				{field: 'busdriverId', title: 'ID', hide:true,width:60, align:"center"},
				{field: 'busdriverName', title: '姓名', align:'center'},
				{field: 'driverIdCard', title: '身份证号', align:'center'},
				{field: 'busdriverAge', title: '年龄', align:'center'},
				{field: 'busdriverSex', title: '性别',  align:'center',templet: function(d){
				    return d.busdriverSex ===1 ? '男':'女'
                    }},
				{field: 'busdriverPhone', title: '联系方式', align:'center'},
				{field: 'busdriverBusid', title: '驾驶车辆车牌号', align:'center'},
				{field: 'busdriverBelongid', title: '所属调度中心', align:'center'},
				{field: 'busdriverInitime', title: '入职时间(年)', align:'center',width:200,templet: function (d) {
                        if(d.busdriverInitime!=null){
                            let date = new Date(d.busdriverInitime);
                            let now = new Date();
                            let  datePer = formatDate(date);
                            let newYear = formatDate(now)
                            return newYear-datePer;
                        }
                        return "没有数据";
                    }},
				{field: 'busdriverStatus', title: '状态', align:'center',templet: function(d){
				    let status = ''
				    switch (d.busdriverStatus) {
                        case  1:
                            status = '在岗';
                            break;
                        case  2:
                            status = '旷工';
                            break;
                        case  3:
                            status = '请假';
                            break;
                        default:
                            status = '离职';
                            break;
                    }
                    return status
                    }},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
			]]
		});

		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("newsListTable",{
					url : "driverSel",
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						name : $(".searchVal").val()  //搜索的关键字
					}
				})
			}else{
				layer.msg("请输入查询ID");
			}
		});

		//添加司机
		function addNews(edit){
			let index = layui.layer.open({
				title : "添加司机信息",
				type : 2,
				content : "/driverAddPage",
				success : function(layero, index){
					let body = layui.layer.getChildFrame('body', index);
					if(edit){
						body.find(".newsName").val(edit.newsName);
						body.find(".abstract").val(edit.abstract);
						body.find(".thumbImg").attr("src",edit.newsImg);
						body.find("#news_content").val(edit.content);
						body.find(".newsStatus select").val(edit.newsStatus);
						body.find(".openness input[name='openness'][title='"+edit.newsLook+"']").prop("checked","checked");
						body.find(".newsTop input[name='newsTop']").prop("checked",edit.newsTop);
						form.render();
					}
					setTimeout(function(){
						layui.layer.tips('点击此处返回司机列表', '.layui-layer-setwin .layui-layer-close', {
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
			let checkStatus = table.checkStatus('newsListTable'),
					data = checkStatus.data,
					newsId = [];
			if(data.length > 0) {
				for (let i in data) {
					newsId.push(data[i].busdriverId);
				}
				layer.confirm('确定删除选中的信息？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("driverDels",{
						ids : newsId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除司机信息");
			}
		})

		//列表操作
		table.on('tool(newsList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
				let index = layui.layer.open({
					title : "编辑司机信息",
					type : 2,
					content : "/driverUpdatePage?id="+data.busdriverId,
					success : function(layero, index) {
						setTimeout(function () {
							layui.layer.tips('点击此处返回司机列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						}, 500)
					}
				})
				layui.layer.full(index);//窗口铺满
			} else if(layEvent === 'del'){ //删除
				layer.confirm('确定删除此条信息？',{icon:3, title:'提示信息'},function(index){
					$.get("driverDel",{
					    id : data.busdriverId  //将需要删除的newsId作为参数传入
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
