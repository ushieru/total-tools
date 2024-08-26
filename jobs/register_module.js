/** 
 * @param payload {any}
 * @param helpers {import('graphile-worker').Helpers}
 */
export default async (payload, helpers) => {
    const { name } = payload
    const registerModuleQuery = `INSERT INTO "total_tools_core"."module"(key_name, name, icon, is_installed)
    VALUES('${name}', '${name}', '', false)`
    helpers.withPgClient((pgClient) => pgClient.query(registerModuleQuery)
        .catch(err => helpers.logger.error(`[Register Module('${name}')] ${err}`))
    )
}
