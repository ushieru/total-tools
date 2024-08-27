<script setup>
import { useRouter } from 'vue-router'
import { useQuery, useMutation } from '@vue/apollo-composable';
import { WhoAmI } from '@pos/gql/queries.gql'
import { CreateTicket } from '@pos/gql/mutations.gql'
import { GetSession } from '@common/utils/GetSession';

const router = useRouter()
const session = GetSession()
const { onResult } = useQuery(WhoAmI, { accountId: session.sub })
const { mutate: createTicket } = useMutation(CreateTicket)

onResult(({ data }) => {
    if (!data) return
    const user = data.users.nodes[0]
    createTicket({ createdBy: user.id }).then((response) => {
        const ticketId = response.data.createTicket.ticket.id
        router.push(`/cashier/tickets/${ticketId}`)
    })
})
</script>

<template>
    <div class="h-full grid place-items-center">
        <div class="card bg-base-200 shadow">
            <div class="card-body grid place-items-center">
                <span class="loading loading-dots loading-lg"></span>
            </div>
        </div>
    </div>
</template>
