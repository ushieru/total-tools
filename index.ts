import express from 'express'
import cors from 'cors'
import { PostGraphileMiddleware } from './server/PostGraphileMiddleware'
import { listen, config } from "vite-express";
import { TotalTools } from './server/TotalTools';
import { GraphileWorker } from './server/GraphileWorker';

const PORT = process.env.PORT || '3000'
export const app = express()

app.use(cors())

app.use(PostGraphileMiddleware())

GraphileWorker

if (process.env.NODE_ENV == 'production')
    config({ mode: 'production' })

listen(
    app,
    +PORT,
    () =>
        console.log(
            TotalTools,
            `\n[Total Tools] Server listening on http://127.0.0.1:${PORT}`,
            `\n[Total Tools] Server GraphiQL on http://127.0.0.1:${PORT}/graphiql`,
        )
) 
