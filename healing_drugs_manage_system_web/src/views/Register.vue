<template>
    <div class="register">
        <div class="form">
            <span>医药管理系统</span>
            <el-form @keydown.enter="onSubmit" class="b" label-position="top" label-width="100px" :model="form"
                style="max-width: 460px">
                <el-form-item>
                    <el-input autofocus v-model.trim="form.user" clearable placeholder="请输入账号" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model.trim="form.password" clearable show-password placeholder="请输入密码" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model.trim="form.repassword" clearable show-password placeholder="请再次确认密码" />
                </el-form-item>
                <div class="btn">
                    <el-button type="primary" round @click="onSubmit">注册</el-button>
                    <a @click="router.back">返回</a>
                </div>
            </el-form>
        </div>
    </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import router from '@/router';

const form = reactive({
    user: '',
    password: '',
    repassword: ''
})

import { ElNotification } from 'element-plus'
import request from '@/request';
const onSubmit = () => {
    if (form.user === '' || form.password === '') {
        ElNotification({
            title: 'error',
            message: '用户名或密码不能为空！',
            type: 'error',
        })
        return
    } else if (form.password !== form.repassword) {
        ElNotification({
            title: 'error',
            message: '两次输入密码不一致',
            type: 'error',
        })
        return
    }
    request.post('/user/register', form).then((res: any) => {
        if (res.code === 200) {
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            router.push('/login')
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
            message: '请检查网络',
            type: 'error',
        })
    })
}
</script>

<style lang="less" scoped>
.register {
    background-color: #01565d;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;

    .form {
        height: 20rem;
        width: 25rem;
        background-color: #0c7068;
        border-radius: 1rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: white;

        span {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .b {
            .btn {
                display: flex;
                flex-direction: column;
                align-items: end;

                .el-button {
                    width: 100%;
                }


                a {
                    margin-top: 1rem;
                    cursor: pointer;
                }
            }
        }
    }
}
</style>