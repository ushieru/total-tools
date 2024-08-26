<script setup>
import { useQuery } from '@vue/apollo-composable';
import { GetUsers } from '@/gql/queries.gql'

const { result: usersResult } = useQuery(GetUsers)
const showModal = (id) => document.getElementById(id).showModal()
</script>

<template>
    <div class="card bg-base-200 shadow-xl mb-5">
        <div class="card-body">
            <RouterLink to="/admin/users/new" class="w-40">
                <button class="btn btn-primary w-40">Nuevo Usuario</button>
            </RouterLink>
        </div>
    </div>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body">
                <div class="overflow-x-auto">
                    <table class="table">
                        <thead>
                            <tr class="border-neutral border-b-2">
                                <th>Id</th>
                                <th>Nombre</th>
                                <th>Correo</th>
                                <th>Celular</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-neutral" v-for="user in usersResult?.users?.nodes">
                                <th>{{ user.id }}</th>
                                <td>{{ `${user.name} ${user.familyName}` }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.cellphone }}</td>
                                <td class="flex gap-2">
                                    <button class="btn btn-sm btn-error" @click="showModal(user.id)">
                                        <span class="material-symbols-outlined">
                                            delete
                                        </span>
                                    </button>
                                    <button class="btn btn-sm btn-primary">
                                        <span class="material-symbols-outlined">
                                            edit
                                        </span>
                                    </button>
                                </td>
                                <dialog :id="user.id" class="modal">
                                    <div class="modal-box">
                                        <h1 class="text-2xl">Eliminar usuario</h1>
                                        <div class="divider my-0"></div>
                                        <h3 class="text-lg">
                                            Seguro que desea eliminar a
                                            <span class="font-bold">{{ `${user.name} ${user.family_name}` }}</span>
                                            con ID: <span class="font-bold">{{ user.id }}</span>?
                                        </h3>
                                        <div class="modal-action">
                                            <form method="dialog">
                                                <button class="btn">Cancelar</button>
                                            </form>
                                            <form method="dialog">
                                                <button class="btn btn-error">
                                                    Eliminar
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                    <form method="dialog" class="modal-backdrop">
                                        <button>close</button>
                                    </form>
                                </dialog>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>