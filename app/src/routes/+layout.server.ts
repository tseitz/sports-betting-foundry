import { ALCHEMY_API_KEY } from '$env/static/private';

/** @type {import('./$types').LayoutServerLoad} */
export async function load({ params }) {
	return {
		ALCHEMY_API_KEY
	};
}
