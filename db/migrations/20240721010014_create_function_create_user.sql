-- migrate:up
CREATE FUNCTION "total_tools_core"."create_user"(
    username TEXT,
    password TEXT,
    name TEXT,
    family_name TEXT,
    email TEXT,
    cellphone TEXT,
    is_admin BOOLEAN DEFAULT false
)
RETURNS "total_tools_core"."user" AS $$
DECLARE
    hash_password TEXT;
    created_account_id TEXT;
    created_user "total_tools_core"."user";
BEGIN
    EXECUTE 'CREATE ROLE ' || username;
    EXECUTE 'GRANT ' || username || ' TO authenticator';
    IF is_admin THEN
        EXECUTE 'GRANT total_tools_admin TO ' || username;
    ELSE
        EXECUTE 'GRANT total_tools_user TO ' || username;
    END IF;
    SELECT crypt(password, gen_salt('bf')) INTO hash_password;
    INSERT INTO "total_tools_core"."account"(username, password, is_admin)
        VALUES(username, hash_password, is_admin) RETURNING id INTO created_account_id;
    INSERT INTO "total_tools_core"."user"(name, family_name, email, cellphone, account_id)
        VALUES(name, family_name, email, cellphone, created_account_id) RETURNING * INTO created_user;
    RETURN created_user;
END;
$$ LANGUAGE PLPGSQL SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION "total_tools_core"."create_user"(TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, BOOLEAN) TO total_tools_admin;

-- migrate:down
DROP FUNCTION "total_tools_core"."create_user"(TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, BOOLEAN);
