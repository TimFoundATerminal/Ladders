import { pgTable, serial, text, timestamp, uuid, boolean, integer, pgEnum, unique, uniqueIndex } from 'drizzle-orm/pg-core';

// roles
export const playerRole = pgEnum('playerRole', ['PLAYER', 'MOD', 'DEV', 'ADMIN']);

// table definitions

export const playersTable = pgTable('players', {
    id: uuid('id').primaryKey(),
    email: text('email').notNull().unique(),
    firstname: text('firstname').notNull(),
    lastname: text('lastname').notNull(),
    gender: text('gender').notNull(),
    dob: timestamp('dob').notNull(),
    england_squash_id: text('england_squash_id').unique(),
    squash_levels_id: text('squash_levels_id').unique(),
    role: playerRole('playerRole').notNull().default('PLAYER'),
    created_at: timestamp('created_at').defaultNow(),
}, table => {
    return {
        emailIndex: uniqueIndex("emailIndex").on(table.email)
    }
})

export const organisationsTable = pgTable('organisations', {
    id: uuid('id').primaryKey().defaultRandom(),
    name: text('name').notNull().unique(),
    created_at: timestamp('created_at').defaultNow(),
    active_flag: boolean('active_flag').default(true),
});

export const laddersTable = pgTable('ladders', {
    id: uuid('id').primaryKey().defaultRandom(),
    name: text('name').notNull().unique(),
    organisation_id: uuid('organisation_id').notNull().references(() => organisationsTable.id),
    created_at: timestamp('created_at').defaultNow(),
    active_flag: boolean('active_flag').default(true),
});

export const ladderPositionsTable = pgTable('ladder_positions', {
    id: uuid('id').primaryKey().defaultRandom(),
    ladder_id: uuid('ladder_id').notNull().references(() => laddersTable.id),
    player_id: uuid('player_id').notNull().references(() => playersTable.id),
    position: integer('position').notNull(),
    effective_from: timestamp('effective_from').notNull(),
    effective_to: timestamp('effective_to').notNull(),
    created_at: timestamp('created_at').defaultNow(),
    active_flag: boolean('active_flag').default(true),
});

export const matchesTable = pgTable('matches', {
    id: uuid('id').primaryKey().defaultRandom(),
    ladder_id: uuid('ladder_id').notNull().references(() => laddersTable.id),
    player1_id: uuid('player1_id').notNull().references(() => playersTable.id),
    player2_id: uuid('player2_id').notNull().references(() => playersTable.id),
    player1_games: integer('player1_games').notNull(),
    player2_games: integer('player2_games').notNull(),
    match_date: timestamp('match_date').notNull(),
    created_at: timestamp('created_at').defaultNow(),
    comments: text('comments'),
});

export const gamesTable = pgTable('games', {
    id: uuid('id').primaryKey().defaultRandom(),
    match_id: uuid('match_id').notNull().references(() => matchesTable.id),
    game_number: integer('game_number').notNull(),
    player1_score: integer('player1_score').notNull(),
    player2_score: integer('player2_score').notNull(),
    comments: text('comments'),
});

export const challengesTable = pgTable('challenges', {
    id: uuid('id').primaryKey().defaultRandom(),
    ladder_id: uuid('ladder_id').notNull().references(() => laddersTable.id),
    player1_id: uuid('player1_id').notNull().references(() => playersTable.id),
    player2_id: uuid('player2_id').notNull().references(() => playersTable.id),
    status: text('status').notNull(),
    match_id: uuid('match_id').references(() => matchesTable.id),
    challenged_at: timestamp('challenged_at').defaultNow(),
    expires_at: timestamp('expires_at').notNull(),
    active_flag: boolean('active_flag').default(true),
});
