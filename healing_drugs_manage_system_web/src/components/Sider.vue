<template>
  <el-menu :collapse="isCollapse" router active-text-color="#ffd04b" background-color="#0c7068" default-active="/"
    text-color="#fff">
    <div class="t">
      <p>{{ isCollapse ? "医药" : "医药管理系统" }}</p>
    </div>
    <el-menu-item index="/">
      <img :src="require('@/assets/首页-填充.png')" alt="">
      <span>首页</span>
    </el-menu-item>
    <el-sub-menu index="1">
      <template #title>
        <img :src="require('@/assets/个人中心.png')" alt="">
        <span>个人中心</span>
      </template>
      <el-menu-item-group>
        <el-menu-item index="/updateUser">修改个人信息</el-menu-item>
        <el-menu-item index="/updateSys" v-if="userInfo.role === 1">修改系统公告</el-menu-item>
      </el-menu-item-group>
    </el-sub-menu>
    <el-sub-menu index="2" v-if="userInfo.role === 1">
      <template #title>
        <img :src="require('@/assets/清单_信息_设备基础信息_工单信息.png')" alt="">
        <span>药品信息管理</span>
      </template>
      <el-menu-item-group>
        <el-menu-item index="/medicine/class">新增药品</el-menu-item>
      </el-menu-item-group>
    </el-sub-menu>
    <el-sub-menu index="3" v-if="userInfo.role === 1">
      <template #title>
        <img :src="require('@/assets/入库.png')" alt="">
        <span>药品出入管理</span>
      </template>
      <el-menu-item-group>
        <el-menu-item index="/medicine/record">出入记录</el-menu-item>
      </el-menu-item-group>
    </el-sub-menu>
  </el-menu>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import store from '@/store';

const isCollapse = computed(() => {
  return store.state.isCollapse
})
const userInfo = computed(() => {
  return JSON.parse(localStorage.getItem("user")!)
})
</script>

<style lang="less" scoped>
.el-menu {
  height: 100vh;

  .t {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 5rem;

    p {
      font-size: 1.5rem;
      font-weight: 600;
      color: white;
      text-align: center;
    }
  }

  img {
    height: 2rem;
  }

  span {
    margin-left: 1rem;
  }

}
</style>