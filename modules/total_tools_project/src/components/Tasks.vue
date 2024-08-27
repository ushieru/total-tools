<script setup>
import { ref } from 'vue';
import { useMutation, useQuery } from '@vue/apollo-composable';
import dayjs from 'dayjs';
import { UpdateTask, DeleteTask, CreateTaskComment } from '../gql/mutations.gql'
import { GetTasksComments, WhoAmI } from '../gql/queries.gql'
import { GetSession } from '../utils/GetSession';

const props = defineProps(['task', 'step', 'refetch'])

const isDescriptionEditing = ref(!props.task.description.length)
const comments = ref([])
const session = GetSession()

const { mutate: updateTask } = useMutation(UpdateTask)
const { mutate: deleteTask } = useMutation(DeleteTask)
const { mutate: createTaskComment } = useMutation(CreateTaskComment)
const { onResult, refetch: refetchComments } = useQuery(GetTasksComments, { taskId: props.task.id })
const { result: WhoAmIResult } = useQuery(WhoAmI, { accountId: session.sub })

onResult(({ data }) => {
    if (!data) return
    comments.value = data.taskComments.nodes
})

const showModal = (id) =>
    document.getElementById(id).showModal()

const enableEditingDescription = () =>
    isDescriptionEditing.value = true

const disableEditingDescription = () =>
    isDescriptionEditing.value = false

const onUpdateTaskDescription = (e) =>
    updateTask({
        id: props.task.id,
        description: e.target.description.value
    }).then(_ => {
        props.refetch()
        disableEditingDescription()
    })

const onDeleteTask = () =>
    deleteTask({ id: props.task.id })
        .then(_ => {
            props.refetch()
            document.getElementById('task_modal_' + props.task.id).close()
        })

const onSubmitCommentForm = (e) =>
    createTaskComment({
        taskId: props.task.id,
        comment: e.target.comment.value,
        userId: WhoAmIResult.value.whoAmI.id
    }).then(_ => {
        refetchComments()
        e.target.reset()
    })

</script>

<template>
    <button @click="showModal('task_modal_' + task.id)" class="btn">
        {{ task.name }}
    </button>
    <dialog :id="'task_modal_' + task.id" class="modal">
        <div class="modal-box">
            <div class="flex justify-between relative">
                <h1 class="text-2xl">{{ task.name }}</h1>
                <div class="dropdown absolute right-0">
                    <div tabindex="0" role="button" class="m-1 btn btn-sm material-symbols-outlined">settings</div>
                    <ul tabindex="0"
                        class="p-2 shadow menu dropdown-content z-[1] bg-base-100 rounded-box absolute -left-12">
                        <li><button @click="onDeleteTask">Eliminar</button></li>
                    </ul>
                </div>
            </div>
            <p class="text-sm">En tablero <span class="text-sm font-bold">{{ step.name }}</span></p>
            <div class="divider my-0"></div>
            <p class="font-bold mb-3">Descripcion</p>
            <button v-show="!isDescriptionEditing" @click="enableEditingDescription" class="text-sm text-left w-full">
                {{ task.description }}
            </button>
            <form v-show="isDescriptionEditing" @submit.prevent="onUpdateTaskDescription">
                <label class="form-control w-full">
                    <textarea :value="task.description" class="textarea textarea-bordered" name="description">
                    </textarea>
                </label>
                <div class="m-3"></div>
                <div class="flex justify-end gap-2">
                    <button @click="disableEditingDescription" class="btn">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                </div>
            </form>
            <div class="divider my-0"></div>
            <p class="font-bold mb-3">Comentarios</p>
            <form id="new_comment" @submit.prevent="onSubmitCommentForm">
                <label class="form-control w-full">
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Comentario</span>
                        </div>
                        <input autofocus type="text" name="comment" class="input input-bordered w-full" />
                    </label>
                </label>
                <div class="m-3"></div>
                <div class="flex justify-end gap-2">
                    <button form="new_comment" class="btn btn-sm">Comentar</button>
                </div>
            </form>
            <template v-for="comment in comments">
                <div v-if="comment.user.accountId == session.sub" class="chat chat-end">
                    <div class="chat-image avatar">
                        <div class="w-10 rounded-full bg-primary text-black">
                            <p class="text-center content-center h-full"> {{ comment.user.name.slice(0, 1) }}</p>
                        </div>
                    </div>
                    <div class="chat-header">
                        <span class="ml-1 capitalize">{{ comment.user.name }} {{ comment.user.familyName }}</span>
                    </div>
                    <div class="chat-bubble">{{ comment.comment }}</div>
                    <div class="chat-footer opacity-50">
                        <time class="text-xs">{{ dayjs(comment.createdAt).format('HH:mm') }}</time>
                    </div>
                </div>
                <div v-else class="chat chat-start">
                    <div class="chat-image avatar">
                        <div class="w-10 rounded-full bg-primary text-black">
                            <p class="text-center content-center h-full"> {{ comment.user.name.slice(0, 1) }}</p>
                        </div>
                    </div>
                    <div class="chat-header">
                        <span class="ml-1 capitalize">{{ comment.user.name }} {{ comment.user.familyName }}</span>
                    </div>
                    <div class="chat-bubble">{{ comment.comment }}</div>
                    <div class="chat-footer opacity-50">
                        <time class="text-xs">{{ dayjs(comment.createdAt).format('HH:mm') }}</time>
                    </div>
                </div>
            </template>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button>close</button>
        </form>
    </dialog>
</template>
