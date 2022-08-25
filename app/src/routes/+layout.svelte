<script lang="ts">
	import { onMount } from 'svelte';
	import type { LayoutData } from './$types';

	import { defaultEvmStores, provider, signer, connected, contracts } from 'svelte-ethers-store';
	// import Web3Modal from 'web3modal';

	import Header from '$lib/header/Header.svelte';
	import '../app.css';

	export let data: LayoutData;

	let pending = true;
	// let web3Modal: Web3Modal;

	onMount(async () => {
		// web3Modal = new Web3Modal({
		// 	network: 'goerli', // optional
		// 	cacheProvider: true, // optional
		// 	providerOptions: {} // required
		// });

		if (window.ethereum) {
			console.log('window.ethereum found. connecting...', window.ethereum);
			await connect();
		}
	});

	const connect = async () => {
		pending = true;
		try {
			// await defaultEvmStores.setProvider(
			// 	`https://eth-goerli.alchemyapi.io/v2/${data.ALCHEMY_API_KEY}`
			// );
			// await defaultEvmStores.setProvider(window.ethereum);
			await defaultEvmStores.setProvider('http://localhost:8545');
			// console.log($chainId);

			const { name, chainId } = await $provider.getNetwork();
			console.log('$chainId', chainId);
			console.log('$name', name);

			const balance = await $signer.getBalance();
			console.log('balance', balance.toBigInt());

			defaultEvmStores.attachContract(
				'storage',
				'0x922d6956c99e12dfeb3224dea977d0939758a1fe',
				'[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Retrieved","type":"event"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"retrieve","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"num","type":"uint256"}],"name":"store","outputs":[],"stateMutability":"nonpayable","type":"function"}]'
			);

			pending = false;
		} catch (e) {
			console.log(e);
			pending = false;
		}
	};

	// $: stroage = $connected ? $contracts.storage : '';

	const store = async () => {
		const transaction = await $contracts.storage.store(5000000000000);
		console.log(transaction);
		await transaction.wait();
		const newValue = await $contracts.storage.retrieve();
		console.log(newValue.value.toString());
		// console.log($contracts.storage.retrieve().value.toString());
	};
</script>

<Header {pending} {connect} />

<main>
	{#if $connected}
		{#await $contracts.storage.retrieve()}
			<span>waiting...</span>
		{:then value}
			<h1>{console.log(value.value.toString())}</h1>
			<button class="btn" on:click={store}>Store Something</button>
		{/await}
	{/if}
	<slot />
</main>

<footer>
	<p>Let's learn Foundry and Sveltekit!</p>
</footer>

<style>
	footer {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 40px;
	}

	@media (min-width: 480px) {
		footer {
			padding: 40px 0;
		}
	}
</style>
