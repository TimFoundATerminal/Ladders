<script lang="ts">
    import type { LayoutData } from './$types';

    export let data: LayoutData;
</script>

<h1>About</h1>

<div>
    {#each data.sections as section}
        <p>{section.title}</p>
        <p>{section.content}</p>
    {/each}
</div>




