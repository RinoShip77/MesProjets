import { createRouter, createWebHashHistory } from "vue-router";

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'login',
      component: () => import('@/views/pages/Login.vue')
    }, {
      path: '/createAccount',
      name: 'accountCreation',
      component: () => import('@/views/pages/AccountCreation.vue')
    }, {
      path: '/allies',
      name: 'allies',
      component: () => import('@/views/pages/AlliesPage.vue')
    },
    {
      path: '/elements',
      name: 'elements',
      component: () => import('@/views/pages/ElementsPage.vue')
    },
    {
      path: '/leaderboard',
      name: 'leaderboard',
      component: () => import('@/views/pages/LeaderboardPage.vue')
    }
  ]
});

export default router;