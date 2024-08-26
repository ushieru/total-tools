import { run } from "graphile-worker"

export const GraphileWorker = run({
    connectionString: process.env.DATABASE,
    concurrency: 2,
    noHandleSignals: false,
    pollInterval: 2000,
    taskDirectory: 'jobs',
})
