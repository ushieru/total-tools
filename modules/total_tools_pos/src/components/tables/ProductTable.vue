<script setup>
import dayjs from 'dayjs'
import { ref } from 'vue';
import { DeleteProduct } from '@pos/gql/mutations.gql'
import { GetProducts } from '@pos/gql/queries.gql'
import { useQuery, useMutation } from '@vue/apollo-composable';

const search = ref('')
const { result: products, refetch: reloadProducts } = useQuery(GetProducts)
const { mutate: deleteProduct } = useMutation(DeleteProduct)

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
                    <th>Descripcion</th>
                    <th>Precio</th>
                    <th>Disponible desde</th>
                    <th>Disponible hasta</th>
                    <th>Desde hora</th>
                    <th>Hasta hora</th>
                    <th>Dias</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="product in products?.products?.nodes?.filter(d => d.name.toLowerCase().startsWith(search.toLowerCase()))"
                    class="border-neutral">
                    <th>{{ product.id }}</th>
                    <td>{{ product.name }}</td>
                    <td class="w-1/6">{{ product.description }}</td>
                    <td>${{ product.price }}</td>
                    <td>{{ dayjs(product.availableFrom).format('DD MMMM YYYY') }}</td>
                    <td>{{ dayjs(product.availableUntil).format('DD MMMM YYYY') }}</td>
                    <td>{{ product.availableFromHour.slice(0, -3) }} hrs</td>
                    <td>{{ product.availableUntilHour.slice(0, -3) }} hrs</td>
                    <td class="w-1/6">
                        <span v-for="d in product.availableDays"
                            class="badge badge-accent badge-sm font-semibold mx-[1px]">
                            {{ weekdayName(d) }}
                        </span>
                    </td>
                    <td class="flex gap-2">
                        <button class="btn btn-sm btn-error" @click="showModal(`delete_product_${product.id}`)">
                            <span class="material-symbols-outlined">
                                delete
                            </span>
                        </button>
                        <RouterLink :to="`/admin/products/${product.id}/edit`">
                            <button class="btn btn-sm btn-primary">
                                <span class="material-symbols-outlined">
                                    edit
                                </span>
                            </button>
                        </RouterLink>
                        <RouterLink :to="`/admin/products/${product.id}/categories`">
                            <button class="btn btn-sm btn-secondary">
                                <span class="material-symbols-outlined">
                                    add_link
                                </span>
                            </button>
                        </RouterLink>
                    </td>
                    <dialog :id="`delete_product_${product.id}`" class="modal">
                        <div class="modal-box">
                            <h3 class="font-bold text-lg">Eliminar categoria {{ product.name }} con Id: "{{ product.id
                                }}"?
                            </h3>
                            <div class="modal-action">
                                <form method="dialog">
                                    <button class="btn">Cancelar</button>
                                </form>
                                <form method="dialog">
                                    <button class="btn btn-primary"
                                        @click="() => deleteProduct({ id: product.id }).then(reloadProducts)">Eliminar</button>
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
