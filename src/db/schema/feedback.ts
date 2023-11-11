import { sql } from "drizzle-orm";
import { integer, sqliteTable, text } from "drizzle-orm/sqlite-core";
import { createInsertSchema } from "drizzle-zod";

export const feedback = sqliteTable("feedback", {
  id: integer("id", { mode: "number" }).primaryKey({ autoIncrement: true }),
  email: text("email").notNull(),
  message: text("message").notNull(),
  createdAt: text("timestamp").default(sql`CURRENT_TIMESTAMP`),
});

export const insertFeedback = createInsertSchema(feedback).pick({
  email: true,
  message: true,
});
