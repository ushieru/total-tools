<script setup>
import { useRoute } from 'vue-router';
import { GetProjectById, GetProyectSteps } from '../gql/queries.gql'
import { CreateProyectStep } from '../gql/mutations.gql'
import Cards from '../components/Cards.vue'
import { useMutation, useQuery } from '@vue/apollo-composable';

const route = useRoute()
const { id: projectId } = route.params

const { result: projectResult } = useQuery(GetProjectById, { id: projectId })
const { result: projectStepsResult, refetch: refetchProjectSteps } = useQuery(GetProyectSteps, { projectId: projectId })
const { mutate: createProjectStep } = useMutation(CreateProyectStep)

const showModal = (id) =>
    document.getElementById(id).showModal()

const onNewProjectStepFormSubmit = (e) =>
    createProjectStep({
        name: e.target.name.value,
        order: +Date.now().toString().slice(5),
        projectId: projectId
    }).then(_ => {
        refetchProjectSteps()
        e.target.reset()
        document.getElementById('new_proyect_step_modal').close()
    })

const deleteProject = () => alert("not implemented method")
</script>

<template>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body flex-row justify-between">
                <h1 class="font-bold text-2xl grid place-content-center">{{ projectResult?.projects?.nodes[0]?.name }}
                </h1>
                <div class="dropdown">
                    <div tabindex="0" role="button" class="m-1 btn material-symbols-outlined">settings</div>
                    <ul tabindex="0"
                        class="p-2 shadow menu dropdown-content z-[1] bg-base-100 rounded-box absolute -left-12">
                        <li><button @click="deleteProject">Eliminar</button></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body">
                <div class="flex gap-3">
                    <div v-for="step in projectStepsResult?.projectSteps?.nodes"
                        class="card bg-base-100 shadow-xl w-64 h-min">
                        <div class="card-body">
                            <p class="font-bold">{{ step.name }}</p>
                            <div class="divider m-0"></div>
                            <Cards :step="step" />
                        </div>
                    </div>
                    <button @click="showModal('new_proyect_step_modal')" class="btn btn-primary flex-row w-64">
                        <span class="material-symbols-outlined">
                            add
                        </span>
                        Agregar tablero
                    </button>
                </div>
            </div>
        </div>
    </div>
    <dialog id="new_proyect_step_modal" class="modal">
        <div class="modal-box">
            <h1 class="text-2xl">Nuevo Tablero</h1>
            <div class="divider my-0"></div>
            <form id="new_proyect_step_form" @submit.prevent="onNewProjectStepFormSubmit">
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
                <button form="new_proyect_step_form" class="btn btn-primary">
                    Crear
                </button>
            </div>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button>close</button>
        </form>
    </dialog>
</template>
