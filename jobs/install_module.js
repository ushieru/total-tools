
const { spawnSync } = require("bun")
const { resolveBinary } = require("dbmate")

export default async (payload, helpers) => {
    const { name } = payload
    const args = [
        '--url', `${process.env.DATABASE}?sslmode=disable`,
        '--migrations-dir', `./modules/${name}/db/migrations`,
        '--migrations-table', `${name}_schema_migrations`,
        '--no-dump-schema',
        "up",
    ]
    const { stdout, success, stderr } = spawnSync([resolveBinary(), ...args])
    helpers.logger.info(stdout.toString())
    if (!success) return helpers.logger.error(stderr.toString())
    const updateModuleQuery = `UPDATE "total_tools_core"."module" ccm SET "is_installed" = true WHERE ccm.key_name = '${name}'`
    helpers.withPgClient((pgClient) => pgClient.query(updateModuleQuery))
}
