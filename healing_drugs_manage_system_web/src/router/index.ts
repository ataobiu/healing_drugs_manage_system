import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/home',
    component: () => import('@/layout/layout.vue'),
    children: [
      {
        // 首页
        path: 'home',
        component: () => import('@/views/HomeView.vue'),
      },
      {
        // 修改个人信息
        path: 'updateUser',
        component: () => import('@/views/updateUser.vue'),
      },
      {
        // 修改系统公告
        path: 'updateSys',
        component: () => import('@/views/updateSys.vue'),
      },
      {
        // 药品分类
        path: 'medicine/class',
        component: () => import('@/views/MedicineClass.vue'),
      },
      {
        // 药品出入管理
        path: 'medicine/record',
        component: () => import('@/views/record.vue'),
      }
    ]
  },
  {
    // 登录
    path: '/login',
    component: () => import('@/views/Login.vue')
  },
  {
    // 注册
    path: '/register',
    component: () => import('@/views/Register.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

import { ElNotification } from 'element-plus'

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  if (to.path == '/login' || to.path == '/register') {
    next()
  } else if (token) {
    next()
  } else if (!token) {
    ElNotification({
      title: '失败',
      message: '请先登录！',
      type: 'warning',
    })
    next('/login')
  }
})
export default router
