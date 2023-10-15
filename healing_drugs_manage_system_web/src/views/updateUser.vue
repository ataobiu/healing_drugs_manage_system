<template>
    <div class="box">
        <el-card>
            <h1>编辑个人资料：</h1>
            <div class="editImg">
                <img :src="user.avatar" alt="">
                <div class="upload">
                    <el-upload :on-success="onsuccess" :show-file-list="false" drag
                        action="http://localhost:3000/file/upload" :headers="headers">
                        <img :src="require('@/assets/云上传.png')" alt="">
                        <p>上传新头像以修改头像</p>
                    </el-upload>
                </div>
            </div>
            <div class="edit">
                <span>账号：<p>{{ user.user }}</p></span>
                <span>昵称：<p>{{ user.name }}</p></span>
                <div class="t">
                    <el-form label-position="top" :model="form" label-width="120px">
                        <el-form-item label="昵称： ">
                            <el-input autofocus v-model="form.name" />
                        </el-form-item>
                        <el-form-item label="密码： ">
                            <el-input v-model="form.password" />
                        </el-form-item>
                        <el-form-item label="确认密码： ">
                            <el-input v-model="form.repassword" />
                        </el-form-item>
                        <div class="btn">
                            <el-button type="primary" @click="onSubmit" plain>修改资料</el-button>
                        </div>
                    </el-form>
                </div>
            </div>
        </el-card>
    </div>
</template>

<script setup lang="ts">
import { reactive, computed } from 'vue';
import request from '@/request';
const user: any = computed(() => {
    return JSON.parse(localStorage.getItem('user') as string)
})

const form = reactive({
    name: '',
    password: '',
    repassword: ''
});
// 文件上传
const headers = computed(() => {
    return { Authorization: localStorage.getItem('token') }
})
const onsuccess = (res: any) => {
    const avatar = res.data
    const data = { avatar: avatar }
    modefication(data)
    window.location.reload()
}
import { ElNotification } from 'element-plus'
const onSubmit = () => {
    if (form.name === '' && (form.password === '' || form.repassword === '')) {
        ElNotification({
            title: '警告',
            message: '至少有一项不能为空！',
            type: 'warning',
        })
        return
    } else if (form.password !== form.repassword) {
        ElNotification({
            title: '警告',
            message: '两次密码不一致！',
            type: 'warning',
        })
        return
    }
    modefication(form)

}
// 修改用户信息
const modefication = (data: any) => {
    const id = user.value.id
    request.post(`/user/update?id=${id}`, data).then((res: any) => {
        if (res.code === 200) {
            localStorage.setItem('user', JSON.stringify(res.data.data))
            localStorage.setItem('token', res.data.token)
            ElNotification({
                title: 'success',
                message: res.msg,
                type: 'success',
            })
        } else if (res.code === 400) {
            ElNotification({
                title: '失败',
                message: res.msg,
                type: 'error',
            })
        }
    }).catch(() => {
        ElNotification({
            title: '失败',
            message: "请检查网络！",
            type: 'error',
        })
    })
}
</script>

<style lang="less" scoped>
.box {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;

    .el-card {
        height: 40rem;
        width: 30rem;
        margin: 2rem;

        .editImg {
            display: flex;
            justify-content: start;
            align-items: center;
            height: 10rem;
            margin-left: 2rem;

            img {
                height: 8rem;
            }

            .upload {
                margin-left: 2rem;

                img {
                    height: 2rem;
                }

                p {
                    font-size: 0.5rem;
                    color: #999;
                }
            }
        }

        .edit {
            span {
                display: flex;
                margin: 1rem;
                color: #999;

                p {
                    color: black;
                }
            }

            .t {
                display: flex;
                justify-content: center;

                .btn {
                    display: flex;
                    justify-content: end;
                }
            }
        }
    }
}
</style>