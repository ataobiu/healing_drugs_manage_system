<template>
    <div class="box">
        <el-card>
            <h1>药品出入库记录</h1>
            <el-table border stripe :data="recordData.reverse()" height="40rem" style="width: 100%">
                <el-table-column prop="id" label="进出口编号" />
                <el-table-column prop="serial_id" label="药品编号" />
                <el-table-column prop="import" label="进口数量" />
                <el-table-column prop="export" label="出口数量" />
                <el-table-column prop="date" label="时间" />
                <el-table-column fixed="right" label="操作" width="100">
                    <template #default="scope">
                        <el-button link type="primary" size="small" @click="delRow(scope.$index, scope.row)">
                            <img style="height: 2rem;" :src="require('@/assets/删除.png')" alt="">
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
        <el-dialog v-model="centerDialogVisible" title="警告" width="30%" align-center>
            <span>确认删除吗？</span>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="centerDialogVisible = false">返回</el-button>
                    <el-button type="primary" @click="delHandle">确定</el-button>
                </span>
            </template>
        </el-dialog>
        <el-card>
            <h1>新增记录</h1>
            <el-divider />
            <el-form :model="form" label-width="120px">
                <el-form-item label="药品编号：">
                    <el-select v-model="form.serial_id" placeholder="请选择" @change="onSerialIdChange">
                        <el-option v-for="item in tableData" :label="item.serial_id" :value="item.serial_id" />
                    </el-select>
                </el-form-item>
                <el-form-item label="进口数：">
                    <el-col :span="11">
                        <el-input v-model.number="form.import" placeholder="请输入数字" />
                    </el-col>
                </el-form-item>
                <el-form-item label="出口数：">
                    <el-col :span="11">
                        <el-input v-model.number="form.export" placeholder="请输入数字" />
                    </el-col>
                </el-form-item>
                <el-form-item label="选择时间：">
                    <el-col :span="11">
                        <el-time-picker v-model="form.date" placeholder="选择一个时间" style="width: 100%" />
                    </el-col>
                </el-form-item>
                <div class="btn">
                    <el-button type="primary" @click="onSubmit" plain>确定</el-button>
                </div>
            </el-form>
            <el-divider />
            <div class="detail">
                <h1>您的选择：</h1>
                <p>药品名称：<span>{{ currentData.name }}</span></p>
                <p>药品描述：<span>{{ currentData.desc }}</span></p>
                <p>药品图片：</p>
                <div style="display: flex; justify-content: center;">
                    <img :src="currentData.picture" alt="">
                </div>
            </div>
        </el-card>
    </div>
</template>

<script setup lang="ts">
import request from '@/request';
import { ref, onMounted, reactive, computed } from 'vue';

const recordData = ref<any>([])
const getRecord = () => {
    request.get('/record',).then((res: any) => {
        if (res.code === 200) {
            recordData.value = res.data
        }
    }).catch((err) => {
        console.log(err);
    })
}
const tableData = ref<any>([])
const getMedicine = () => {
    request.get('/medicine',).then((res: any) => {
        if (res.code === 200) {
            tableData.value = res.data
        }
    }).catch((err) => {
        console.log(err);
    })
}

// 新增
const form = reactive({
    serial_id: '',
    export: 0,
    import: 0,
    date: '',
})
// 过滤对象
const currentData = ref<any>({})
const onSerialIdChange = (val: any) => {
    currentData.value = tableData.value.filter((item: any) => item.serial_id === val)[0];
}
const onSubmit = () => {
    if (!form.serial_id || !form.date) {
        ElNotification({
            title: '失败',
            message: '请填写相应数据！',
            type: 'warning',
        })
        return
    } else if (typeof form.import !== "number" || typeof form.export !== "number") {
        ElNotification({
            title: '失败',
            message: '非法数据！',
            type: 'warning',
        })
        return
    }
    request.post('/record/add', form).then((res: any) => {
        if (res.code === 200) {
            ElNotification({
                title: '成功',
                message: '添加成功',
                type: 'success',
            })
            return
        } else if (res.code === 404) {
            ElNotification({
                title: '失败',
                message: res.msg,
                type: 'warning',
            })
            return
        }
    }).catch(() => {
        ElNotification({
            title: '失败',
            message: '请检查网络',
            type: 'error',
        })
        return
    })
    getRecord()
}
// 删除
import { ElNotification } from 'element-plus'
const centerDialogVisible = ref(false)
const selectId = ref()
const selectRow = ref()
const delRow = (index: String, data: any) => {
    centerDialogVisible.value = true;
    selectRow.value = index;
    selectId.value = data;
}
const delHandle = () => {
    const id = selectId.value.id;
    request.post(`/record/delete?id=${id}`).then((res: any) => {
        if (res.code == 200) {
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            recordData.value.splice(selectRow.value, 1)
        }
        centerDialogVisible.value = false;
    }).catch(err => {
        ElNotification({
            title: '失败',
            message: err.msg,
            type: 'error',
        })
    })
}
onMounted(() => {
    getRecord();
    getMedicine();
})
</script>

<style lang="less" scoped>
.box {
    display: flex;
    justify-content: space-around;
    align-items: center;
    height: 100%;

    .el-card {
        width: 40rem;
        height: 45rem;

        .btn {
            display: flex;
            justify-content: center;
            margin: 1rem;

            .el-button {
                width: 10rem;
            }
        }

        .detail {
            h1 {
                margin: 1rem 0;
            }

            p {
                margin: 0.5rem;
                color: #999;

                span {
                    color: black;
                }
            }

            img {
                height: 9rem;
            }
        }

    }
}
</style>