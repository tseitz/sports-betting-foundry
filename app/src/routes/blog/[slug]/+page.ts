import { error } from '@sveltejs/kit';

import type { PageLoad } from './$types';

// static page so turning off hydration
export const hydrate = false;

export function load({ params }): PageLoad {
	console.log(params);
	if (params.slug === 'hello-world') {
		return {
			title: 'Hello World',
			content: '<p>Hello World!</p>'
		};
	}

	throw error(404, 'Not found');
}
