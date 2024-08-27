<script setup>
import { computed } from 'vue';
import { useMutation } from '@vue/apollo-composable';
import { AddTicketProduct, DeleteTicketProduct } from '@pos/gql/mutations.gql'

const props = defineProps(['ticket', 'ticketRefetch'])
const ticketProducts = computed(() =>
    Object.values(
        Object.groupBy(
            props.ticket.ticketProducts.nodes,
            ({ productId }) => productId
        )
    ).sort((a, b) => a[0].productId.localeCompare(b[0].productId)))

const { mutate: addTicketProduct } = useMutation(AddTicketProduct)
const { mutate: deleteTicketProduct } = useMutation(DeleteTicketProduct)

const addProduct = (product) => {
    const payload = {
        productId: product.productId,
        name: product.name,
        description: product.description,
        price: product.price,
        ticketId: props.ticket.id
    }
    addTicketProduct(payload)
        .then(_ => props.ticketRefetch())
}

const removeProduct = (product) => {
    deleteTicketProduct({ id: product.id })
        .then(_ => props.ticketRefetch())
}
</script>

<template>
    <h1 class="text-2xl font-bold">Ticket: {{ ticket.id }}</h1>
    <div class="divider"></div>
    <div class="h-full overflow-y-auto gap-2 flex flex-col">
        <div v-for="ticketProduct in ticketProducts" class="card bg-base-100 shadow-xl">
            <div class="card-body p-3">
                <div class="flex justify-between">
                    <span class="font-bold">{{ ticketProduct[0].name }}</span>
                    <span class="">${{ ticketProduct[0].price }} c/u</span>
                </div>
                <div class="flex justify-between">
                    <span class="flex items-center gap-2">
                        <button class="btn btn-sm" @click="removeProduct(ticketProduct[0])"
                            :disabled="!(ticketProduct.some(({ status }) => status == 'ADDED'))">
                            <span v-if="ticketProduct.length == 1" class="material-symbols-outlined">
                                delete
                            </span>
                            <span v-else class="material-symbols-outlined">
                                remove
                            </span>
                        </button>
                        {{ ticketProduct.length }}
                        <button class="btn btn-sm" @click="addProduct(ticketProduct[0])">
                            <span class="material-symbols-outlined">
                                add
                            </span>
                        </button>
                    </span>
                    <span class="">${{ ticketProduct[0].price * ticketProduct.length }}</span>
                </div>
            </div>
        </div>
    </div>
    <div class="divider"></div>
    <div class="flex justify-between font-bold">
        <span>Total</span>
        <span>${{ ticket.total }}</span>
    </div>
    <div class="divider"></div>
    <section class="grid grid-cols-2 gap-2">
        <button class="btn btn-accent">
            Ticket
        </button>
        <button class="btn btn-error" :class="{ 'btn-disabled': ticketProducts.length != 0 }"
            :disabled="ticketProducts.length != 0" @click="cancelTicket()">
            Cancelar
        </button>
        <button onclick="pay_modal.showModal()" class="btn btn-primary" :disabled="ticketProducts.length == 0">
            Cobrar
        </button>
        <button @click="orderProducts" class="btn btn-primary" :disabled="ticketProducts.length == 0">
            Ordenar
        </button>
    </section>
</template>
