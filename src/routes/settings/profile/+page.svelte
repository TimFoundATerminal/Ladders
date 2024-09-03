<script lang="ts">
    import CardContent from "$lib/components/ui/card/card-content.svelte";
    import CardHeader from "$lib/components/ui/card/card-header.svelte";
    import Card from "$lib/components/ui/card/card.svelte";
    import {
        type DateValue,
        DateFormatter,
        getLocalTimeZone,
    } from "@internationalized/date";

    const df = new DateFormatter("en-US", {
        dateStyle: "long",
    });

    import SettingsForm from "./profile-form.svelte";
 
    let value: DateValue | undefined = undefined;

    export let data;

    console.log(data.playerProfile);
    console.log(data.form);

</script>

{#if data.playerProfile}
    <Card>
        <CardHeader>Manage your profile</CardHeader>
        <CardContent>
            <SettingsForm data={data.form} />
        </CardContent>
    </Card>
{:else}
    <p>Not Logged in</p>
{/if}