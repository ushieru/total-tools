<script setup>
import dayjs from 'dayjs'
import { DeleteCategory } from '@pos/gql/mutations.gql'
import { GetCategories } from '@pos/gql/queries.gql'
import { useMutation, useQuery } from '@vue/apollo-composable';
import { ref } from 'vue';

const search = ref('')
const { result: categories, refetch: reloadCategories } =
    useQuery(GetCategories, null, {
        pollInterval: 5000
    })
const { mutate: deleteCategory } = useMutation(DeleteCategory)

const weekdayName = (weekday) => {
    switch (weekday) {
        case 0: return 'Domingo'
        case 1: return 'Lunes'
        case 2: return 'Martes'
        case 3: return 'Miercoles'
        case 4: return 'Jueves'
        case 5: return 'Viernes'
        case 6: return 'Sabado'
    }
    return 'unknown'
}

const showModal = (id) => document.getElementById(id).showModal()
</script>

<template>
    <label class="input input-borderedflex flex items-center gap-2 mb-5">
        <span class="material-symbols-outlined"> search </span>
        <input v-model="search" type="text" class="bg-base-100 grow" placeholder="Buscar" />
    </label>
    <div class="overflow-x-auto">
        <table class="table">
            <thead>
                <tr class="border-neutral border-b-2">
                    <th>id</th>
                    <th>Nombre</th>
                    <th>Disponible desde</th>
                    <th>Disponible hasta</th>
                    <th>Desde hora</th>
                    <th>Hasta hora</th>
                    <th>Dias</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="category in categories?.categories?.nodes?.filter(d => d.name.toLowerCase().startsWith(search.toLowerCase()))"
                    class="border-neutral">
                    <th>{{ category.id }}</th>
                    <td>{{ category.name }}</td>
                    <td>{{ dayjs(category.availableFrom).format('DD MMMM YYYY') }}</td>
                    <td>{{ dayjs(category.availableUntil).format('DD MMMM YYYY') }}</td>
                    <td>{{ category.availableFromHour.slice(0, -3) }} hrs</td>
                    <td>{{ category.availableUntilHour.slice(0, -3) }} hrs</td>
                    <td class="w-1/5">
                        <span v-for="d in category.availableDays"
                            class="badge badge-accent badge-sm font-semibold mx-[1px]">
                            {{ weekdayName(d) }}
                        </span>
                    </td>
                    <td class="flex gap-2">
                        <button class="btn btn-sm btn-error" @posclick="showModal(`delete_category_${category.id}`)">
                            <span class="material-symbols-outlined">
                                delete
                            </span>
                        </button>
                        <RouterLink :to="`/admin/categories/${category.id}/edit`">
                            <button class="btn btn-sm btn-primary">
                                <span class="material-symbols-outlined">
                                    edit
                                </span>
                            </button>
                        </RouterLink>
                    </td>
                    <dialog :id="`delete_category_${category.id}`" class="modal">
                        <div class="modal-box">
                            <h3 class="text-lg">Eliminar categoria <span class="font-bold">{{ category.name }}</span>
                                <br>ID <span class="font-bold">{{ category.id }}</span>?
                            </h3>
                            <div class="modal-action">
                                <form method="dialog">
                                    <button class="btn">Cancelar</button>
                                </form>
                                <form method="dialog">
                                    <button class="btn btn-primary"
                                        @posclick="() => deleteCategory({ id: category.id }).then(reloadCategories)">Eliminar</button>
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
</template>
