<script setup>
import { ref } from 'vue'
import { useQuery, useMutation } from '@vue/apollo-composable';
import { useRouter, useRoute } from 'vue-router'
import { GetProductById } from '@pos/gql/queries.gql'
import { UpdateProductById } from '@pos/gql/mutations.gql'

const router = useRouter()
const route = useRoute()
const { id: productId } = route.params
const { loading, onResult } = useQuery(GetProductById, { id: productId })
const { mutate: updateProduct } = useMutation(UpdateProductById)

const product = ref()

onResult(({ data }) => {
    if (!data) return
    if (!data.product) return router.push("/admin/products")
    product.value = data.product
})

const dayIsChecked = (weekday) => {
    return product.value.availableDays.includes(weekday)
}
const onSubmitUpdateProduct = (e) => {
    const availableDays = []
    if (e.target.sunday.checked) availableDays.push(0)
    if (e.target.monday.checked) availableDays.push(1)
    if (e.target.tuesday.checked) availableDays.push(2)
    if (e.target.wednesday.checked) availableDays.push(3)
    if (e.target.thursday.checked) availableDays.push(4)
    if (e.target.friday.checked) availableDays.push(5)
    if (e.target.saturday.checked) availableDays.push(6)

    const payload = {
        id: productId,
        name: e.target.name.value,
        description: e.target.description.value,
        price: +e.target.price.value,
        availableFrom: new Date(e.target.available_from.value),
        availableUntil: new Date(e.target.available_until.value),
        availableFromHour: e.target.available_from_hour.value,
        availableUntilHour: e.target.available_until_hour.value,
        availableDays
    }

    updateProduct(payload).then(_ =>
        router.push("/admin/products"))
}
</script>

<template>
    <div v-if="loading" class="card bg-base-200 shadow-xl">
        <div class="card-body">
            <span class="loading loading-dots loading-lg m-auto"></span>
        </div>
    </div>

    <div v-if="product" class="card bg-base-200 shadow-xl">
        <div class="card-body">
            <h1 class="text-2xl">Actualizar Producto</h1>
            <form @submit.prevent="onSubmitUpdateProduct" class="grid grid-cols-1 lg:grid-cols-2 gap-2">
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Nombre</span>
                    </div>
                    <input :value="product.name" type="text" name="name" class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Precio</span>
                    </div>
                    <input :value="product.price" type="number" inputmode="numeric" name="price"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full lg:col-span-2">
                    <div class="label">
                        <span class="label-text">Descripcion</span>
                    </div>
                    <input :value="product.description" type="text" name="description"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible desde</span>
                    </div>
                    <input :value="product.availableFrom" type="date" name="available_from"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible hasta</span>
                    </div>
                    <input :value="product.availableUntil" type="date" name="available_until"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible desde la hora</span>
                    </div>
                    <input :value="product.availableFromHour" type="time" name="available_from_hour"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible hasta la hora</span>
                    </div>
                    <input :value="product.availableUntilHour" type="time" name="available_until_hour"
                        class="input input-bordered w-full" />
                </label>
                <h1 class="font-bold text-gl lg:col-span-2">Dias disponible:</h1>
                <div class="lg:col-span-2">
                    <div class="grid grid-cols-2 lg:grid-cols-4 xl:grid-cols-7 gap-3">
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Lunes</span>
                                <input :checked="dayIsChecked(1)" name="monday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Martes</span>
                                <input :checked="dayIsChecked(2)" name="tuesday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Miercoles</span>
                                <input :checked="dayIsChecked(3)" name="wednesday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Jueves</span>
                                <input :checked="dayIsChecked(4)" name="thursday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Viernes</span>
                                <input :checked="dayIsChecked(5)" name="friday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Sabado</span>
                                <input :checked="dayIsChecked(6)" name="saturday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Domingo</span>
                                <input :checked="dayIsChecked(0)" name="sunday" type="checkbox" class="checkbox" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="lg:col-span-2 lg:grid lg:justify-end mt-3">
                    <button class="w-full btn btn-primary lg:w-60">Actualizar</button>
                </div>
            </form>
        </div>
    </div>
</template>
