<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>角色添加</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form" style="width:80%;">
    <div class="layui-inline" style="margin-top: 50px;">
        <label class="layui-form-label">添加角色</label>
        <div class="layui-input-inline" >
            <select id="roleId" lay-verify="" lay-search>
                <option value="">直接选择或搜索选择</option>
                <c:forEach items="${roles}" var="role">
                    <option value="${role.roleId}">${role.roleName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-xs12" style="margin-top: 50px;">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="addRole">立即添加</button>
            <button type="reset" class="layui-btn layui-btn-sm layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer'], function () {
        let form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery;

        form.on("submit(addRole)", function (data) {
            //弹出loading
            let index = top.layer.msg('数据提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            // 实际使用时的提交信息
            $.post("/busCen/busCenRoleAdd", {
                roleId: $("#roleId").val(),
                buscenId:${buscenId}
            }, function (res) {
                top.layer.close(index);
                if (res.code === 200) {
                    top.layer.msg(res.msg);
                } else {
                    top.layer.msg(res.msg);
                }
                layer.closeAll("iframe");
                //刷新父页面
                parent.location.reload();
            });
            return false;
        });
    })
</script>
</body>
</html>
