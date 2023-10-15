<template>
    <div class="box">
        <el-card>
            <h1>药品信息管理</h1>
            <div class="add">
                <img @click="addDialogVisible = true" :src="require('@/assets/新增.png')" alt="">
            </div>
            <el-table border stripe :data="tableData.reverse()" height="35rem" style="width: 100%">
                <el-table-column prop="serial_id" label="药品编号" />
                <el-table-column prop="name" label="药品名称" />
                <el-table-column prop="picture" label="药品图片">
                    <template slot-scope="scope" #default="scope">
                        <div style="display: flex; align-items: center">
                            <el-image :src="scope.row.picture" />
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="desc" label="药品描述" width="200" show-overflow-tooltip />
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
        <el-dialog destroy-on-close v-model="addDialogVisible" title="新增药品" width="50%" align-center>
            <el-form :model="form">
                <div style="display: flex;">
                    <el-form-item required label="药品编号">
                        <el-input v-model="form.serial_id" />
                    </el-form-item>
                    <el-form-item required style="margin-left: 2rem;" label="药品名称">
                        <el-input v-model="form.name" />
                    </el-form-item>
                </div>
                <el-form-item required label="药品描述">
                    <el-input v-model="form.desc" />
                </el-form-item>
            </el-form>
            <div class="upload">
                <el-upload :on-success="onsuccess" :headers="headers" action="http://localhost:3000/file/upload"
                    :show-file-list="false">
                    <el-button type="primary">上传药品图片</el-button>
                </el-upload>
            </div>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="addDialogVisible = false">返回</el-button>
                    <el-button type="primary" @click="submitUpload">确定</el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script setup lang="ts">
import request from '@/request';
import { ref, onMounted, reactive, computed } from 'vue';
import { ElNotification } from 'element-plus'

// 文件上传
const headers = computed(() => {
    return { Authorization: localStorage.getItem('token') }
})
const onsuccess = (res: any) => {
    form.picture = res.data
}
const addDialogVisible = ref(false)
const submitUpload = () => {
    if (!form.picture || !form.serial_id || !form.name || !form.desc) {
        ElNotification({
            title: '警告',
            message: "请填写必要内容！",
            type: 'warning',
        })
        return
    }
    request.post('/medicine/add', form).then((res: any) => {
        if (res.code == 200) {
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            getMedicine()
        } else if (res.code == 400) {
            ElNotification({
                title: '失败',
                message: res.msg,
                type: 'error',
            })
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
// 新增
const form = reactive({
    serial_id: '',
    name: '',
    picture: '',
    desc: ''
})

const tableData = ref([{
    serial_id: '',
    name: '',
    picture: '',
    desc: ''
}])

// 删除
const centerDialogVisible = ref(false)
const selectId = ref()
const selectRow = ref()
const delRow = (index: String, data: any) => {
    centerDialogVisible.value = true;
    selectRow.value = index;
    selectId.value = data;
}
const delHandle = () => {
    const id = selectId.value.serial_id;
    request.post(`/medicine/delete?id=${id}`).then((res: any) => {
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
// 获取
const getMedicine = () => {
    request.get('/medicine',).then((res: any) => {
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
    getMedicine()
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