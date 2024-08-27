<script setup>
import { useRouter } from 'vue-router'
import { CreateCategory } from '@pos/gql/mutations.gql'
import { useMutation } from '@vue/apollo-composable';

const router = useRouter()
const { mutate: createCategory } = useMutation(CreateCategory)

const onSubmitCreateCategory = (e) => {
    const availableDays = []
    if (e.target.sunday.checked) availableDays.push(0)
    if (e.target.monday.checked) availableDays.push(1)
    if (e.target.tuesday.checked) availableDays.push(2)
    if (e.target.wednesday.checked) availableDays.push(3)
    if (e.target.thursday.checked) availableDays.push(4)
    if (e.target.friday.checked) availableDays.push(5)
    if (e.target.saturday.checked) availableDays.push(6)
    const payload = {
        name: e.target.name.value,
        availableFrom: new Date(e.target.available_from.value),
        availableUntil: new Date(e.target.available_until.value),
        availableFromHour: e.target.available_from_hour.value,
        availableUntilHour: e.target.available_until_hour.value,
        availableDays: availableDays
    }
    createCategory(payload).then(_ =>
        router.push("/admin/categories"))
}
</script>

<template>
    <div class="card bg-base-200 shadow-xl">
        <div class="card-body">
            <h1 class="text-2xl">Nueva Categoria</h1>
            <form @submit.prevent="onSubmitCreateCategory" class="grid grid-cols-1 lg:grid-cols-2 gap-2">
                <label class="form-control w-full lg:col-span-2">
                    <div class="label">
                        <span class="label-text">Nombre</span>
                    </div>
                    <input type="text" name="name" class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible desde</span>
                    </div>
                    <input :value="new Date().toISOString().split('T')[0]" type="date" name="available_from"
                        class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible hasta</span>
                    </div>
                    <input
                        :value="new Date(new Date().getFullYear() + 1, new Date().getMonth(), new Date().getDate()).toISOString().split('T')[0]"
                        type="date" name="available_until" class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible desde la hora</span>
                    </div>
                    <input value="00:00" type="time" name="available_from_hour" class="input input-bordered w-full" />
                </label>
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Disponible hasta la hora</span>
                    </div>
                    <input value="23:59" type="time" name="available_until_hour" class="input input-bordered w-full" />
                </label>
                <h1 class="font-bold text-gl lg:col-span-2">Dias disponible:</h1>
                <div class="lg:col-span-2">
                    <div class="grid grid-cols-2 lg:grid-cols-4 xl:grid-cols-7 gap-3">
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Lunes</span>
                                <input name="monday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Martes</span>
                                <input name="tuesday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Miercoles</span>
                                <input name="wednesday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Jueves</span>
                                <input name="thursday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Viernes</span>
                                <input name="friday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Sabado</span>
                                <input name="saturday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                        <div class="badge w-full h-full">
                            <label class="label cursor-pointer w-full">
                                <span class="label-text">Domingo</span>
                                <input name="sunday" type="checkbox" class="checkbox" checked />
                            </label>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-2 lg:grid lg:justify-end mt-3">
                    <button class="w-full btn btn-primary lg:w-60">Crear</button>
                </div>
            </form>
        </div>
    </div>
</template>
