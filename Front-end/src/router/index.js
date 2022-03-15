import Vue from 'vue'
import VueRouter from 'vue-router'


Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name:"home",
        component: () => import('@/views/home'),
    },

    {
        path: '/createExchange',
        name:"createExchange",
        component: () => import('@/views/createExchange'),
    },
    {
        path: '/manager',
        name:"manager",
        component: () => import('@/views/manager'),
    },
    {
        path: '/exchangeFactory',
        name:"exchangeFactory",
        component: () => import('@/views/exchangeFactory'),
    },
]
const router = new VueRouter({
    routes
})

export default router
