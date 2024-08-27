import { defineConfig } from 'vite'
import { resolve } from 'node:path'
import vue from '@vitejs/plugin-vue'
import graphql from '@rollup/plugin-graphql'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [
        vue(),
        graphql()
    ],
    resolve: {
        alias: {
            '@': resolve(__dirname, 'frontend'),
            '@common': resolve(__dirname, 'modules', 'common'),
            '@pos': resolve(__dirname, 'modules', 'total_tools_pos', 'src')
        }
    },
    build: {
        rollupOptions: {
            input: {
                main: resolve(__dirname, 'index.html'),
                project: resolve(__dirname, 'modules/total_tools_project/index.html'),
            },
        },
    },
})
