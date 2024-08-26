<script setup>
import { GetProjects } from '../gql/queries.gql'
import { CreateNewProject } from '../gql/mutations.gql'
import { useMutation, useQuery } from '@vue/apollo-composable';

const { result: projectsResult, refetch: projectsRefetch } = useQuery(GetProjects)
const { mutate: createNewProject } = useMutation(CreateNewProject)

const showNewProyectModal = () =>
    document.getElementById('new_proyect_modal').showModal()

const onNewProjectFormSubmit = (e) =>
    createNewProject({ name: e.target.name.value })
        .then(_ => {
            projectsRefetch()
            e.target.reset()
            document.getElementById('new_proyect_modal').close()
        })
</script>

<template>
    <div class="card bg-base-200 shadow-xl mb-5">
        <div class="card-body">
            <button @click="showNewProyectModal" class="btn btn-primary w-40">Nuevo Proyecto</button>
        </div>
    </div>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl grid grid-cols-4 gap-2 p-5">
            <template v-for="project in projectsResult?.projects?.nodes">
                <RouterLink :to="'/projects/' + project.id" class="card bg-base-100 shadow-xl p-5">
                    {{ project.name }}
                </RouterLink>
            </template>
        </div>
    </div>
    <dialog id="new_proyect_modal" class="modal">
        <div class="modal-box">
            <h1 class="text-2xl">Nuevo Proyecto</h1>
            <div class="divider my-0"></div>
            <form id="new_proyect_form" @submit.prevent="onNewProjectFormSubmit">
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
                <button form="new_proyect_form" class="btn btn-primary">
                    Crear
                </button>
            </div>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button>close</button>
        </form>
    </dialog>
</template>
