<template>
    <el-row :gutter="16">
        <el-col :span="8">
            <el-card class="user">
                <div class="t">
                    <img :src="userInfo.avatar" alt="">
                    <div class="info">
                        <h1>{{ userInfo.user }}</h1>
                        <p>{{ userInfo.role === 1 ? "管理员" : "普通用户" }}</p>
                    </div>
                </div>
                <el-divider border-style="dashed" />
                <div class="b">
                    <p>上次登录时间：{{ userInfo.last_time !== "Invalid date" ? userInfo.last_time : "第一次登录" }}</p>
                </div>
            </el-card>
            <el-card>
                <div class="table">
                    <p>最近新增药品列表</p>
                    <el-divider border-style="dashed" />
                    <el-table stripe :data="tableData.reverse()" height="25rem" style="width: 100%">
                        <el-table-column prop="serial_id" label="药品编号" />
                        <el-table-column prop="name" label="药品名称" />
                        <el-table-column prop="desc" label="药品描述" show-overflow-tooltip />
                    </el-table>
                </div>
            </el-card>
        </el-col>
        <el-col :span="16">
            <el-card class="system">
                <p class="t">系统公告</p>
                <el-divider border-style="dashed" />
                <div class="box">
                    <div class="b" v-for="item in sys_notic.reverse()" :key="item.id">
                        <p>{{ item.content }}</p>
                        <div style="display: flex; align-items: center;">
                            <img :src="require('@/assets/217时间.png')" alt="">
                            <p>{{ item.create_time }}</p>
                        </div>
                    </div>
                </div>
            </el-card>
            <el-card class="tjt">
                <!-- 统计图 tjt -->
                <p>药品进出库统计图</p>
                <div id="myChart" style="width: 600px; height: 400px"></div>
            </el-card>
        </el-col>
    </el-row>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import request from '@/request';

const userInfo = computed(() => {
    return JSON.parse(localStorage.getItem("user")!)
})

const tableData = ref([{
    serial_id: '',
    name: '',
}])

// 获取药品进出库统计图数据
import { ElNotification } from 'element-plus'
const getTjt = () => {
    request.get('/record/tjs').then((res: any) => {
        if (res.code == 200) {
            drawTjt(res.data.reverse())
        } else if (res.code == 400) {
            ElNotification({
                title: '失败',
                message: res.msg,
                type: 'warning',
            })
        }
    }).catch(() => {
        ElNotification({
            title: '失败',
            message: '请检查网络',
            type: 'error',
        })
    })
}
import * as echarts from 'echarts';
const drawTjt = (data: any) => {
    // 绘制统计图
    type EChartsOption = echarts.EChartsOption;

    var chartDom = document.getElementById('myChart')!;
    var myChart = echarts.init(chartDom);
    var option: EChartsOption;

    option = {
        legend: {},
        tooltip: {},
        dataset: {
            dimensions: ['date', '进口', '出口',],
            source: data
        },
        xAxis: { type: 'category' },
        yAxis: {},
        series: [{ type: 'bar' }, { type: 'bar' }]
    };

    option && myChart.setOption(option);
}

const sys_notic: any = ref([])
const getSystemNotice = () => {
    request.get('/sys/annunciate')
        .then((res: any) => {
            if (res.code === 200) {
                sys_notic.value = res.data
            }
        })
}
const getMedicine = () => {
    request.get('/medicine',).then((res: any) => {
        if (res.code === 200) {
            tableData.value = res.data
        }
    }).catch((err) => {
        console.log(err);
    })
}
onMounted(() => {
    getTjt();
    getSystemNotice();
    getMedicine();
})

</script>

<style lang="less" scoped>
.user {
    height: 15rem;
    margin-bottom: 1rem;

    .t {
        display: flex;
        align-items: center;

        img {
            height: 6rem;
            border-radius: 50%;
            margin: 1rem 0 1rem 5rem;
        }

        .info {
            margin-left: 2rem;

            h1 {
                font-size: 2rem;
                font-weight: 600;
            }

            p {
                margin-top: 1rem;
                color: #999;
            }
        }
    }

    .b {
        margin: 1rem;
    }
}

.table {
    p {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
        text-align: center;

    }
}

.system {
    height: 20rem;
    margin-bottom: 1rem;

    .t {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
        text-align: center;
    }

    .box {
        height: 13rem;
        overflow: auto;

        .b {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #999;
            margin: 1.5rem;
            font-weight: 400;

            img {
                height: 1rem;
                margin-right: 0.5rem;
            }
        }
    }
}

.tjt {
    height: 27rem;
    display: flex;
    justify-content: center;

    p {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
        text-align: center;
    }
}
</style>