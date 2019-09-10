<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
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
	<div class="layui-col-md9 layui-col-xs12">
		<div class="layui-row layui-col-space10">
			<div class="layui-col-md9 layui-col-xs7">
				<input type="text" class="layui-input busId" lay-verify="busId" style="width: 300px;display: none" placeholder="" value="${bus.busId}" >
				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交车名称</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busName" lay-verify="busName" style="width: 300px" placeholder="" value="${bus.busName}">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">驾驶员</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busDriverId" lay-verify="busDriverId" style="width: 300px" placeholder=""value="${bus.busDriverId}">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">线路</label>
					<div class="layui-input-block">
						<input type="text" class="layui-input busLineId" lay-verify="busLineId" style="width: 300px" placeholder=""value="${bus.busLineId}" >
					</div>
				</div>

				<div class="layui-form-item magt3">
					<label class="layui-form-label">公交车状态</label>
					<div class="layui-input-block">
						<select name="status" lay-verify="">
							<option value="1" ${bus.busStatus==1?"selected":""}>正常</option>
							<option value="2" ${bus.busStatus==2?"selected":""}>维修</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-inline layui-center" style="margin-left: 180px" >
			<a class="layui-btn layui-btn-normal addBus"  lay-filter="addBus" lay-submit>确认</a>
		</div>
		<div class="layui-inline">
			<button type="reset" class="layui-btn layui-btn-danger layui-btn-normal cancel" style="width: 60px">重置</button>
		</div>
	</div>

</form>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    layui.use(['form','layer','layedit','laydate','upload'],function(){
        var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
            laypage = layui.laypage,
            upload = layui.upload,
            layedit = layui.layedit,
            laydate = layui.laydate,
            $ = layui.jquery;
        $(".cancel").on("click",function () {
			layer.close(this);
        })
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
        form.on("submit(addBus)",function(data){
            //弹出loading
            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            // 实际使用时的提交信息
            $.post("/bus/updateBus",{
                busId:$(".busId").val(),
                busName : $(".busName").val(),  //文章摘要
                busDriverId : $(".busDriverId").val(),  //文章摘要
                busLineId : $(".busLineId").val(),  //文章摘要
                busStatus : data.field.status,  //文章摘要

            },function(res){
                setTimeout(function(){
                    if(res.code==200){
                        top.layer.msg("修改数据成功！");
                    }else{
                        top.layer.msg("修改数据失败！");
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