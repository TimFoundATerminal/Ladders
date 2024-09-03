import type { PageServerLoad } from "./$types.js";
import { superValidate } from "sveltekit-superforms";
import { playerSchema } from "./schema";
import { zod } from "sveltekit-superforms/adapters";
import { getOrCreateUserProfile } from "$lib/auth";
 
export const load: PageServerLoad = async ({locals}) => {
    const playerProfile = await getOrCreateUserProfile(locals);

    return {
        form: await superValidate(zod(playerSchema)),
        playerProfile,
    };
};