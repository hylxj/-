<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>成都市公共交通信息管理平台</title>
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
<blockquote class="layui-elem-quote layui-bg-green">
    <div id="nowTime"></div>
</blockquote>
<%--<div class="layui-row layui-col-space10 panel_box">--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;" data-url="http://fly.layui.com/case/u/3198216" target="_blank">--%>
<%--            <div class="panel_icon layui-bg-green">--%>
<%--                <i class="layui-anim seraph icon-good"></i>--%>
<%--            </div>--%>
<%--            <div class="panel_word">--%>
<%--                <span>为我点赞</span>--%>
<%--                <cite>点赞地址链接</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;" data-url="https://github.com/BrotherMa/layuicms2.0" target="_blank">--%>
<%--            <div class="panel_icon layui-bg-black">--%>
<%--                <i class="layui-anim seraph icon-github"></i>--%>
<%--            </div>--%>
<%--            <div class="panel_word">--%>
<%--                <span>Github</span>--%>
<%--                <cite>模版下载链接</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;" data-url="https://gitee.com/layuicms/layuicms2.0" target="_blank">--%>
<%--            <div class="panel_icon layui-bg-red">--%>
<%--                <i class="layui-anim seraph icon-oschina"></i>--%>
<%--            </div>--%>
<%--            <div class="panel_word">--%>
<%--                <span>码云</span>--%>
<%--                <cite>模版下载链接</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;" data-url="page/user/userList.html">--%>
<%--            <div class="panel_icon layui-bg-orange">--%>
<%--                <i class="layui-anim seraph icon-icon10" data-icon="icon-icon10"></i>--%>
<%--            </div>--%>
<%--            <div class="panel_word userAll">--%>
<%--                <span></span>--%>
<%--                <em>用户总数</em>--%>
<%--                <cite class="layui-hide">用户中心</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;" data-url="page/systemSetting/icons.html">--%>
<%--            <div class="panel_icon layui-bg-cyan">--%>
<%--                <i class="layui-anim layui-icon" data-icon="&#xe857;">&#xe857;</i>--%>
<%--            </div>--%>
<%--            <div class="panel_word outIcons">--%>
<%--                <span></span>--%>
<%--                <em>外部图标</em>--%>
<%--                <cite class="layui-hide">图标管理</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <div class="panel layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg2">--%>
<%--        <a href="javascript:;">--%>
<%--            <div class="panel_icon layui-bg-blue">--%>
<%--                <i class="layui-anim seraph icon-clock"></i>--%>
<%--            </div>--%>
<%--            <div class="panel_word">--%>
<%--                <span class="loginTime"></span>--%>
<%--                <cite>上次登录时间</cite>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<blockquote class="layui-elem-quote main_btn">--%>
</blockquote>
<div class="layui-row layui-col-space10">
    <div class="layui-col-lg6 layui-col-md6">
        <blockquote class="layui-elem-quote title">系统基本参数</blockquote>
        <table class="layui-table magt0">
            <tbody>
            <tr>
                <td>当前版本</td>
                <td class="version"></td>
            </tr>
            <tr>
                <td>开发作者</td>
                <td class="author"></td>
            </tr>
            <tr>
                <td>网站首页</td>
                <td class="homePage"></td>
            </tr>
            <tr>
                <td>服务器环境</td>
                <td class="server"></td>
            </tr>
            <tr>
                <td>数据库版本</td>
                <td class="dataBase"></td>
            </tr>
            <tr>
                <td>最大上传限制</td>
                <td class="maxUpload"></td>
            </tr>
            <tr>
                <td>当前用户权限</td>
                <td class="userRights"></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript">
    //获取系统时间
    let newDate = '';
    getLangDate();

    //值小于10时，在前面补0
    function dateFilter(date) {
        if (date < 10) {
            return "0" + date;
        }
        return date;
    }

    function getLangDate() {
        let dateObj = new Date(); //表示当前系统时间的Date对象
        let year = dateObj.getFullYear(); //当前系统时间的完整年份值
        let month = dateObj.getMonth() + 1; //当前系统时间的月份值
        let date = dateObj.getDate(); //当前系统时间的月份中的日
        let day = dateObj.getDay(); //当前系统时间中的星期值
        let weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
        let week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
        let hour = dateObj.getHours(); //当前系统时间的小时值
        let minute = dateObj.getMinutes(); //当前系统时间的分钟值
        let second = dateObj.getSeconds(); //当前系统时间的秒钟值
        let timeValue = "" + ((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午"); //当前时间属于上午、晚上还是下午
        newDate = dateFilter(year) + "年" + dateFilter(month) + "月" + dateFilter(date) + "日 " + " " + dateFilter(hour) + ":" + dateFilter(minute) + ":" + dateFilter(second);
        document.getElementById("nowTime").innerHTML = "亲爱的${username}，" + timeValue + "好！ 欢迎使用成都市公共交通信息管理平台。当前时间为： " + newDate + "　" + week;
        setTimeout("getLangDate()", 1000);
    }

    layui.use(['form', 'element', 'layer', 'jquery'], function () {
        let form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            element = layui.element;
        $ = layui.jquery;
        //上次登录时间【此处应该从接口获取，实际使用中请自行更换】
        $(".loginTime").html(newDate.split("日")[0] + "日</br>" + newDate.split("日")[1]);
        //icon动画
        $(".panel a").hover(function () {
            $(this).find(".layui-anim").addClass("layui-anim-scaleSpring");
        }, function () {
            $(this).find(".layui-anim").removeClass("layui-anim-scaleSpring");
        })
        $(".panel a").click(function () {
            parent.addTab($(this));
        })
        //系统基本参数
        if (window.sessionStorage.getItem("systemParameter")) {
            let systemParameter = JSON.parse(window.sessionStorage.getItem("systemParameter"));
            fillParameter(systemParameter);
        } else {
            $.ajax({
                url: "../../static/json/systemParameter.json",
                type: "get",
                dataType: "json",
                success: function (data) {
                    fillParameter(data);
                }
            })
        }

        //填充数据方法
        function fillParameter(data) {
            //判断字段数据是否存在
            function nullData(data) {
                if (data == '' || data == "undefined") {
                    return "未定义";
                } else {
                    return data;
                }
            }

            $(".version").text(nullData(data.version));      //当前版本
            $(".author").text(nullData(data.author));        //开发作者
            $(".homePage").text(nullData(data.homePage));    //网站首页
            $(".server").text(nullData(data.server));        //服务器环境
            $(".dataBase").text(nullData(data.dataBase));    //数据库版本
            $(".maxUpload").text(nullData(data.maxUpload));    //最大上传限制
            $(".userRights").text(nullData(data.userRights));//当前用户权限
        }

        //用户数量
        $.get("../../static/	json/userList.json", function (data) {
            $(".userAll span").text(data.count);
        })

        //外部图标
        $.get(iconUrl, function (data) {
            $(".outIcons span").text(data.split(".icon-").length - 1);
        })

    })
</script>
</body>
</html>
