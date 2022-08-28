import thalesData from 'thales-data';

import { SPORTS_TAGS_MAP } from '@constants/tags';
import type { SportMarketInfo } from '@types/markets';

/** @type {import('./$types').PageLoad} */
export async function load() {
	const markets: SportMarketInfo[] = thalesData.sportMarkets
		.markets({
			network: 10,
			isOpen: true
		})
		.then((markets: SportMarketInfo[]) => {
			return markets
				.filter((market) =>
					SPORTS_TAGS_MAP.Football.some((tag) => market.tags.includes(tag.toString()))
				)
				.map((market) => {
					market.homeBetAmount = 0;
					market.awayBetAmount = 0;
					return market;
				});
		});

	console.log(await markets);
	return {
		markets
	};
}
