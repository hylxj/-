<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑";
        }
    </style>

    <title>1号线</title>
</head>
<body>
<div id="allmap"></div>


<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=eYf9sA6yVTFHlh9ytU4a0EYY"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
<script type="text/javascript">
    // 百度地图API功能
    let map = new BMap.Map("allmap");
    //地图中心
    map.centerAndZoom(new BMap.Point(104.062419,30.544198), 20);
    // 左上角，添加比例尺
    let top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});
    //左上角，添加默认缩放平移控件
    let top_left_navigation = new BMap.NavigationControl();
    //添加控件和比例尺
    map.addControl(top_left_control);
    map.addControl(top_left_navigation);
    //可滚轮缩放
    map.enableScrollWheelZoom();
    huoChe();

    //1号线 起点火车站
    function huoChe() {
        let p1 = new BMap.Point(104.062419,30.544198);
            p22 = new BMap.Point(104.062419,30.544198),
            p23 = new BMap.Point(104.06333,30.544136),
            p24 = new BMap.Point(104.06333,30.545812),
            p25 = new BMap.Point(104.064754,30.545816),

            p26 = new BMap.Point(104.066308,30.546372);
            p27 = new BMap.Point(104.067341,30.546251);
            p28 = new BMap.Point(104.06797,30.545967);
            p29 = new BMap.Point(104.067081,30.544132);
            p30 = new BMap.Point(104.069385,30.544047);
            p31 = new BMap.Point(104.070539,30.543436);
            p32 = new BMap.Point(104.070463,30.540287),
            p33 = new BMap.Point(104.067103,30.540373),
            p34 = new BMap.Point(104.063793,30.540427),
            p35 = new BMap.Point(104.063573,30.538783),

            p36 = new BMap.Point(104.063371,30.537266);
            p37 = new BMap.Point(104.061062,30.537527);
            p38 = new BMap.Point(104.061206,30.538293);
            p39 = new BMap.Point(104.059957,30.538475);
            p40 = new BMap.Point(104.059849,30.537651);
            p41 = new BMap.Point(104.059171,30.537659);


        //1号线 起点火车站 存到数组里
        let arrayList = [];
        arrayList.push(p1);
        arrayList.push(p22);
        arrayList.push(p23);
        arrayList.push(p24);
        arrayList.push(p25);
        arrayList.push(p26);
        arrayList.push(p27);
        arrayList.push(p28);
        arrayList.push(p29);
        arrayList.push(p30);
        arrayList.push(p31);
        arrayList.push(p32);
        arrayList.push(p33);
        arrayList.push(p35);
        arrayList.push(p36);
        arrayList.push(p37);
        arrayList.push(p38);
        arrayList.push(p39);
        arrayList.push(p40);
        arrayList.push(p41);
        moveBus(arrayList)
    }

    function moveBus(arrayList) {
        map.setViewport(arrayList);
        // marker=new BMap.Marker(arrayList[0],{
        //   icon  : new BMap.Icon('http://developer.baidu.com/map/jsdemo/img/car.png', new BMap.Size(52,26),{anchor : new BMap.Size(27, 13)})
        // });
        // let label = new BMap.Label("湘U16888",{offset:new BMap.Size(0,-30)});
        // label.setStyle({border:"1px solid rgb(204, 204, 204)",color: "rgb(0, 0, 0)",borderRadius:"10px",padding:"5px",background:"rgb(255, 255, 255)",});
        //         marker.setLabel(label);

        //  map.addOverlay(marker);
        BMapLib.LuShu.prototype._move = function (initPos, targetPos, effect) {
            let pointsArr = [initPos, targetPos];  //点数组
            let me = this,
                //当前的帧数
                currentCount = 0,
                //步长，米/秒
                timer = 1,
                step = this._opts.speed / (10000 / timer),
                //初始坐标
                init_pos = this._projection.lngLatToPoint(initPos),
                //获取结束点的(x,y)坐标
                target_pos = this._projection.lngLatToPoint(targetPos),
                //总的步长
                count = Math.round(me._getDistance(init_pos, target_pos) / step);
            //显示折线 syj201607191107
            // this._map.addOverlay(new BMap.Polyline(pointsArr, {
            //     strokeColor : "#111",
            //     strokeWeight : 5,
            //     strokeOpacity : 0.5
            // })); // 画线
            //如果小于1直接移动到下一点
            if (count < 1) {
                me._moveNext(++me.i);
                return;
            }
            me._intervalFlag = setInterval(function () {
                //两点之间当前帧数大于总帧数的时候，则说明已经完成移动
                if (currentCount >= count) {
                    clearInterval(me._intervalFlag);
                    //移动的点已经超过总的长度
                    if (me.i > me._path.length) {
                        return;
                    }
                    //运行下一个点
                    me._moveNext(++me.i);
                } else {
                    currentCount++;
                    let x = effect(init_pos.x, target_pos.x, currentCount, count),
                        y = effect(init_pos.y, target_pos.y, currentCount, count),
                        pos = me._projection.pointToLngLat(new BMap.Pixel(x, y));
                    //设置marker
                    if (currentCount == 1) {
                        let proPos = null;
                        if (me.i - 1 >= 0) {
                            proPos = me._path[me.i - 1];
                        }
                        if (me._opts.enableRotation == true) {
                            me.setRotation(proPos, initPos, targetPos);
                        }
                        if (me._opts.autoView) {
                            if (!me._map.getBounds().containsPoint(pos)) {
                                me._map.setCenter(pos);
                            }
                        }
                    }
                    //正在移动
                    me._marker.setPosition(pos);
                    //设置自定义overlay的位置
                    me._setInfoWin(pos);
                }
            }, timer);
        };
        lushu = new BMapLib.LuShu(map, arrayList, {
            defaultContent: "川A12345",
            autoView: true,//是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
            icon: new BMap.Icon('http://developer.baidu.com/map/jsdemo/img/car.png', new BMap.Size(52, 26), {anchor: new BMap.Size(27, 13)}),
            speed: 450,
            enableRotation: true,//是否设置marker随着道路的走向进行旋转
            landmarkPois: [
                {lng: 104.056103, lat: 30.537962, html: '女士们先生们，欢迎您乘坐1001号公交车，请大家坐好了', pauseTime: 2},
                {lng: 104.090675, lat: 30.523267, html: '女士们先生们，到达终点站，请拿好行李下车', pauseTime: 2},
            ],
            defaultContent: '川A12345 公交车极速前进中...',
        });
        lushu.start();
    }
</script>
</body>
</html>
