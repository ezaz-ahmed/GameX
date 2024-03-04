DO $$ BEGIN
 CREATE TYPE "role" AS ENUM('student', 'admin');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "acceptedInvitations" (
	"acceptedInvitation_id" serial PRIMARY KEY NOT NULL,
	"inviter_id" integer,
	"invitee_id" integer,
	"invitation_id" integer,
	"acceptance_date" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "invitations" (
	"invitation_id" serial PRIMARY KEY NOT NULL,
	"invitee_name" varchar(255),
	"email" varchar(255) NOT NULL,
	"token" text NOT NULL,
	"bonus" smallint DEFAULT 4 NOT NULL,
	"invitee_id" integer,
	"creation_date" timestamp DEFAULT now(),
	"expiration_date" timestamp,
	CONSTRAINT "invitations_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "reviews" (
	"review_id" serial PRIMARY KEY NOT NULL,
	"rating" smallint NOT NULL,
	"title" text,
	"content" text,
	"user_id" integer,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"user_id" serial PRIMARY KEY NOT NULL,
	"name" varchar(255),
	"email" varchar(255) NOT NULL,
	"password" text NOT NULL,
	"role" "role" DEFAULT 'student',
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "acceptedInvitations" ADD CONSTRAINT "acceptedInvitations_inviter_id_users_user_id_fk" FOREIGN KEY ("inviter_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "acceptedInvitations" ADD CONSTRAINT "acceptedInvitations_invitee_id_users_user_id_fk" FOREIGN KEY ("invitee_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "acceptedInvitations" ADD CONSTRAINT "acceptedInvitations_invitation_id_invitations_invitation_id_fk" FOREIGN KEY ("invitation_id") REFERENCES "invitations"("invitation_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "invitations" ADD CONSTRAINT "invitations_invitee_id_users_user_id_fk" FOREIGN KEY ("invitee_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "reviews" ADD CONSTRAINT "reviews_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
