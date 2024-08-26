<script setup>
import { useRoute } from 'vue-router';
import { FilterAccountsNotInModule, FilterAccountsInModule } from '@/gql/queries.gql'
import { LinkUserModule, UnlinkUserModule } from '@/gql/mutations.gql'
import { useMutation, useQuery } from '@vue/apollo-composable';

const route = useRoute()
const { id: moduleId } = route.params
const { result: accountsInModule, refetch: refetchAccountsInModule } = useQuery(FilterAccountsInModule, { module: moduleId })
const { result: accounts, refetch: refetchAccounts } = useQuery(FilterAccountsNotInModule, { module: moduleId })
const { mutate: linkUserModule } = useMutation(LinkUserModule)
const { mutate: unlinkUserModule } = useMutation(UnlinkUserModule)

const addAccount = (username) =>
    linkUserModule({ username, module: moduleId })
        .then(_ => refetchAccounts() && refetchAccountsInModule())
const deleteAccount = (username) =>
    unlinkUserModule({ username, module: moduleId })
        .then(_ => refetchAccounts() && refetchAccountsInModule())
</script>

<template>
    <div class="text-sm breadcrumbs mb-5">
        <ul>
            <li>
                <RouterLink to="/admin/modules">Modules</RouterLink>
            </li>
            <li>{{ moduleId }}</li>
            <li>accounts</li>
        </ul>
    </div>
    <div class="card bg-base-200 shadow-xl">
        <div class="card-body">
            <h1 class="text-2xl">{{ moduleId }}</h1>
            <div class="divider my-0"></div>

            <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                    <h1 class="text-lg">Cuentas:</h1>
                    <div class="divider my-0"></div>
                    <div v-for="account in accounts?.filterAccountsNotInModule?.nodes">
                        <button @click="addAccount(account.username)" class="btn btn-primary">
                            {{ account.username }}
                            <span class="material-symbols-outlined">
                                person_add
                            </span>
                        </button>
                    </div>
                </div>
            </div>

            <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                    <h1 class="text-lg">Cuentas en el modulo:</h1>
                    <div class="divider my-0"></div>
                    <div v-for="account in accountsInModule?.accountModules?.nodes">
                        <button @click="deleteAccount(account.account.username)" class="btn btn-error">
                            {{ account.account.username }}
                            <span class="material-symbols-outlined">
                                person_remove
                            </span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
