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
    <div class="layui-form-item layui-row layui-col-xs12">
        <label class="layui-form-label">角色名</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input roleName" lay-verify="required" placeholder="请输入角色名">
        </div>
    </div>
    <div class="magb15 layui-col-md4 layui-col-xs12">
        <label class="layui-form-label">角色状态</label>
        <div class="layui-input-block">
            <select name="available" class="available" lay-filter="available">
                <option value="1">正常状态</option>
                <option value="2">禁用状态</option>
            </select>
        </div>
    </div>
    </div>
    <div class="layui-form-item layui-row layui-col-xs12">
        <label class="layui-form-label">角色简介</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入角色简介" class="layui-textarea roleDesc"></textarea>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-xs12">
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
            $.post("/role/roleAdd", {
                roleName: $(".roleName").val(),  //登录名
                roleDesc: $(".roleDesc").val(),  //密码
                available: data.field.available    //角色状态
            }, function (res) {
                top.layer.close(index);

                layer.msg(res.msg, {
                    icon: 1,
                    time: 6000
                }, function(){
                    layer.closeAll("iframe");
                    //刷新父页面
                    parent.location.reload();
                });
            });
            return false;
        });
    })
</script>
</body>
</html>
