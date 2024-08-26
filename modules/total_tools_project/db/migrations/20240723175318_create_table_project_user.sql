-- migrate:up
CREATE TABLE "total_tools_project"."project_user"(
    "project_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_project
        REFERENCES "total_tools_project"."project"("id"),
    "user_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_user
        REFERENCES "total_tools_core"."user"("id"),
    PRIMARY KEY("project_id", "user_id")
);

GRANT ALL ON "total_tools_project"."project_user" TO total_tools_project;

-- migrate:down
DROP TABLE "total_tools_project"."project_user";
