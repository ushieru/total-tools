import { createApp, provide, h } from 'vue'
import { DefaultApolloClient } from '@vue/apollo-composable'
import 'material-symbols/outlined.css'
import './style.css'
import App from './App.vue'
import { AppRouter } from './router'
import { apolloClient } from './utils/ApolloClient'

createApp({
    setup() {
        provide(DefaultApolloClient, apolloClient)
    },
    render() {
        return h(App)
    }
})
    .use(AppRouter)
    .mount('#app')
