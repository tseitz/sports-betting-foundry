<script lang="ts">
	import { connected, defaultEvmStores, provider } from 'svelte-ethers-store';
	import ConnectButton from './ConnectButton.svelte';

	export let pending: boolean;
	export let connect: () => void;

	$: network = $connected ? $provider.getNetwork() : '';

	const disconnect = async () => {
		await defaultEvmStores.disconnect();
		pending = false;
	};
</script>

<div class="navbar bg-base-100">
	<div class="flex-1 gap-2">
		<a class="btn btn-ghost normal-case text-xl" href="/">Bet Me</a>
		{#await network then value}
			<span>powered by {value.name === 'unknown' ? 'localhost' : value.name}</span>
		{/await}
	</div>
	<div class="flex-none gap-2">
		<div class="flex-none">
			{#if pending}
				<ConnectButton text="Connecting..." />
			{:else if $connected}
				<ConnectButton text="Disconnect" action={disconnect} btnStyle="pr-1">
					<span class="avatar">
						<div class="w-10 rounded-full">
							<img src="https://placeimg.com/80/80/people" alt="profile" />
						</div>
					</span>
				</ConnectButton>
			{:else}
				<ConnectButton text="Connect" action={connect} />
			{/if}
		</div>
	</div>
</div>
