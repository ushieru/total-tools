<script setup>
import { useRouter } from 'vue-router'
import { useMutation } from '@vue/apollo-composable'
import { Authenticate } from '@/gql/mutations.gql'
import favicon from '@/assets/favicon.svg'

localStorage.removeItem(import.meta.env.VITE_JWT_LOCAL_STORAGE_KEY)

const router = useRouter()

const { mutate: authenticate } = useMutation(Authenticate)

const onLoginFormSubmit = (e) => {
    const payload = {
        username: e.target.username.value,
        password: e.target.password.value
    }
    authenticate(payload).then(response => {
        const token = response.data.authenticate.jwtToken
        localStorage.setItem(import.meta.env.VITE_JWT_LOCAL_STORAGE_KEY, token)
        router.push('/admin/users')
    })
}
</script>

<template>
    <div class="grid place-items-center h-screen">
        <div class="card w-96 bg-neutral text-neutral-content">
            <div class="card-body items-center text-center">
                <img :src="favicon" class="w-[110px] mb-7" alt="favicon" />
                <form @submit.prevent="onLoginFormSubmit" class="flex flex-col gap-1">
                    <input name="username" type="text" autocomplete="username" placeholder="Nombre de Usuario"
                        class="input input-bordered w-full" />
                    <input name="password" type="password" autocomplete="current-password" placeholder="Contraseña"
                        class="input input-bordered w-full" />
                    <div class="card-actions w-full">
                        <button class="btn btn-primary w-full mt-1">Iniciar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
