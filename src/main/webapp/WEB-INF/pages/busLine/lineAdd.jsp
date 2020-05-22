<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="../404.jsp" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<form class="layui-form layui-row layui-col-space10" style="width: 500px; margin-left: 300px">
	<div class="layui-col-md9 layui-col-xs12" style="width: 500px">
		<div class="layui-row layui-col-space10">
			<div class="layui-col-md9 layui-col-xs7" style="width: 450px;">
				<input type="text" class="layui-input lineId" lay-verify="lineId" style="width: 300px;display: none" placeholder="" value="${bus.busId}" >
				<div class="layui-form-item magt3">
					<label class="layui-form-label">线路的名称</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input lineName" lay-verify="lineName" style="width: 300px" placeholder="">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">运行时间</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input lineTime" lay-verify="lineTime" style="width: 300px" placeholder="">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">票价</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input linePrice" lay-verify="busDriverId" style="width: 300px" placeholder="">
					</div>
				</div>
				<div class="layui-form-item magt3" style="position: relative">
					<label class="layui-form-label">站点添加</label>
					<div class="layui-input-block" style="width: 150px">
						<select name="station" lay-verify="" style="width: 50px" lay-search>
							<option value="">选择站台</option>
							<c:forEach items="${stationList}" var="station">
								<option value="${station.staId}">${station.staName}</option>
							</c:forEach>
						</select>
					</div>
					<%--<a class="layui-btn layui-btn-normal  " id="addStation"  lay-filter="" style="position: absolute; right:28px;top: 0;">添加站台</a>--%>
				</div>
				<div class="layui-form-item magt3" id="showSta" style="border: 1px silver solid;height: 100px"></div>
			</div>
		</div>
		<div class="layui-inline layui-center" style="margin-left: 150px" >
			<a class="layui-btn layui-btn-normal addLine"  lay-filter="addLine" lay-submit>添加线路</a>
		</div>
		<div class="layui-inline">
			<button type="reset" class="layui-btn layui-btn-danger layui-btn-normal delAll_btn" style="width: 90px">重置</button>
		</div>
	</div>

</form>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    layui.use('laydate', function(){
        let laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '.busCreateTime' //指定元素
			,format:'yyyy/MM/dd'
        });
    });
</script>
<script>

    layui.use(['form','layer','layedit','laydate','upload'],function(){
        let form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
            laypage = layui.laypage,
            upload = layui.upload,
            layedit = layui.layedit,
            laydate = layui.laydate,
            $ = layui.jquery;

        form.verify({
            busPlate : function(val){
                if(val == ''){
                    return "车牌号不能为空";
                }
            },
            busName : function(val){
                if(val == ''){
                    return "公交车名称不能为空";
                }
            }
        })
        let staString = "" ;
		//获取下拉框的值

            form.on("select",function (data) {
                let sta = parseInt(data.value);
                staString =staString+sta +",";
                $("#showSta").append(data.elem[data.elem.selectedIndex].text+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                console.log(staString);
        })

        form.on("submit(addLine)",function(data){
            //弹出loading
            let index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            staString = staString.substring(0,staString.length-1);
            console.log(staString);
            // 实际使用时的提交信息
            $.post("/busLine/addLine",{
                lineName : $(".lineName").val(),  //文章标题
                lineTime : $(".lineTime").val(),  //文章摘要
                linePrice : $(".linePrice").val(),  //文章摘要
                lineStation : staString

            },function(res){
                setTimeout(function(){
                    if(res.code==200){
                        top.layer.msg(res.msg);
                    }else{
                        top.layer.msg(res.msg);
                    }
                    top.layer.close(index);
                    layer.closeAll("iframe");
                    //刷新父页面
                    parent.location.reload();
                },500);
            })
	            return false;
        })
    })
</script>
</html>
