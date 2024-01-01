<template>
    <div id="main">图表</div>
</template>
<script>
// 引入 echarts 核心模块，核心模块提供了 echarts 使用必须要的接口。
import * as echarts from 'echarts/core';
// 引入柱状图图表，图表后缀都为 Chart
import { BarChart } from 'echarts/charts';
// 引入提示框，标题，直角坐标系，数据集，内置数据转换器组件，组件后缀都为 Component
import {
    TitleComponent,
    TooltipComponent,
    GridComponent,
    DatasetComponent,
    TransformComponent
} from 'echarts/components';
// 标签自动布局、全局过渡动画等特性
import { LabelLayout, UniversalTransition } from 'echarts/features';
// 引入 Canvas 渲染器，注意引入 CanvasRenderer 或者 SVGRenderer 是必须的一步
import { CanvasRenderer } from 'echarts/renderers';
export default {
    created() {
        // 注册必须的组件
        echarts.use([
            TitleComponent,
            TooltipComponent,
            GridComponent,
            DatasetComponent,
            TransformComponent,
            BarChart,
            LabelLayout,
            UniversalTransition,
            CanvasRenderer,
        ]);
    },
    mounted() {
        var myChart = echarts.init(document.getElementById('main'));
        let option = {
            title: {
                text: '金额涉及'
            },
            tooltip: {},
            xAxis: {
                data: ['贷款总额', '信用账户总额', '储蓄管理总额']
            },
            yAxis: {},
            series: [
                {
                    name: '金额',
                    type: 'bar',
                    data: [10000,5000,3000]
                }
            ]
        }
        myChart.setOption(option);

    }
}
</script>
<style>
#main{
    width:600px;
    height:400px;
    margin:40px auto;
}
</style>