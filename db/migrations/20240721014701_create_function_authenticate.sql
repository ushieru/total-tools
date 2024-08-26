-- migrate:up
CREATE TYPE "public"."jwt_token" AS (
	sub TEXT,
	role TEXT,
	exp INT
);

CREATE FUNCTION "public"."authenticate"(
    username TEXT,
    password TEXT
)
RETURNS "public"."jwt_token" AS $$
DECLARE
    account_id TEXT;
    token TEXT;
    payload TEXT;
    jwt_secret TEXT;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles pr WHERE pr.rolname = $1) THEN
        RAISE invalid_password USING MESSAGE = 'invalid user or password';
        RETURN NULL;
    END IF;
    SELECT id INTO account_id FROM "total_tools_core"."account" cca
        WHERE cca.username = $1
        AND cca.password = crypt($2, cca.password);
    IF account_id IS NULL THEN
        RAISE invalid_password USING MESSAGE = 'invalid user or password';
        RETURN NULL;
    END IF;
    RETURN (
      account_id,
      $1,
      extract(epoch FROM now() + interval '1 days')
    )::jwt_token;
END;
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

-- migrate:down
DROP FUNCTION "public"."authenticate"(TEXT, TEXT);
