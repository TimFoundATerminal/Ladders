import { db } from "$lib/db";
import { playersTable } from "$lib/db/schema";
import { error } from "@sveltejs/kit";
import { eq } from "drizzle-orm";
// type newPlayer = typeof playersTable.$inferInsert;

export const getOrCreateUserProfile = async ( locals: App.Locals ) => {
    const { user } = await locals.safeGetSession()

    if (!user) {
        return null;
    }

    const curProfile = await db.query.playersTable.findFirst({
        where: eq(playersTable.id, user.id)
    });

    if (curProfile) {
        return curProfile;
    }

    await db.insert(playersTable).values({
        id: user.id,
        email: user.email ?? "",
        firstname: "",
        lastname: "",
        gender: "Male",
        dob: new Date(2002, 1, 17),
    })

    const newProfile = await db.query.playersTable.findFirst({
        where: eq(playersTable.id, user.id)
    });

    if (!newProfile) {
        error(500, "Failed to create user profile");
    }

    return newProfile;
}