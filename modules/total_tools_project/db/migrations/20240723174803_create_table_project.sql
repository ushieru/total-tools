-- migrate:up
CREATE TABLE "total_tools_project"."project"(
    "id" VARCHAR(12) PRIMARY KEY DEFAULT nanoid(12),
    "name" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL DEFAULT NOW()
);

GRANT ALL ON "total_tools_project"."project" TO total_tools_project;

COMMENT ON TABLE "total_tools_project"."project" IS
  E'@omit';

-- migrate:down
DROP TABLE "total_tools_project"."project";
