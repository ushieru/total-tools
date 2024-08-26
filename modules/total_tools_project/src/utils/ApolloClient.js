import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core'

const httpLink = createHttpLink({
  uri: import.meta.env.VITE_GRAPHQL_URL,
  fetch: (uri, options) => {
    const token = localStorage.getItem(import.meta.env.VITE_JWT_LOCAL_STORAGE_KEY);
    if (token) {
      options.headers = {
        ...options.headers,
        'Authorization': `Bearer ${token}`
      }
    }
    return fetch(uri, options)
  },
})

const cache = new InMemoryCache()

export const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
})