import type { RequestHandler } from '@sveltejs/kit';
import { json } from '@sveltejs/kit';

export const GET: RequestHandler = async ({ locals }) => {
	// locals.userid comes from src/hooks.js
	console.log(locals.userid);

	return json({
		headers: {
			'access-control-allow-origin': '*'
		}
	});
};
