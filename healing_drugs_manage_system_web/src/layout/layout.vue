<template>
    <div class="common-layout">
        <el-container>
            <el-aside width="auto">
                <Sider></Sider>
            </el-aside>
            <el-container>
                <el-header>
                    <Header></Header>
                </el-header>
                <el-main>
                    <router-view></router-view>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script setup lang="ts">

</script>

<style lang="less" scoped>
.common-layout {
    // background-color: #01565d;

    .el-header {
        padding: 0;
        height: 5rem;
    }
}
</style>