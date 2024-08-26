/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./frontend/**/*.vue",
        "./modules/**/*.html",
        "./modules/**/*.vue",
    ],
    theme: {
        extend: {},
    },
    plugins: [
        require('daisyui')
    ],
}

