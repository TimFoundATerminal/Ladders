import { db } from '$lib/db';
import type { PageServerLoad } from './$types';

// This function is called on the server when the page is first loaded
export const load: PageServerLoad = async () => {
    return {
        players: await db.query.playersTable.findMany(),
    };
};