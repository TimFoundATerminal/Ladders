DO $$ BEGIN
 CREATE TYPE "public"."playerRole" AS ENUM('PLAYER', 'MOD', 'DEV', 'ADMIN');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "players" ALTER COLUMN "id" DROP DEFAULT;--> statement-breakpoint
ALTER TABLE "players" ADD COLUMN "playerRole" "playerRole" DEFAULT 'PLAYER' NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "emailIndex" ON "players" USING btree ("email");