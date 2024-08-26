-- migrate:up
CREATE TABLE "total_tools_project"."project_step"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "order" INTEGER NOT NULL UNIQUE,
    "project_id" VARCHAR(255) NOT NULL
        CONSTRAINT fk_project
        REFERENCES "total_tools_project"."project"("id")
);

GRANT ALL ON "total_tools_project"."project_step" TO total_tools_project;

-- migrate:down
DROP TABLE "total_tools_project"."project_step";
