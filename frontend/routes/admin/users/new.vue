<script setup>
import { useRouter } from 'vue-router'
import { CreateUser } from '@/gql/mutations.gql'
import { useMutation } from '@vue/apollo-composable';

const router = useRouter()

const { mutate: createUser } = useMutation(CreateUser)

const onNewUserFormSubmit = (e) => {
    const password = e.target.password.value
    const passwordConfirm = e.target.password_confirm.value
    if (password != passwordConfirm) {
        alert("Las contraselas no coinciden")
    }
    const payload = {
        name: e.target.name.value,
        familyName: e.target.family_name.value,
        email: e.target.email.value,
        cellphone: e.target.cellphone.value,
        username: e.target.username.value,
        password: e.target.password.value,
        isAdmin: e.target.is_admin.checked
    }
    createUser({ input: payload })
        .then(_ => router.push("/admin/users"))
}
</script>

<template>
    <div class="text-sm breadcrumbs mb-5">
        <ul>
            <li>
                <RouterLink to="/admin/users">Usuarios</RouterLink>
            </li>
            <li>Nuevo</li>
        </ul>
    </div>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body">
                <h1 class="text-2xl">Nueva usuario</h1>
                <form @submit.prevent="onNewUserFormSubmit" class="grid grid-cols-1 lg:grid-cols-2 gap-2">
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Nombre</span>
                        </div>
                        <input type="text" name="name" class="input input-bordered w-full" />
                    </label>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Apellidos</span>
                        </div>
                        <input type="text" name="family_name" class="input input-bordered w-full" />
                    </label>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Email</span>
                        </div>
                        <input type="email" name="email" autocomplete="email" class="input input-bordered w-full" />
                    </label>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Celular</span>
                        </div>
                        <input type="tel" name="cellphone" autocomplete="tel" class="input input-bordered w-full" />
                    </label>
                    <div class="divider lg:col-span-2">Cuenta</div>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Nombre de Usuario</span>
                        </div>
                        <input type="text" name="username" autocomplete="username"
                            class="input input-bordered w-full" />
                    </label>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Contraseña</span>
                        </div>
                        <input type="password" name="password" autocomplete="new-password"
                            class="input input-bordered w-full" />
                    </label>
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Confirme contraseña</span>
                        </div>
                        <input type="password" name="password_confirm" autocomplete="new-password"
                            class="input input-bordered w-full" />
                    </label>
                    <label class="form-control items-end w-full lg:col-span-2">
                        <div class="label">
                            <span class="label-text">Admin</span>
                        </div>
                        <input name="is_admin" type="checkbox" class="toggle toggle-success" />
                    </label>

                    <div class="lg:col-span-2 lg:grid lg:justify-end mt-3">
                        <button class="w-full btn btn-primary lg:w-60">Crear</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>