<script lang="ts">
	import type { PageData } from './$types';
	import { contracts } from 'svelte-ethers-store';

	export let data: PageData;
	const now = new Date().getTime();
	let betAmount = {};

	const getTimeUntil = (timestamp: number) => {
		const delta = timestamp - now;
		const seconds = Math.floor((delta / 1000) % 60);
		const minutes = Math.floor((delta / 1000 / 60) % 60);
		const hours = Math.floor((delta / (1000 * 60 * 60)) % 24);
		const days = Math.floor(delta / (1000 * 60 * 60 * 24));
		return {
			days,
			hours,
			minutes,
			seconds
		};
	};

	const bettingAvailable = (timestamp: number) => {
		return timestamp > now;
	};

	$: betting = $contracts.betting;

	$: console.log(betAmount);
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Bet Me" />
</svelte:head>

{#await data.markets then markets}
	{#each markets as market}
		<div class="card glass w-full shadow-xl my-10">
			<div class="grid grid-cols-8 gap-2 p-8">
				<div class="flex flex-col col-span-3">
					<h1 class="card-title text-3xl">{market.homeTeam} vs. {market.awayTeam}</h1>
					<div class="grid grid-flow-col gap-5 text-center auto-cols-max my-4">
						{#if bettingAvailable(market.maturityDate)}
							<div class="flex flex-col">
								<span class="countdown font-mono text-5xl">
									<!-- jsx is nice for this, only need to call once to get all these. Need to figure this out in svelte -->
									<span style="--value:{getTimeUntil(market.maturityDate)['days']};" />
								</span>
								days
							</div>
							<div class="flex flex-col">
								<span class="countdown font-mono text-5xl">
									<span style="--value:{getTimeUntil(market.maturityDate)['hours']};" />
								</span>
								hours
							</div>
							<div class="flex flex-col">
								<span class="countdown font-mono text-5xl">
									<span style="--value:{getTimeUntil(market.maturityDate)['minutes']};" />
								</span>
								min
							</div>
							<div class="flex flex-col">
								<span class="countdown font-mono text-5xl">
									<span style="--value:{getTimeUntil(market.maturityDate)['seconds']};" />
								</span>
								sec
							</div>
						{:else}
							<div>
								<h1 class="text-3xl text-red-400">Betting has closed</h1>
							</div>
						{/if}
					</div>
					<ul>
						<li class="my-2 text-lg"><strong>Tegan:</strong> {market.homeTeam} for $10</li>
						<li class="my-2 text-lg"><strong>Jayden:</strong> {market.awayTeam} for $10</li>
						<li class="my-2 text-lg"><strong>Warren:</strong> {market.homeTeam} for $10</li>
					</ul>
				</div>
				<div class="flex justify-center col-span-2">
					<div class="card card-compact w-auto bg-base-100 shadow-xl">
						<figure>
							<img
								src="https://overtimemarkets.xyz/logos/NFL/{market.awayTeam
									.toLowerCase()
									.replaceAll(' ', '-')}.svg"
								class="h-64 w-64"
								alt={market.awayTeam}
							/>
						</figure>
						<div class="card-body">
							<h1 class="card-title justify-center">{market.awayTeam}</h1>
							{#if !bettingAvailable(market.maturityDate)}
								<h3 class="text-3xl text-center">{market.awayScore}</h3>
							{/if}
							<div class="card-actions justify-center">
								{#if bettingAvailable(market.maturityDate)}
									<input
										type="text"
										placeholder="How much?"
										class="input input-bordered input-success w-full max-w-xs text-center"
										bind:value={market.awayBetAmount}
									/>
								{/if}
								<button
									class="btn btn-accent btn-block"
									disabled={!bettingAvailable(market.maturityDate)}
									on:click={() => betting.bet(market.address, market.awayBetAmount)}
								>
									Pick</button
								>
							</div>
						</div>
					</div>
				</div>
				<div class="flex flex-col justify-center items-center text-2xl">@</div>
				<div class="flex justify-center col-span-2">
					<div class="card card-compact w-auto bg-base-100 shadow-xl">
						<figure>
							<img
								src="https://overtimemarkets.xyz/logos/NFL/{market.homeTeam
									.toLowerCase()
									.replaceAll(' ', '-')}.svg"
								class="h-64 w-64"
								alt={market.homeTeam}
							/>
						</figure>
						<div class="card-body">
							<h1 class="card-title justify-center">{market.homeTeam}</h1>
							{#if !bettingAvailable(market.maturityDate)}
								<h3 class="text-3xl text-center">{market.homeScore}</h3>
							{/if}
							<div class="card-actions justify-center">
								{#if bettingAvailable(market.maturityDate)}
									<input
										type="text"
										placeholder="How much?"
										class="input input-bordered input-success w-full max-w-xs text-center"
										bind:value={market.homeBetAmount}
									/>
								{/if}
								<button
									class="btn btn-accent btn-block"
									disabled={!bettingAvailable(market.maturityDate)}
									on:click={() => betting.bet(market.address, market.homeBetAmount)}>Pick</button
								>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	{/each}
{/await}
