<script lang="ts">
	import thalesData from 'thales-data';
	import { SPORTS_TAGS_MAP } from '@constants/tags';
	import type { SportMarketInfo } from '@types/markets';

	const data = new Array(3);

	const markets = thalesData.sportMarkets
		.markets({
			network: 10,
			isOpen: true
		})
		.then((markets: SportMarketInfo[]) => {
			return markets.filter((market) =>
				SPORTS_TAGS_MAP.Football.some((tag) => market.tags.includes(tag.toString()))
			);
		});
	console.log(markets);
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Bet Me" />
</svelte:head>

{#await markets then markets}
	{#each markets as market}
		<div class="card glass w-full shadow-xl my-10">
			<div class="grid grid-cols-3 gap-2 p-8">
				<div class="flex content-center">
					<h2 class="card-title">{market.homeTeam} vs. {market.awayTeam}</h2>
					<p>{new Date(market.timestamp)}</p>
				</div>
				<div class="flex justify-center">
					<div class="card card-compact w-auto bg-base-100 shadow-xl">
						<figure>
							<img
								src="https://overtimemarkets.xyz/logos/NFL/{market.homeTeam
									.toLowerCase()
									.replaceAll(' ', '-')}.svg"
								class="h-48 w-auto"
								alt={market.homeTeam}
							/>
						</figure>
						<div class="card-body">
							<h2 class="card-title justify-center">{market.homeTeam}</h2>
							<div class="card-actions justify-center">
								<button class="btn btn-accent">Bet</button>
							</div>
						</div>
					</div>
				</div>
				<div class="flex justify-center">
					<div class="card card-compact w-auto bg-base-100 shadow-xl">
						<figure>
							<img
								src="https://overtimemarkets.xyz/logos/NFL/{market.awayTeam
									.toLowerCase()
									.replaceAll(' ', '-')}.svg"
								class="h-48 w-auto"
								alt={market.awayTeam}
							/>
						</figure>
						<div class="card-body">
							<h2 class="card-title justify-center">{market.awayTeam}</h2>
							<div class="card-actions justify-center">
								<button class="btn btn-accent">Bet</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	{/each}
{/await}
