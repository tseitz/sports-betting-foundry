<script lang="ts">
	const data = new Array(3);
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Bet Me" />
</svelte:head>

{#each data as item}
	<div class="card glass w-full shadow-xl my-10">
		<div class="grid grid-cols-3 gap-2 p-8">
			<div class="flex content-center">
				<h2 class="card-title">Chiefs vs. Cardinals</h2>
				<p>Sept. 11, 2022</p>
			</div>
			<div class="flex justify-center">
				<div class="card card-compact w-auto bg-base-100 shadow-xl">
					<figure>
						<img src="https://placeimg.com/400/225/arch" class="h-48 w-auto" alt="Chiefs" />
					</figure>
					<div class="card-body">
						<h2 class="card-title justify-center">Chiefs</h2>
						<div class="card-actions justify-center">
							<button class="btn btn-accent">Bet</button>
						</div>
					</div>
				</div>
			</div>
			<div class="flex justify-center">
				<div class="card card-compact w-auto bg-base-100 shadow-xl">
					<figure>
						<img src="https://placeimg.com/400/225" class="h-48 w-auto" alt="Cardinals" />
					</figure>
					<div class="card-body">
						<h2 class="card-title justify-center">Cardinals</h2>
						<div class="card-actions justify-center">
							<button class="btn btn-accent">Bet</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{/each}
