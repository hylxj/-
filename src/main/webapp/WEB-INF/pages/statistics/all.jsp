<%--
  Created by IntelliJ IDEA.
  User: 小色
  Date: 2019-09-03
  Time: 14:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>成都市所有公交车站地图</title>
    <style type="text/css">
        body, html {
            width: 100vw;
            height: 100vh;
            overflow: hidden;
        }

        .map-box {
            width: 1400px;
            height: 700px;
        }
    </style>
</head>
<body>
<div class="map-box" id="map"></div>
<div class="layui-tab mag0" lay-filter="bodyTab" id="top_tabs_box"></div>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        var $, tab, dataStr, layer;
        layui.config({
            base: "static/js/"
        }).extend({
            "bodyTab": "bodyTab"
        })
        layui.use(['bodyTab', 'form', 'element', 'layer', 'jquery'], function () {
            var form = layui.form,
                element = layui.element;
            $ = layui.$;
            layer = parent.layer === undefined ? layui.layer : top.layer;
            tab = layui.bodyTab({
                openTabNum: "50",  //最大可打开窗口数量
                url: "static/json/navs.json" //获取菜单json地址
            });
            //打开新窗口
            function addTab(_this){
                tab.tabAdd(_this);
            }


        //散点相关信息
        var mapData = [
            {
                'latitude': 30.657689,
                'longitude': 104.080989,
                'name': '四川省人民政府<br>地址：成都市锦江区督院街30号',
                'value': 15,
                'color': '#ff6521'
            },//锦江区
            {
                'latitude': 30.679591,
                'longitude': 103.981632,
                'name': '青羊区公交总站<br>地址：成都市青羊区三元街129号',
                'value': 15,
                'color': '#ff6521'
            },//青羊区公交站
            {
                'latitude': 30.730344,
                'longitude': 104.056346,
                'name': '金牛区公交总站<br>地址：成都市金牛区长庆路10号',
                'value': 10,
                'color': '#ECEA1F'
            },//金牛区公交站
            {
                'latitude': 30.630862,
                'longitude': 104.05167,
                'name': '武侯区公交总站<br>地址：成都市武侯区南华路1397号',
                'value': 10,
                'color': '#ECEA1F'
            },//武侯区公交站
            {
                'latitude': 30.660275,
                'longitude': 104.143992,
                'name': '成华区公交总站<br>地址：成都市成华区向南街430号',
                'value': 10,
                'color': '#ECEA1F'
            },//成华区公交站
            {
                'latitude': 30.56065,
                'longitude': 104.269181,
                'name': '龙泉驿区公交总站<br>地址：成都市龙泉驿区华阳街587号',
                'value': 10,
                'color': '#ECEA1F'
            },//龙泉驿区公交站
            {
                'latitude': 30.883438,
                'longitude': 104.25494,
                'name': '青白江区公交总站<br>地址：成都市青白江区西邻街246号',
                'value': 10,
                'color': '#ECEA1F'
            },//青白江区公交站
            {
                'latitude': 30.824223,
                'longitude': 104.16022,
                'name': '新都区公交总站<br>地址：成都市新都区东正街682号',
                'value': 10,
                'color': '#ECEA1F'
            },//新都区公交总站
            {
                'latitude': 30.697996,
                'longitude': 103.836776,
                'name': '温江区公交总站<br>地址：成都市温江区天乡路',
                'value': 10,
                'color': '#ECEA1F'
            },//温江区公交总站
            {
                'latitude': 30.44798,
                'longitude': 104.035645,
                'name': '双流区公交总站<br>地址：成都市双流区天府五街1067号',
                'value': 10,
                'color': '#ECEA1F'
            },//双流区公交总站
            {
                'latitude': 30.808752,
                'longitude': 103.887842,
                'name': '郫都区公交总站<br>地址：成都市郫都区解放路309号',
                'value': 10,
                'color': '#ECEA1F'
            },//郫都区公交总站

        ]

        var dom = document.getElementById("map");
        var myChart = echarts.init(dom);
        var option1 = null;
        myChart.showLoading(); //加载动画

        $.get('static/json/chengdu.json', function (result) {
            myChart.hideLoading(); //关闭加载动画
            echarts.registerMap(name, result); //加载地图数据
            option1 = {
                tooltip: {
                    trigger: 'item',
                    formatter: function (params) {
                        return params.name;
                    }
                },
                //            visualMap: { //在展示每个区域数据量场景使用，不同的范围区域颜色调节
                //                left: 'right',
                //                min: 50,
                //                max: 100,
                //                inRange: {
                //                    color: ['#bfdfe0','#92b6ff','#4380fd']
                //                },
                //                text: ['High', 'Low'], // 文本，默认为数值文本
                //                calculable: false,
                //                show: false,
                //            },
                toolbox: {
                    show: false, //此字段表示是否显示或启用
                    //orient: 'vertical', //工具栏
                    left: 'left',
                    top: 'top',
                    feature: {
                        dataView: {
                            readOnly: false
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                geo: {
                    type: 'map',
                    zoom: 1.2,   //地图初始大小，这里是关键，一定要放在 series中  因为geo在series中会加载，所以zoom放在此处
                    roam: true,
                    label: {
                        normal: {
                            show: true,
                            color: '#333'
                        },
                        emphasis: {
                            textStyle: {
                                color: '#fff'
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            borderColor: '#4a86fd', //区域边框颜色
                            areaColor: '#bfdfe0', //区域填充颜色
                        },
                        emphasis: {
                            areaColor: '#4380fd',
                            borderWidth: 0
                        }
                    },

                },
                series: [{
                    type: 'effectScatter',
                    coordinateSystem: 'geo',
                    // animation: true,
                    rippleEffect: {
                        brushType: 'stroke'
                    },
                    symbolSize: function (val, params) { //散点大小
                        return val[2];
                    },
                    data: mapData.map(function (itemOpt) { //散点生成
                        return {
                            name: itemOpt.name,
                            value: [
                                itemOpt.longitude,
                                itemOpt.latitude,
                                itemOpt.value
                            ],

                            label: {
                                emphasis: {
                                    position: 'right',
                                    show: false
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: itemOpt.color
                                }
                            }
                        };
                    })

                }]
            };

            myChart.setOption(option1, true);
            window.addEventListener("resize", function () { //浏览器大小调整echarts随之改变
                myChart.resize();
            });
            myChart.on('click', function (params) { //地图区域点击时的联动   根据params的值来联动对应数据
                console.log(params.name); //此处写点击事件内容
                window.location.href="https://map.baidu.com/@11587318,3554701,13z";
            });
        });

        })
    })
</script>
</body>
</html>
