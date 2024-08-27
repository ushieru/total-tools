import { createWebHistory, createRouter } from 'vue-router'
import AdminLayout from '@pos/layouts/AdminLayout.vue'
import AdminIndex from '@pos/routes/admin/index.vue'
import AdminCategories from '@pos/routes/admin/categories/index.vue'
import AdminNewCategory from '@pos/routes/admin/categories/new.vue'
import AdminEditCategory from '@pos/routes/admin/categories/edit.vue'
import AdminProducts from '@pos/routes/admin/products/index.vue'
import AdminNewProduct from '@pos/routes/admin/products/new.vue'
import AdminEditProduct from '@pos/routes/admin/products/edit.vue'
import AdminEditProductCategories from '@pos/routes/admin/products/edit_categories.vue'
import AdminProductionCenters from '@pos/routes/admin/production_centers/index.vue'
import AdminTables from '@pos/routes/admin/tables/index.vue'
import AdminTickets from '@pos/routes/admin/tickets/index.vue'
import CashierLayout from '@pos/layouts/CashierLayout.vue'
import CashierIndex from '@pos/routes/cashier/index.vue'
import CashierNewTicket from '@pos/routes/cashier/new_ticket.vue'
import CashierTickets from '@pos/routes/cashier/tickets.vue'
import CashierTicket from '@pos/routes/cashier/ticket.vue'

const routes = [
    {
        path: '/',
        redirect: '/admin',
        children: [
            {
                path: 'admin', component: AdminLayout, children: [
                    { path: '', component: AdminIndex },
                    { path: 'categories', component: AdminCategories },
                    { path: 'categories/new', component: AdminNewCategory },
                    { path: 'categories/:id/edit', component: AdminEditCategory },
                    { path: 'products', component: AdminProducts },
                    { path: 'products/new', component: AdminNewProduct },
                    { path: 'products/:id/edit', component: AdminEditProduct },
                    { path: 'products/:id/categories', component: AdminEditProductCategories },
                    { path: 'production-centers', component: AdminProductionCenters },
                    { path: 'tables', component: AdminTables },
                    { path: 'tickets', component: AdminTickets },
                ]
            },
            {
                path: 'cashier', component: CashierLayout, children: [
                    { path: '', component: CashierIndex },
                    { path: 'new', component: CashierNewTicket },
                    { path: 'tickets', component: CashierTickets },
                    { path: 'tickets/:id', component: CashierTicket },
                ]
            }
        ]
    }
]

export const AppRouter = createRouter({
    history: createWebHistory('/modules/total_tools_pos/'),
    routes,
})
