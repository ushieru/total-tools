<script setup>
import { ref } from 'vue';

const { task: originalTask, step, refetch } = defineProps(['task', 'step', 'refetch'])

const task = ref({ ...originalTask })
const isDescriptionEditing = ref(!originalTask.description.length)
const comments = ref([])
const session = getSession()

const showModal = (id) =>
    document.getElementById(id).showModal()

const enableEditingDescription = () =>
    isDescriptionEditing.value = true

const disableEditingDescription = () =>
    isDescriptionEditing.value = false

const onUpdateTaskDescription = (e) => postgrest
    .from('task')
    .update({ description: e.target.description.value })
    .eq('id', originalTask.id)
    .then(response => {
        if (response.status != 204) return
        task.value.description = e.target.description.value
        disableEditingDescription()
    })

const deleteTask = () => postgrest
    .from('task')
    .delete()
    .eq('id', originalTask.id)
    .then(response => {
        if (!(response.status >= 200 && response.status < 300)) return
        refetch()
    })

const fetchComments = () => postgrest
    .from('task_comment')
    .select('*')
    .eq('task_id', originalTask.id)
    .then(response => comments.value = response.data)

const onSubmitCommentForm = (e) => postgrest
    .from('task_comment')
    .insert({
        comment: e.target.comment.value,
        account_id: session.sub,
        task_id: originalTask.id
    })
    .then(response => {
        if (response.status != 201) return
        fetchComments()
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
                        <li><button @click="deleteTask">Eliminar</button></li>
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
            <form @submit.prevent="onSubmitCommentForm">
                <label class="form-control w-full">
                    <label class="form-control w-full">
                        <div class="label">
                            <span class="label-text">Comentario</span>
                        </div>
                        <input type="text" name="comment" class="input input-bordered w-full" />
                    </label>
                </label>
                <div class="m-3"></div>
                <div class="flex justify-end gap-2">
                    <button class="btn btn-sm">Comentar</button>
                </div>
            </form>
            <template v-for="comment in comments">
                <div v-if="comment.account_id == session.sub" class="chat chat-end">
                    <div class="chat-image avatar">
                        <div class="w-10 rounded-full">
                            <img alt="Tailwind CSS chat bubble component" src="https://thispersondoesnotexist.com/" />
                        </div>
                    </div>
                    <div class="chat-header">
                        <time class="text-xs opacity-50">{{ comment.created_at.split('T')[0] }}</time>
                    </div>
                    <div class="chat-bubble">{{ comment.comment }}</div>
                </div>
                <div v-else class="chat chat-start">
                    <div class="chat-image avatar">
                        <div class="w-10 rounded-full">
                            <img alt="Tailwind CSS chat bubble component" src="https://thispersondoesnotexist.com/" />
                        </div>
                    </div>
                    <div class="chat-header">
                        Obi-Wan Kenobi
                        <time class="text-xs opacity-50">12:46</time>
                    </div>
                    <div class="chat-bubble">You were the Chosen One!</div>
                </div>
            </template>
        </div>
        <form method="dialog" class="modal-backdrop">
            <button>close</button>
        </form>
    </dialog>
</template>