<template>
    <div class="h">
        <img style="margin-left: 2.5rem;" @click="handleMenu" :src="require('@/assets/展开.png')" alt="">
        <img @click="logout" :src="require('@/assets/退出.png')" alt="">
    </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import store from '@/store';

const router = useRouter();

import { ElNotification } from 'element-plus'

const logout = () => {
    localStorage.clear();
    router.push('/login');
    ElNotification({
        title: '成功',
        message: "退出成功！",
        type: 'success',
    })
}

const handleMenu = () => {
    store.commit('collapseChange');
}
</script>

<style lang="less" scoped>
.h {
    background-color: #0c7068;
    height: 5rem;
    display: flex;
    align-items: center;
    justify-content: space-between;

    img {
        height: 1.5rem;
        margin-right: 2.5rem;
        cursor: pointer;
    }
}
</style>