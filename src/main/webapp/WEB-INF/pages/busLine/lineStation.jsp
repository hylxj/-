<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vgjlLBdk2NcFQOZdaPVe06jPgGqVFKmU"></script>

</head>
<body class="childrenBody">
<h2 id="lineName">${lineStaList[1].lineName}</h2>
<div style="width: 30%;" class="layui-show-lg-inline-block">
	<ul class="layui-timeline">
		<c:forEach items="${lineStaList}" var="sta" >
			<li class="layui-timeline-item">
				<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
				<div class="layui-timeline-content layui-text">
					<h3 class="layui-timeline-title">${sta.staName}</h3>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<div style="width:70%;height:500px;background-color:silver;float:right">
	<div id="l-map" style="width: 100%;height: 300px"></div>
	<div id="r-result" style="width: 100%"></div>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>


</body>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("l-map");            // 创建Map实例
    map.centerAndZoom("成都", 12);

    var busline = new BMap.BusLineSearch(map,{
        renderOptions:{map:map,panel:"r-result"},
        onGetBusListComplete: function(result){
            if(result) {
                var fstLine = result.getBusListItem(0);//获取第一个公交列表显示到map上
                busline.getBusLine(fstLine);
            }
        }
    });
    function busSearch(){

        var busName = document.getElementById(	"lineName").innerText;
        busline.getBusList(busName);
    }
    setTimeout(function(){
        busSearch();
    },1500);
</script>

</html>