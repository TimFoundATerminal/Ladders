CREATE TABLE IF NOT EXISTS "challenges" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ladder_id" uuid NOT NULL,
	"player1_id" uuid NOT NULL,
	"player2_id" uuid NOT NULL,
	"status" text NOT NULL,
	"match_id" uuid,
	"challenged_at" timestamp DEFAULT now(),
	"expires_at" timestamp NOT NULL,
	"active_flag" boolean DEFAULT true
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "games" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"match_id" uuid NOT NULL,
	"game_number" integer NOT NULL,
	"player1_score" integer NOT NULL,
	"player2_score" integer NOT NULL,
	"comments" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "ladder_positions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ladder_id" uuid NOT NULL,
	"player_id" uuid NOT NULL,
	"position" integer NOT NULL,
	"effective_from" timestamp NOT NULL,
	"effective_to" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"active_flag" boolean DEFAULT true
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "ladders" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"organisation_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"active_flag" boolean DEFAULT true,
	CONSTRAINT "ladders_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "matches" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ladder_id" uuid NOT NULL,
	"player1_id" uuid NOT NULL,
	"player2_id" uuid NOT NULL,
	"player1_games" integer NOT NULL,
	"player2_games" integer NOT NULL,
	"match_date" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"comments" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "organisations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"active_flag" boolean DEFAULT true,
	CONSTRAINT "organisations_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "players" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" text NOT NULL,
	"firstname" text NOT NULL,
	"lastname" text NOT NULL,
	"gender" text NOT NULL,
	"england_squash_id" text,
	"squash_levels_id" text,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "players_email_unique" UNIQUE("email"),
	CONSTRAINT "players_england_squash_id_unique" UNIQUE("england_squash_id"),
	CONSTRAINT "players_squash_levels_id_unique" UNIQUE("squash_levels_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "challenges" ADD CONSTRAINT "challenges_ladder_id_ladders_id_fk" FOREIGN KEY ("ladder_id") REFERENCES "public"."ladders"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "challenges" ADD CONSTRAINT "challenges_player1_id_players_id_fk" FOREIGN KEY ("player1_id") REFERENCES "public"."players"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "challenges" ADD CONSTRAINT "challenges_player2_id_players_id_fk" FOREIGN KEY ("player2_id") REFERENCES "public"."players"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "challenges" ADD CONSTRAINT "challenges_match_id_matches_id_fk" FOREIGN KEY ("match_id") REFERENCES "public"."matches"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "games" ADD CONSTRAINT "games_match_id_matches_id_fk" FOREIGN KEY ("match_id") REFERENCES "public"."matches"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "ladder_positions" ADD CONSTRAINT "ladder_positions_ladder_id_ladders_id_fk" FOREIGN KEY ("ladder_id") REFERENCES "public"."ladders"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "ladder_positions" ADD CONSTRAINT "ladder_positions_player_id_players_id_fk" FOREIGN KEY ("player_id") REFERENCES "public"."players"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "ladders" ADD CONSTRAINT "ladders_organisation_id_organisations_id_fk" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "matches" ADD CONSTRAINT "matches_ladder_id_ladders_id_fk" FOREIGN KEY ("ladder_id") REFERENCES "public"."ladders"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "matches" ADD CONSTRAINT "matches_player1_id_players_id_fk" FOREIGN KEY ("player1_id") REFERENCES "public"."players"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "matches" ADD CONSTRAINT "matches_player2_id_players_id_fk" FOREIGN KEY ("player2_id") REFERENCES "public"."players"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

ALTER TABLE "challenges" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "players" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ladders" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "matches" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "games" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ladder_positions" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "organisations" ENABLE ROW LEVEL SECURITY;

