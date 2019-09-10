<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 1300px;height:620px;"></div>
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <script src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        var myChart = echarts.init(document.getElementById('main'));

        $.get('/CenWorkerNum').done(function (data) {
            myChart.setOption({
                title : {
                    text: '总站信息统计',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    x : 'center',
                    y : 'bottom',
                    data:data
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: false},
                        magicType : {
                            show: true,
                            type: ['pie', 'funnel']
                        },
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                series : [
                    {
                        name:'各站人数所占比',
                        type:'pie',
                        radius : [100, 200],
                        center : ['50%', '50%'],
                        roseType : 'area',
                        data:data
                    }
                ]
                });
        });

    </script>
</body>
</html>
