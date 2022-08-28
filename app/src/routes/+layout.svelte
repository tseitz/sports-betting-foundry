<script lang="ts">
	import { onMount } from 'svelte';
	import type { LayoutData } from './$types';

	import { defaultEvmStores, provider, signer, contracts } from 'svelte-ethers-store';
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
			// await defaultEvmStores.setProvider('http://localhost:8545');
			await defaultEvmStores.setProvider();
			// console.log($chainId);

			const { name, chainId } = await $provider.getNetwork();
			console.log('$chainId', chainId);
			console.log('$name', name);

			const balance = await $signer.getBalance();
			console.log('balance', balance.toBigInt());

			defaultEvmStores.attachContract(
				'storage',
				'0x0b306bf915c4d645ff596e518faf3f9669b97016',
				'[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"Retrieved","type":"event"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"retrieve","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"num","type":"uint256"}],"name":"store","outputs":[],"stateMutability":"nonpayable","type":"function"}]'
			);

			pending = false;
		} catch (e) {
			console.log(e);
			pending = false;
		}
	};

	// $: stroage = $connected ? $contracts.storage : '';

	// const store = async () => {
	// 	const transaction = await $contracts.storage.store(5000000000000);
	// 	console.log(transaction);
	// 	await transaction.wait();
	// 	value = await $contracts.storage.retrieve();
	// 	console.log(value.toString());
	// 	// console.log($contracts.storage.retrieve().value.toString());
	// };

	// $: value = $contracts.storage && $contracts.storage.retrieve();
</script>

<Header {pending} {connect} />

<main class="container mx-auto">
	<slot />
</main>

<footer class="footer footer-center p-10 bg-neutral text-neutral-content">
	<p>Let's learn Foundry and Sveltekit!</p>
</footer>
