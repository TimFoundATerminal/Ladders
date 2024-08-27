import type { PageServerLoad, Actions } from './$types';

export const load: PageServerLoad = async ({ cookies }) => {
    // const user = await db.getUserFromSession(cookies.get('sessionid'));
    // return { user };
};

export const actions = {
    login: async ({ cookies, request }) => {
        // TODO: sign the user up
        const data = await request.formData();
        const email = data.get('email');
        const password = data.get('password');

        console.log('email:', email);
        console.log('password:', password);
    },
} satisfies Actions;