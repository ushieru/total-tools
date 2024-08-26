<script setup>
import favicon from '../assets/favicon.svg' 
</script>

<template>
    <div class="drawer lg:drawer-open">
        <input id="my-drawer" type="checkbox" class="drawer-toggle" />
        <div class="drawer-content">
            <div class="flex navbar bg-base-100 border-b-[1px]">
                <div class="flex-none">
                </div>
                <div class="flex-1 gap-2">
                    <img :src="favicon" alt="favicon" class="h-6 w-6" />
                    <a href="/" class="text-xl">Proyetos</a>
                </div>
            </div>
            <div class="p-1 sm:p-5">
                <RouterView></RouterView>
            </div>
        </div>
    </div>
</template>
