import { createWebHistory, createRouter } from 'vue-router'
import Login from '@/routes/Login.vue'
import Logout from '@/routes/Logout.vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import AdminUsers from '@/routes/admin/users/index.vue'
import AdminNewUser from '@/routes/admin/users/new.vue'
import AdminEditUser from '@/routes/admin/users/[id]/edit.vue'
import AdminModules from '@/routes/admin/modules/index.vue'
import AdminModuleAccounts from '@/routes/admin/modules/[id]/accounts.vue'

const routes = [
    { path: '/', component: Login },
    { path: '/logout', component: Logout },
    {
        path: '/admin',
        component: AdminLayout,
        children: [
            { path: 'users', component: AdminUsers },
            { path: 'users/new', component: AdminNewUser },
            { path: 'users/:id/edit', component: AdminEditUser },
            { path: 'modules', component: AdminModules },
            { path: 'modules/:id/accounts', component: AdminModuleAccounts },
        ]
    }
]

export const AppRouter = createRouter({
    history: createWebHistory(),
    routes,
})
