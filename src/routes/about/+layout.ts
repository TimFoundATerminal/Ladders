import type { LayoutLoad } from './$types';

export const load: LayoutLoad = () => {
	return {
		sections: [
			{ title: 'Mission', content: 'To create a easy to use and login ladder to manage teams within clubs' },
			{ title: 'Developers', content: 'This application was developed and maintained by TimTom' },
		],
	};
};