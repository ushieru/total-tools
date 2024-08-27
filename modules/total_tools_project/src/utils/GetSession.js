export const GetSession = () => {
    const token = localStorage.getItem(import.meta.env.VITE_JWT_LOCAL_STORAGE_KEY)
    if (!token) return
    const [_headers, payload, _sign] = token.split('.')
    if (!payload) return
    const decriptPayload = atob(payload)
    return JSON.parse(decriptPayload)
}
