import { createWebHistory, createRouter } from 'vue-router'
import MainLayout from './layouts/MainLayout.vue'
import Board from './routes/Board.vue'
import Project from './routes/Project.vue'

const routes = [
    {
        path: '/',
        component: MainLayout,
        children: [
            { path: '', component: Board },
            { path: 'projects/:id', component: Project },
        ]
    },
]

export const AppRouter = createRouter({
    history: createWebHistory('/modules/total_tools_project/'),
    routes,
})
