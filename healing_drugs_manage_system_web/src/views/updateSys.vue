<template>
    <div class="box">
        <el-card>
            <h1>编辑系统公告：</h1>
            <div class="add">
                <img @click="addDialogVisible = true" :src="require('@/assets/新增.png')" alt="">
            </div>
            <el-table stripe :data="tableData.reverse()" height="35rem" style="width: 100%">
                <el-table-column prop="content" label="内容" />
                <el-table-column prop="create_time" label="创建时间" width="180"/>
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
        <el-dialog v-model="addDialogVisible" title="新增公告" width="50%" align-center>
            <el-form :model="form">
                <el-form-item>
                    <el-input v-model="form.content" maxlength="50" placeholder="请输入内容......" show-word-limit
                        type="textarea" />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="addDialogVisible = false">返回</el-button>
                    <el-button type="primary" @click="addSys">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup lang="ts">
import request from '@/request';
import { ref, onMounted, reactive } from 'vue';
import { ElNotification } from 'element-plus'

// 新增公告
const form = reactive({
    content: ''
})
const addDialogVisible = ref(false)
const addSys = () => {
    request.post(`/sys/add`, form).then((res: any) => {
        if (res.code == 200) {
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            getSys()
        }
        centerDialogVisible.value = false;
    }).catch(err => {
        ElNotification({
            title: '失败',
            message: err.msg,
            type: 'error',
        })
    })
    addDialogVisible.value = false
}
// 删除公告
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
    request.post(`/sys/delete?id=${id}`).then((res: any) => {
        if (res.code == 200) {
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            tableData.value.splice(selectRow.value, 1)
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
// 获取系统公告
const tableData = ref([{
    content: '',
    create_time: ''
}])
const getSys = () => {
    request.get('/sys/annunciate',).then((res: any) => {
        if (res.code === 200) {
            tableData.value = res.data
        } else if (res.code === 400) {
            ElNotification({
                title: '警告',
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
onMounted(() => {
    getSys()
})
</script>

<style lang="less" scoped>
.box {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;

    .el-card {
        width: 70rem;

        .add {
            width: 100%;
            display: flex;
            justify-content: end;
            padding-right: 3.5rem;

            img {
                height: 2rem;
                cursor: pointer;
            }
        }
    }
}
</style>