import { spawnSync } from "bun"
import { readdirSync } from "node:fs";
import { resolveBinary } from "dbmate"
import postgraphile from "postgraphile"
import { GraphileWorker } from "./GraphileWorker";

const args = [
    '--url', `${process.env.DATABASE}?sslmode=disable`,
    '--migrations-table', 'total_tools_core_schema_migrations',
    '--no-dump-schema',
    "up",
]

const options = {
    watchPg: true,
    graphiql: true,
    enhanceGraphiql: true,
    jwtPgTypeIdentifier: "public.jwt_token",
    jwtSecret: process.env.JWT_SECRET,
    pgDefaultRole: "anonymous",
    appendPlugins: [
        require("@graphile-contrib/pg-simplify-inflector"),
        require("@graphile-contrib/pg-many-to-many"),
        require("postgraphile-plugin-connection-filter")
    ]
}

const getModules = () => {
    const modules = readdirSync('modules');
    GraphileWorker.then((runner) =>
        modules
            .filter(m => m.startsWith("total_tools"))
            .map(m => runner.addJob('register_module', { name: m }))
    )
    return modules.map(module => `${module}`)
}

export const PostGraphileMiddleware = () => {
    const { stdout } = spawnSync({
        cmd: [resolveBinary(), ...args]
    })
    console.log(stdout.toString())
    return postgraphile(
        process.env.DATABASE,
        ["public", "total_tools_core", ...getModules()],
        options
    )
}
