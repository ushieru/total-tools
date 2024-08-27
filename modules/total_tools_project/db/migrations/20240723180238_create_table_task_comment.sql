-- migrate:up
CREATE TABLE "total_tools_project"."task_comment"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT public.nanoid(12),
    "comment" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(12) NOT NULL 
        CONSTRAINT fk_user
        REFERENCES "total_tools_core"."user"("id")
        ON DELETE CASCADE,
    "task_id" VARCHAR(12) NOT NULL
        CONSTRAINT fk_task
        REFERENCES "total_tools_project"."task"("id")
        ON DELETE CASCADE,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL DEFAULT NOW()
);

GRANT ALL ON "total_tools_project"."task_comment" TO total_tools_project;

-- migrate:down
DROP TABLE "total_tools_project"."task_comment";
