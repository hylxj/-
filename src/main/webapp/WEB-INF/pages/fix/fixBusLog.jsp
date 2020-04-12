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
					<input type="text" class="layui-input searchVal" placeholder="请输入公交车的名称" />
				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加维修记录</a>
			</div>
		</form>
	</blockquote>
	<table id="newsList" lay-filter="newsList"></table>


	<!--操作-->
	<script type="text/html" id="newsListBar">
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
    let idandname;//全局变量 驾驶员姓名
    let lineN;//全局变量 线路的名称

    layui.use(['form','layer','laydate','table','laytpl','upload'],function(){
		let form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;
		//公交车列表
		let tableIns = table.render({
			elem: '#newsList',
			url : '/fix/fixLogList',
			cellMinWidth : 95,
			page : true,
			height : "full-125",
			limit : 5,
			limits : [5,10,15],
			id : "newsListTable",
			cols : [[
				{field: "harmId", title:"harmId", width:50,hide:true},
				{field: "fixLogId", title:"fixLogId", width:50,hide:true},
				{field: 'busPlate', title: '车牌号', width:150, align:"center"},
				{field: 'busdriverName', title: '驾驶员', align:'center',templet:function (d) {
							return d.busdriverName;
                    }},
				{field: 'lineName', title: '线路',  align:'center'},
				{field: 'fixTime', title: '公交车报修时间', align:'center',templet:function (d) {
						if(d.fixTime!=null){
						    let date = new Date(d.fixTime);
						    let  str = formatDate(date);
						    return str;
						}
						return "没有数据";
                    }},
                {field: 'fixLogTime', title: '公交车维修时间', align:'center',templet:function (d) {
                        if(d.fixLogTime!=null){
                            let date = new Date(d.fixLogTime);
                            let  str = formatDate(date);
                            return str;
                        }
                        return "没有数据";
                    }},
                {field: 'fixReason', title: '报修原因',  align:'center'},
                {field: 'fixer', title: '维修人员',  align:'center'},
                {field: 'fixMoney', title: '维修金额',  align:'center'},
                {field: 'busStatus', title: '公交车的状态', align:'center', templet:function(d){
						if(d.busStatus==1){
                            $("#fixButton").css('display','none')
                            return "正常";
						}else if(d.busStatus==2) {
						    return "待维修";
						}else if(d.busStatus==3) {
                            return "已维修";
                        }else if(d.busStatus==4) {
                            return "报废";
                        }
					}},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
			]]
		});


		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
            console.log($(".search_btn").context.getElementById("fixButton"));
            if($(".searchVal").val() != ''){
				table.reload("newsListTable",{
				    url:'/bus/search',
					page: {
						curr: 1 //重新从第 1 页开始
					},
					where: {
						key: $(".searchVal").val()  //搜索的关键字
					}
				})
			}else{
				layer.msg("请输入公交车的名称");
			}
		});


		//增加车辆
		$(".addNews_btn").click(function(){
                let index = layui.layer.open({
                    title : "添加车辆",
                    type : 2,
                    content : "/bus/addPage",
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

		//列表操作
		table.on('tool(newsList)', function(obj){
			let layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'fix'){ //编辑
                let index = layui.layer.open({
                    title : "修理车辆",
                    type : 2,
                    content : "/fix/fixing?id="+data.fixId,
                    success : function(){
                        setTimeout(function(){
                            layui.layer.tips('点击此处返回维修信息列表', '.layui-layer-setwin .layui-layer-close', {
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
				layer.confirm('确定删除此维修记录吗？',{icon:3, title:'提示信息'},function(index){
					$.get("/fix/del",{
					    busId : data.busId  //将需要删除的newsId作为参数传入
					},function(res){
                        setTimeout(function(){
                            if(res.code==200){
                                top.layer.msg("删除数据成功！");
                            }else{
                                top.layer.msg("删除数据失败！");
                            }
                            tableIns.reload();
                            layer.close(index);
                        },500);
                    })
				});
			}
		});
	})


</script>
</body>
</html>
