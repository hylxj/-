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
<form class="layui-form layui-row layui-col-space10" style="width: 500px; margin-left: 500px">
	<div class="layui-col-md9 layui-col-xs12">
		<div class="layui-row layui-col-space10">
			<div class="layui-col-md9 layui-col-xs7">
				<input type="text" class="layui-input busId" lay-verify="busId" style="width: 300px;display: none" placeholder="" value="${harmBus.get("busId")}" >
				<input type="text" class="layui-input fixId" lay-verify="fixId" style="width: 300px;display: none" placeholder="" value="${harmBus.get("fixId")}" >
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">公交车名称</label>
                    <div class="layui-input-block">
                        <input type="text" disabled="true" class="layui-input busName" lay-verify="busName" style="width: 300px" placeholder="" value="${harmBus.get("busName")}">
                    </div>
                </div>
                <div class="layui-form-item magt3">
					<label class="layui-form-label">车牌号</label>
					<div class="layui-input-block">
						<input type="text" disabled="true" class="layui-input busPlate" lay-verify="busPlate" style="width: 300px" placeholder="" value="${harmBus.get("busPlate")}">
					</div>
				</div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">驾驶员</label>
                    <div class="layui-input-block">
                        <select name="driver" value="${bus.busDriverId}" lay-verify="" disabled="true">
                            <c:forEach  items="${driverName}" var="dName" >
                                <option value="${dName.id}" ${bus.busDriverId == dName.id ?"selected":""}>${dName.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">线路</label>
                    <div class="layui-input-block">
                        <select name="line" lay-verify="" style="" disabled="true">
                            <c:forEach  items="${lineName}" var="lName" >
                                <option value="${lName.id}"  ${bus.busLineId == lName.id ?"selected":""} >${lName.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">维修原因</label>
                    <div class="layui-input-block">
                        <input type="textarea" disabled="true" class="layui-input fixReason" lay-verify="fixReason" style="width: 300px" placeholder="" value="${harmBus.get("fixReason")}">
                    </div>
                </div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">报修时间</label>
                    <div class="layui-input-block">
                        <input type="textarea" disabled="true" class="layui-input harmTime" lay-verify="harmTime" style="width: 300px" placeholder="" value="${harmBus.get("fixtime")}">
                    </div>
                </div>
                <div class="layui-form-item magt3">
                    <label class="layui-form-label">花费金额</label>
                    <div class="layui-input-block">
                        <input type="textarea" class="layui-input fixMoney" lay-verify="fixMoney" style="width: 300px" placeholder="" value="">
                    </div>
                </div>
			</div>
		</div>
		<div class="layui-inline layui-center" style="margin-left: 180px" >
			<a class="layui-btn layui-btn-normal fixBus"  lay-filter="fixBus" lay-submit>确认</a>
		</div>
		<div class="layui-inline">
			<button type="reset" class="layui-btn layui-btn-danger layui-btn-normal cancel" style="width: 60px">取消</button>
		</div>
	</div>

</form>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    layui.use(['form','layer','layedit','laydate','upload'],function(){
        let form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
            laypage = layui.laypage,
            upload = layui.upload,
            layedit = layui.layedit,
            laydate = layui.laydate,
            $ = layui.jquery;
        $(".cancel").on("click",function () {
            // top.layer.close(index);
            layer.closeAll("iframe");
            //刷新父页面
            parent.location.reload();
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
        form.on("submit(fixBus)",function(data){
            //弹出loading
            let index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            // 实际使用时的提交信息
            console.log(data);
            $.post("/fix/addFixBusLog",{
                busId:$(".busId").val(),
                fixId:$(".fixId").val(),
                fixMoney:$(".fixMoney").val(),

            },function(res){

                layer.msg("维修车辆成功", {
                    icon: 1,
                    time: 5000
                }, function(){
                    layer.closeAll("iframe");
                    //刷新父页面
                    parent.location.reload();
                });
                top.layer.close(index);
            })

            return false;
        })


    })
</script>
</html>
