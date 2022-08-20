import { ALCHEMY_API_KEY } from '$env/static/private';

import type { LayoutServerLoad } from './$types';

export async function load({ params }): LayoutServerLoad {
	return {
		ALCHEMY_API_KEY
	};
}
