<script setup>
import { GetModules } from '@/gql/queries.gql'
import { InstallModule } from '@/gql/mutations.gql'
import { useMutation, useQuery } from '@vue/apollo-composable';

const { result: getModulesResult } = useQuery(GetModules, {}, { pollInterval: 2000 })
const { mutate } = useMutation(InstallModule)

const installModule = (module) =>
    mutate({ keyName: module.keyName })
</script>

<template>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div class="card-body">
                <div class="overflow-x-auto">
                    <table class="table">
                        <thead>
                            <tr class="border-neutral border-b-2">
                                <th>Nombre</th>
                                <th>Icono</th>
                                <th></th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-neutral" v-for="module in getModulesResult?.modules?.nodes">
                                <td class="capitalize">{{ module.name }}</td>
                                <td>
                                    <div class="w-20" v-html="module.icon"></div>
                                </td>
                                <td>
                                    <button @click="installModule(module)" v-show="!module.isInstalled"
                                        class="btn btn-primary">Instalar</button>
                                    <a v-show="module.isInstalled" :href="`/modules/${module.keyName}/`">
                                        <button class="btn btn-primary">Ir</button>
                                    </a>
                                </td>
                                <td class="flex gap-2">
                                    <RouterLink v-show="module.isInstalled"
                                        :to="`/admin/modules/${module.keyName}/accounts`"
                                        class="btn btn-sm btn-primary">
                                        <span class="material-symbols-outlined">
                                            group_add
                                        </span>
                                    </RouterLink>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>
