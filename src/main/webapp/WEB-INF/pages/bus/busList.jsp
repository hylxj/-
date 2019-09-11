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
				<a class="layui-btn layui-btn-normal addNews_btn">添加车辆</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
			<div class="layui-upload layui-inline">
				<input type="file" id="fileUpload" class="layui-btn" value="Excel导入">
				<a class="layui-btn layui-btn-normal " href="/bus/excelExport">Excel导出</a>
			</div>
		</form>
	</blockquote>
	<table id="newsList" lay-filter="newsList"></table>


	<!--操作-->
	<script type="text/html" id="newsListBar">
		<a class="layui-btn layui-btn-xs editBus" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
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
    var idandname;//全局变量 驾驶员姓名
    var lineN;//全局变量 线路的名称

    layui.use(['form','layer','laydate','table','laytpl'],function(){
		var form = layui.form,
				layer = parent.layer === undefined ? layui.layer : top.layer,
				$ = layui.jquery,
				laydate = layui.laydate,
				laytpl = layui.laytpl,
				table = layui.table;
        $.ajax({
			url:"/bus/findDriverName",
            async:false,
			success:function (data) {
                idandname = data.data;
            }
        });
        $.ajax({
            url:"/bus/findLineName",
            async:false,
            success:function (data) {
                lineN = data.data;
            }
        });
        console.log(idandname);
		//公交车列表
		var tableIns = table.render({
			elem: '#newsList',
			url : '/bus/tableData',
			cellMinWidth : 95,
			page : true,
			height : "full-125",
			limit : 5,
			limits : [5,10,15],
			id : "newsListTable",
			cols : [[
			    {type: "checkbox", fixed:"left", width:50},
				{field: "busId", title:"ID", width:50,hide:true},
				{field: 'busPlate', title: '车牌号', width:150, align:"center"},
				{field: 'busName', title: '公交车名称', width:100},
				{field: 'busDriverId', title: '驾驶员', align:'center',templet:function (d) {
							return idandname[d.busDriverId];
                    }},
				{field: 'busLineId', title: '线路',  align:'center',templet:function(d){
							return lineN[d.busLineId];
					}},
				{field: 'busCreateTime', title: '公交车服役时间', align:'center',templet:function (d) {
						if(d.busCreateTime!=null){
						    var date = new Date(d.busCreateTime);
						    var  str = formatDate(date);
						    return str;
						}
						return "没有数据";
                    }},
				{field: 'busStatus', title: '公交车的状态', align:'center', templet:function(d){
						if(d.busStatus==1){
						    return "正常";
						}else {
						    return "维修";
						}
					}},
				{title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
			]]
		});


		//搜索【此功能需要后台配合，所以暂时没有动态效果演示】
		$(".search_btn").on("click",function(){
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
				layer.msg("请输入搜索的内容");
			}
		});

		//添加车辆

		//增加车辆
		$(".addNews_btn").click(function(){
                var index = layui.layer.open({
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
        //修改车辆
        $(".editBu").click(function(){
            var index = layui.layer.open({
                title : "添加车辆",
                type : 2,
                content : "/bus/editPage",
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
			var checkStatus = table.checkStatus('newsListTable'),
				data = checkStatus.data,
                busIds = [];
			if(data.length > 0) {
				for (var i in data) {
                    busIds.push(data[i].busId);
				}
				console.log(busIds);
				layer.confirm('确定删除选中的车辆？', {icon: 3, title: '提示信息'}, function (index) {
					$.get("/bus/delAll",{
                        ids : busIds  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				})
			}else{
				layer.msg("请选择需要删除的公交车");
			}
		})

		//列表操作
		table.on('tool(newsList)', function(obj){
			var layEvent = obj.event,
					data = obj.data;

			if(layEvent === 'edit'){ //编辑
                var index = layui.layer.open({
                    title : "修改车辆",
                    type : 2,
                    content : "/bus/editPage?id="+data.busId,
                    success : function(){
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
			} else if(layEvent === 'del'){ //删除
				layer.confirm('确定删除此公交车吗？',{icon:3, title:'提示信息'},function(index){
					$.get("/bus/del",{
					    busId : data.busId  //将需要删除的newsId作为参数传入
					},function(data){
					tableIns.reload();
					layer.close(index);
					})
				});
			} else if(layEvent === 'look'){ //预览
				layer.alert("此功能需要前台展示，实际开发中传入对应的必要参数进行文章内容页面访问")
			}
		});
		//文件上传
        $("#fileUpload").change(function () {
            var fileData = this.files[0];
            var formData = new FormData();
            formData.append("upload",fileData);
            $.ajax({
                type:"POST",
                url:'/bus/fileUpload',
                data:formData,
                cache:false,//不缓存
                processData:false,
                contentType:false,
                dataType:'json',
                success:function (data) {
                    layer.msg(data.msg,{icon:1});
                }
            })
        })
	})


</script>
</body>
</html>