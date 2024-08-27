<script setup>
import { useRoute } from 'vue-router'
import { useQuery, useMutation } from '@vue/apollo-composable';
import { GetProductCategoriesByProductId, GetCategoriesNotInProduct } from '@pos/gql/queries.gql'
import { CreateCategoryProduct, DeleteCategoryProduct } from '@pos/gql/mutations.gql'

const route = useRoute()
const { id: productId } = route.params

const { result: productWithCategories, loading: productWithCategoriesIsLoading, refetch: productWithCategoriesRefetch } = useQuery(GetProductCategoriesByProductId, { id: productId })
const { result: categoriesNotInProduct, loading: categoriesNotInProductIsLoading, refetch: categoriesNotInProductRefetch } = useQuery(GetCategoriesNotInProduct, { id: productId })

const { mutate: createCategoryProduct } = useMutation(CreateCategoryProduct)
const { mutate: deleteCategoryProduct } = useMutation(DeleteCategoryProduct)

const refetchAll = () => {
    productWithCategoriesRefetch()
    categoriesNotInProductRefetch()
}

</script>

<template>
    <div class="flex flex-col gap-5">
        <div class="card bg-base-200 shadow-xl">
            <div v-if="productWithCategoriesIsLoading" class="card-body grid place-items-center">
                <span class="loading loading-dots loading-lg"></span>
            </div>
            <div v-else class="card-body gap-0">
                <h1 class="text-xl font-bold">
                    {{ productWithCategories.product.name }}
                </h1>
                <span class="text-xs">{{ productWithCategories.product.id }}</span>
            </div>
        </div>
        <div class="flex gap-4">
            <div class="card bg-base-200 shadow-xl w-full">
                <div class="card-body">
                    <h1 class="text-xl">
                        Categorias
                    </h1>
                    <div class="divider m-0"></div>
                    <button v-if="!categoriesNotInProductIsLoading"
                        v-for="category in categoriesNotInProduct.categoriesNotInProduct.nodes"
                        @click="() => createCategoryProduct({ categoryId: category.id, productId: productId }).then(refetchAll)"
                        class="btn btn-primary">
                        {{ category.name }}
                    </button>
                </div>
            </div>
            <div class="card bg-base-200 shadow-xl w-full" v-if="!productWithCategoriesIsLoading">
                <div class="card-body">
                    <h1 class="text-xl">
                        Categorias de {{ productWithCategories.product.name }}
                    </h1>
                    <div class="divider m-0"></div>
                    <button v-for="category in productWithCategories.product.categoryProducts.nodes"
                        @click="() => deleteCategoryProduct({ categoryId: category.category.id, productId: productId }).then(refetchAll)"
                        class="btn btn-secondary">
                        {{ category.category.name }}
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
