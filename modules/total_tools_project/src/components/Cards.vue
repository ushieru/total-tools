<script setup>
import { GetTasksByProjectStepId } from '../gql/queries.gql'
import { AddTask } from '../gql/mutations.gql'
import { useQuery, useMutation } from '@vue/apollo-composable';
import Task from './Tasks.vue'

const { step } = defineProps(['step'])

const { result: tasksResult, refetch } = useQuery(
    GetTasksByProjectStepId,
    { projectStepId: step.id }
)

const { mutate: addTask } = useMutation(AddTask)

const showModal = (id) =>
    document.getElementById(id).showModal()

const onNewStepCardFormSubmit = (e) => {
    const payload = {
        name: e.target.name.value,
        projectStepId: step.id,
    }
    addTask(payload).then(_ => {
        e.target.reset()
        const modalId = e.target.id.replace('new_proyect_step_form_', 'new_card_modal_')
        document.getElementById(modalId).close()
        refetch()
    })
}
</script>

<template>
    <template v-for="task in tasksResult?.tasks?.nodes">
        <Task :task="task" :step="step" :refetch="refetch" />
    </template>
    <button @click="showModal('new_card_modal_' + step.id)" class="btn">
        <span class="material-symbols-outlined">
            add
        </span>
        Agregar tarjeta
    </button>
    <dialog :id="'new_card_modal_' + step.id" class="modal">
        <div class="modal-box">
            <h1 class="text-2xl">Nueva Tarjeta</h1>
            <p class="text-sm">En tablero <span class="text-sm font-bold">{{ step.name }}</span></p>
            <div class="divider my-0"></div>
            <form :id="'new_proyect_step_form_' + step.id" @submit.prevent="onNewStepCardFormSubmit">
                <label class="form-control w-full">
                    <div class="label">
                        <span class="label-text">Nombre</span>
                    </div>
                    <input type="text" name="name" class="input input-bordered w-full" />
                </label>
            </form>
            <div class="modal-action">
                <form method="dialog">
                    <button class="btn">Cancelar</button>
                </form>
                <button :form="'new_proyect_step_form_' + step.id" class="btn btn-primary">
                    Crear
                </button>
            </div>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button>close</button>
        </form>
    </dialog>
</template>
