<script setup>
import { useQuery, useLazyQuery } from '@vue/apollo-composable';
import { WhoAmI, GetTickets } from '@pos/gql/queries.gql'
import { GetSession } from '@common/utils/GetSession';
import { computed } from 'vue';

const session = GetSession()
const { onResult } = useQuery(WhoAmI, { accountId: session.sub })
const { result: ticketsResult, load } = useLazyQuery(GetTickets)

const tickets = computed(() => ticketsResult.value?.tickets?.nodes ?? [])

onResult(({ data }) => {
    if (!data) return
    const user = data.users.nodes[0]
    load(null, { userId: user.id })
})
</script>

<template>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body grid grid-cols-5 gap-3">
                <RouterLink v-for="ticket in tickets" :to="`/cashier/tickets/${ticket.id}`" class="w-full">
                    <button class="btn w-full">
                        Ticket #{{ ticket.id }}
                    </button>
                </RouterLink>
            </div>
        </div>
    </div>
</template>
