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
				<a class="layui-btn layui-btn-normal addNews_btn">添加站点</a>
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
		<a class="layui-btn layui-btn-xs showStation" lay-event="show">查看站台</a>
		<a class="layui-btn layui-btn-xs editBus" lay-event="edit">编辑</a>
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
        return y + '-' + m + '-' + d/*+' '+h+':'+minute+':'+ second*/;
    }

    layui.use(['form','layer','laydate','table','laytpl'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;

		//公交车列表
		let tableIns = table.render({
			elem: '#newsList',
			url : '/BusStation/showLinesTable',
			cellMinWidth : 95,
			page : true,
			height : "full-125",
			limit : 5,
			limits : [5,10,15],
			id : "newsListTable",
			cols : [[
			    {type: "checkbox", fixed:"left", width:50},
				{field: "lineId", title:"ID", width:80,hide:true},
				{field: 'lineName', title: '线路的名称', width:150, align:"center"},
				{field: 'lineTime', title: '线路的时间', width:200,align:"center"},
				{field: 'linePrice', title: '票价', align:'center',width:200},
				{field: 'lineCreatetime', title: '线路的创建时间',width:200, align:'center',templet:function (d) {
                        if(d.lineCreatetime!=null){
                            let date = new Date(d.lineCreatetime	);
                            let  str = formatDate(date);
                            return str;
                        }
                        return "没有数据";
                    }},
				{field: 'lineStatus', title: '线路的状态', align:'center', templet:function(d){
						if(d.lineStatus==1){
						    return "正常";
						}else {
						    return "异常";
						}
					}},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",width:200,align:"center"}
			]]
		});


		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
			if($(".searchVal").val() != ''){
				table.reload("newsListTable",{
				    url:'/busLine/search',
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

		//添加车辆

		//增加线路
		$(".addNews_btn").click(function(){
                let index = layui.layer.open({
                    title : "添加线路",
                    type : 2,
                    content : "/busLine/addPage",
                    success : function(layero, index){
                        setTimeout(function(){
                            layui.layer.tips('点击此处返回线路列表', '.layui-layer-setwin .layui-layer-close', {
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
        //修改线路
        $(".editBus").click(function(){
            let index = layui.layer.open({
                title : "添加车辆",
                type : 2,
                content : "/busLine/editPage",
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回公交车列表', '.layui-layer-setwin .layui-layer-close', {
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
			let checkStatus = table.checkStatus('newsListTable'),
				data = checkStatus.data,
                busIds = [];
			if(data.length > 0) {
				for (let i in data) {
                    busIds.push(data[i].busId);
				}
				alert(busIds);
				layer.confirm('确定删除选中的线路？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("/busLine/delAll",{
                        ids : busIds  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除的文章");
			}
		})

		//列表操作
		table.on('tool(newsList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
                let index = layui.layer.open({
                    title : "修改线路",
                    type : 2,
                    content : "/busLine/editPage?id="+data.lineId,
                    success : function(){
                        setTimeout(function(){
                            layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
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
				layer.confirm('确定删除此线路？',{icon:3, title:'提示信息'},function(index){
					$.get("/busLine/del",{
					    lineId : data.lineId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				});
			} else if(layEvent === 'show'){ //查看站台信息
                let index = layui.layer.open({
                    title : "查看线路站台",
                    type : 2,
                    content : "/busLine/showStaPage?lineName="+data.lineName,
                    success : function(){
                        setTimeout(function(){
                            layui.layer.tips('点击此处返回线路信息列表', '.layui-layer-setwin .layui-layer-close', {
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
