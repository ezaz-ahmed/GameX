import { Hono } from 'hono';
import { drizzle } from 'drizzle-orm/neon-http';
import { neon } from '@neondatabase/serverless';
import { users } from './db/schema';

export type Env = {
	DATABASE_URL: string;
};

const app = new Hono<{ Bindings: Env }>();

app.get('/', async (c) => {
	try {
		const sql = neon(c.env.DATABASE_URL);

		const db = drizzle(sql);

		const result = await db.select().from(users);

		return c.json({ result });
	} catch (error) {
		console.log(error);

		return c.json({ error }, 400);
	}
});

export default app;
