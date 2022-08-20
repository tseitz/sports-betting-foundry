<script lang="ts">
	import { onMount } from 'svelte';
	import type { LayoutData } from './$types';
	// import * as dotenv from 'dotenv';
	// dotenv.config();

	import { defaultEvmStores } from 'svelte-ethers-store';
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
			console.log('window.ethereum found');
			await connect();
		}
	});

	const connect = async () => {
		pending = true;
		try {
			await defaultEvmStores.setProvider(
				`https://eth-goerli.alchemyapi.io/v2/${data.ALCHEMY_API_KEY}`
				// `https://eth-goerli.alchemyapi.io/v2/XmoZTJyP4EfE-gxpxbASz4hlIp0zxqTM`
			);

			// console.log('$connected', defaultEvmStores.$connected);
			// console.log('$provider', defaultEvmStores.$provider);
			// console.log('$signer', defaultEvmStores.$signer);
			console.log('pending false');
			pending = false;
		} catch (e) {
			console.log(e);
			pending = false;
		}
	};
</script>

<Header {pending} {connect} />

<main>
	<slot />
</main>

<footer>
	<p>visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to learn SvelteKit</p>
</footer>

<style>
	main {
		flex: 1;
		display: flex;
		flex-direction: column;
		padding: 1rem;
		width: 100%;
		max-width: 1024px;
		margin: 0 auto;
		box-sizing: border-box;
	}

	footer {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 40px;
	}

	footer a {
		font-weight: bold;
	}

	@media (min-width: 480px) {
		footer {
			padding: 40px 0;
		}
	}
</style>
