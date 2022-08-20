<script lang="ts">
	export let text: string;
	export let btnStyle: string = '';
	export let action: () => void = () => {};
</script>

<button class="btn gap-3 {btnStyle} rounded-full" on:click={action}>
	{text}
	<slot />
</button>
