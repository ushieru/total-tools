-- migrate:up
CREATE TABLE "total_tools_project"."task"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(1000) NOT NULL,
    "project_step_id" VARCHAR(12) 
        CONSTRAINT fk_project_step
        REFERENCES "total_tools_project"."project_step"("id"),
    "user_id" VARCHAR(12) 
        CONSTRAINT fk_user
        REFERENCES "total_tools_core"."user"("id"),
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_user_project_step
        CHECK ((user_id IS NULL AND project_step_id IS NOT NULL) 
            OR (project_step_id IS NULL AND user_id IS NOT NULL))
);

GRANT ALL ON "total_tools_project"."task" TO total_tools_project;

-- migrate:down
DROP TABLE "total_tools_project"."task";
