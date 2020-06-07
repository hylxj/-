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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vgjlLBdk2NcFQOZdaPVe06jPgGqVFKmU"></script>

</head>
<body class="childrenBody">
<span id="lineName" style="display: none">${lineStaList[1].lineName}</span>
<%--<div style="width: 20%;" class="layui-show-lg-inline-block">--%>
<%--	<ul class="layui-timeline" style="width: 280px">--%>
<%--		<c:forEach items="${lineStaList}" var="sta" >--%>
<%--			<li class="layui-timeline-item" style="width: 250px">--%>
<%--				<i class="layui-icon layui-timeline-axis">&#xe63f;</i>--%>
<%--				<div class="layui-timeline-content layui-text">--%>
<%--					<h3 class="layui-timeline-title">${sta.staName}</h3>--%>
<%--				</div>--%>
<%--			</li>--%>
<%--		</c:forEach>--%>
<%--	</ul>--%>
<%--</div>--%>
<div style="width:100%;height:100%;background-color:silver;float:right">
	<div id="l-map" style="width: 100%;height: 300px"></div>
	<div id="r-result" style="width: 100%"></div>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>


</body>
<script type="text/javascript">
    // 百度地图API功能
    let map = new BMap.Map("l-map");            // 创建Map实例
	console.log(map)
    map.centerAndZoom("成都", 12);
	// let map = new BMap.Map("l-map"); //"map"为用于展示地图的div的id
	// let city;
	// let myCity = new BMap.LocalCity();
	// myCity.get(getCity);
	// function getCity (res) {
	// 	if (res) {
	// 		city = res.name;
	// 		map.centerAndZoom(city, 13);
	// 	} else {
	// 		city = "温州市"; //默认城市
	// 	}
	// }
	// function addLine (line) {
	// 	if ($.inArray(line, readyAdd) == -1) {
	// 		bus.getBusList(line);
	// 		readyAdd.push(line); //readyAdd为空数组，用于存储已添加的线路名
	// 	} else {
	// 		alert("该路线已添加");
	// 	}
	// }
	// let getPolylineOptions = function getPolylineOptions () { //线路样式配置
	// 	return {
	// 		strokeColor: $("#strokeColor").val(),
	// 		strokeWeight: $("#strokeWeight").val(),
	// 		strokeOpacity: $("#strokeOpacity").val(),
	// 		strokeStyle: $("#strokeStyle").val()
	// 	}
	// };
	// let bus = new BMap.BusLineSearch(map, {
	// 	onGetBusListComplete: function onGetBusListComplete (result) {
	// 		let busListItem = $("#busListItem").val(); //公交上下行
	// 		let fstLine = result.getBusListItem(busListItem);
	// 		bus.getBusLine(fstLine);
	// 	},
	// 	onGetBusLineComplete: function onGetBusLineComplete (busline) {
	// 		polyline = new BMap.Polyline(busline.getPath(), getPolylineOptions());
	// 		let lineName = busline.name.substr(0, busline.name.indexOf("(")); //提取线路名
	// 		map.addOverlay(polyline); //添加折线覆盖物
	// 		let stationList = []; //获取站点
	// 		for (let i = 0, len = busline.getNumBusStations(); i < len; i++) {
	// 			let busStation = busline.getBusStation(i);
	// 			let marker = new BMap.Marker(busStation.position, {
	// 				icon: stationIcon
	// 			});
	// 			stationList.push(new BMap.Point(busStation.position.lng, busStation.position.lat));
	// 			if ($("#strokeStation").val() == "true") { //显示站点
	// 				map.addOverlay(marker);
	// 				marker.setTitle(lineName + ":" + busStation.name);
	// 				marker.addEventListener("click", function (e) { //单击站点显示信息
	// 					let opts = {
	// 						width: 250,
	// 						height: 80,
	// 						title: e.target.getTitle().substr(e.target.getTitle().indexOf(":") + 1)
	// 					};
	// 					let content = busline.name;
	// 					let infoWindow = new BMap.InfoWindow(content, opts);
	// 					let point = new BMap.Point(e.target.getPosition().lng, e.target.getPosition().lat);
	// 					map.openInfoWindow(infoWindow, point);
	// 				});
	// 			}
	// 		}
	// 		if (enableAutoViewport) {
	// 			let view = map.getViewport(eval(stationList));
	// 			map.centerAndZoom(view.center, view.zoom);
	// 		}
	// 		polyline.addEventListener("dblclick", function (e) { //双击线路删除路径
	// 			let allOverlay = map.getOverlays();
	// 			for (let i = 0, len = allOverlay.length; i < len; i++) {
	// 				if (allOverlay[i].toString() == "[object Marker]") {
	// 					if (allOverlay[i].getTitle().substr(0, allOverlay[i].getTitle().indexOf(":")) == lineName) {
	// 						allOverlay[i].enableMassClear();
	// 					} else {
	// 						allOverlay[i].disableMassClear();
	// 					}
	// 				} else {
	// 					allOverlay[i].disableMassClear();
	// 				}
	// 			}
	// 			e.target.enableMassClear();
	// 			map.clearOverlays();
	// 			let index = readyAdd.indexOf(lineName);
	// 			readyAdd.splice(index, 1);
	// 		});
	// 		polyline.addEventListener("mouseover", function (e) { //移向线路高亮路径
	// 			if (e.target == currentPolyline) {
	// 				return false;
	// 			}
	// 			currentPolyline = e.target;
	// 			lineOpacity = currentPolyline.getStrokeOpacity();
	// 			currentPolyline.setStrokeOpacity("1");
	// 		});
	// 		polyline.addEventListener("mouseout", function (e) {
	// 			e.target.setStrokeOpacity(lineOpacity);
	// 		})
	// 	}
	// });
    let busline = new BMap.BusLineSearch(map,{
        renderOptions:{map:map,panel:"r-result"},
        onGetBusListComplete: function(result){
            if(result) {
            	console.log(busline)
                let fstLine = result.getBusListItem(0);//获取第一个公交列表显示到map上
                busline.getBusLine(fstLine);
            }
        }
    });
    function busSearch(){
        let busName = document.getElementById(	"lineName").innerText;
        busline.getBusList(busName);
    }
    setTimeout(function(){
        busSearch();
    },1500);
</script>

</html>
