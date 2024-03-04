import type { Config } from 'drizzle-kit';
import { config } from 'dotenv';

config({ path: '.dev.vars' });

export default {
	schema: './src/db/schema.ts',
	out: './drizzle',
	driver: 'pg',
	dbCredentials: {
		connectionString: process.env.DATABASE_URL!,
	},
} satisfies Config;
