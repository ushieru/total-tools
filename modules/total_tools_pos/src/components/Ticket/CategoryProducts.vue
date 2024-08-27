<script setup>
import { useQuery, useMutation } from '@vue/apollo-composable';
import { GetAvailableProducts } from '@pos/gql/queries.gql'
import { AddTicketProduct } from '@pos/gql/mutations.gql'

const props = defineProps(['categoryId', 'ticket', 'ticketRefetch'])

const { result: availableProducts } = useQuery(GetAvailableProducts, props)
const { mutate } = useMutation(AddTicketProduct)

const addProduct = (product) => {
    const payload = {
        productId: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        ticketId: props.ticket.id
    }
    mutate(payload)
        .then(_ => props.ticketRefetch())
}
</script>

<template>
    <div v-for="product in availableProducts?.availableProductsByCategoryId?.nodes" class="indicator w-full">
        <!-- <span v-if="ticket" v-show="ticket.ticket_products.find(p => p.product_id == product.id)"
            class="indicator-item badge badge-primary">{{
                ticket
                    .ticket_products
                    .filter(p => p.product_id == product.id)
                    .reduce(acc => ++acc, 0)
            }} </span> -->
        <button class="btn btn-neutral flex flex-col w-full h-40" @posclick="addProduct(product)">
            <span> {{ product.name }}</span>
            <kbd class="kbd">${{ product.price }}</kbd>
        </button>
    </div>
</template>
