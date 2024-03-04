import { pgTable, serial, text, pgEnum, varchar, integer, smallint, date, timestamp } from 'drizzle-orm/pg-core';

export const roleEnum = pgEnum('role', ['student', 'admin']);

export const users = pgTable('users', {
	id: serial('user_id').primaryKey(),
	name: varchar('name', { length: 255 }),
	email: varchar('email', { length: 255 }).unique().notNull(),
	password: text('password').notNull(),
	role: roleEnum('role').default('student'),
	createdAt: timestamp('created_at').defaultNow(),
});

export const invitations = pgTable('invitations', {
	id: serial('invitation_id').primaryKey(),
	name: varchar('invitee_name', { length: 255 }),
	email: varchar('email', { length: 255 }).unique().notNull(),
	token: text('token').notNull(),
	bonus: smallint('bonus').notNull().default(4),
	invitee: integer('invitee_id').references(() => users.id),
	creationDate: timestamp('creation_date').defaultNow(),
	expirationDate: timestamp('expiration_date'),
});

export const AcceptedInvitations = pgTable('acceptedInvitations', {
	id: serial('acceptedInvitation_id').primaryKey(),
	inviterId: integer('inviter_id').references(() => users.id),
	inviteeId: integer('invitee_id').references(() => users.id),
	invitationId: integer('invitation_id').references(() => invitations.id),
	acceptanceDate: timestamp('acceptance_date').defaultNow(),
});

export const reviews = pgTable('reviews', {
	id: serial('review_id').primaryKey(),
	rating: smallint('rating').notNull(),
	title: text('title'),
	content: text('content'),
	userId: integer('user_id').references(() => users.id),
	createdAt: timestamp('created_at').defaultNow(),
});
