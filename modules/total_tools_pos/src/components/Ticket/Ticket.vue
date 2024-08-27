<script setup>
import { computed, ref } from 'vue'
import { useRoute } from 'vue-router'
import { useQuery } from '@vue/apollo-composable';
import { GetAvailableCategories, GetTicket } from '@pos/gql/queries.gql'
import CategoryProducts from '@pos/components/Ticket/CategoryProducts.vue'
import TicketProducts from '@pos/components/Ticket/TicketProducts.vue'

const route = useRoute()
const { id } = route.params

const currentCategory = ref()

const { result: ticketResult, refetch: ticketRefetch } = useQuery(GetTicket, { id })
const { result: availableCategories, onResult } = useQuery(GetAvailableCategories, null, { pollInterval: 5000 })

const ticket = computed(() => ticketResult.value?.ticket)

onResult(({ data }) => {
    if (!data) return
    const availableCategories = data?.availableCategories?.nodes
    if (!availableCategories.length) return
    selectCategory(availableCategories[0])
})

const selectCategory = (category) => currentCategory.value = category
</script>

<template>
    <div class="grow flex gap-2">
        <div class="grow flex flex-col gap-3">
            <div class="card bg-base-200 shadow-xl">
                <div class="card-body flex-row gap-2 overflow-x-auto">
                    <button v-for="category in availableCategories?.availableCategories?.nodes" class="btn"
                        :class="{ 'btn-primary': currentCategory?.id == category.id }"
                        @click="selectCategory(category)">
                        {{ category.name }}
                    </button>
                </div>
            </div>
            <div class="grow card bg-base-200 shadow-xl">
                <div class="card-body">
                    <div v-if="!currentCategory" class="text-center">
                        <span class="loading loading-dots loading-lg"></span>
                    </div>
                    <div v-else
                        class="p-5 overflow-y-auto grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 auto-rows-max gap-3 sm:gap-4">
                        <CategoryProducts :ticket="ticket" :categoryId="currentCategory?.id"
                            :ticketRefetch="ticketRefetch" />
                    </div>
                </div>
            </div>
            <div class="flex lg:hidden card bg-base-200 shadow-xl">
                <div class="card-body flex-row gap-2 overflow-x-auto">
                    <button class="btn btn-primary w-full" onclick="ticket_modal.showModal()">
                        Ticket
                    </button>
                    <dialog id="ticket_modal" class="modal">
                        <div class="modal-box flex flex-col h-[80%]">
                            <TicketProducts v-if="ticket" :ticket="ticket" :ticketRefetch="ticketRefetch" />
                        </div>
                        <form method="dialog" class="modal-backdrop">
                            <button>close</button>
                        </form>
                    </dialog>
                </div>
            </div>
        </div>
        <div class="hidden lg:flex card bg-base-200 shadow-xl w-[450px] h-[95vh]">
            <div v-if="ticket" class="card-body h-full">
                <TicketProducts :ticket="ticket" :ticketRefetch="ticketRefetch" />
            </div>
        </div>
    </div>
    <!-- <PayTicketModal v-if="ticket" :ticket="ticket" :goToTickets="() => goToTickets()" />
    <dialog id="paid_modal" class="modal">
        <div class="modal-box">
            <h3 class="font-bold text-lg">Este ticket ya esta pagado</h3>
            <div class="flex justify-end">
                <button @click="goToTickets" class="btn btn-primary">Volver</button>
            </div>
        </div>
    </dialog> -->
</template>
