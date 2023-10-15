<template>
    <div class="login">
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
                <div class="btn">
                    <el-button type="primary" round @click="onSubmit">登录</el-button>
                    <p>没有账号？<a @click="router.push('/register')">点击注册</a></p>
                </div>
            </el-form>
        </div>
    </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import router from '@/router';
import request from '@/request';

const form = reactive({
    user: '',
    password: ''
})
import { ElNotification } from 'element-plus'
const onSubmit = () => {
    if (form.user === '' || form.password === '') {
        ElNotification({
            title: '失败',
            message: '用户名或密码不能为空！',
            type: 'warning',
        })
        return
    }
    request.post('/user/login', form).then((res: any) => {
        if (res.code === 200) {
            localStorage.setItem('token', res.data.token)
            localStorage.setItem('user', JSON.stringify(res.data.data))
            ElNotification({
                title: '成功',
                message: res.msg,
                type: 'success',
            })
            router.push('/')
        } else if (res.code === 400) {
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
</script>

<style lang="less" scoped>
.login {
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

                .el-button {
                    width: 100%;
                }

                p {
                    margin-top: 1rem;
                    display: flex;
                    justify-content: end;

                    a {
                        cursor: pointer;
                        color: red;
                    }
                }
            }
        }
    }
}
</style>