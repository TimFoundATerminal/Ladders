<script lang="ts">
    import * as Form from "$lib/components/ui/form";
    import { Input } from "$lib/components/ui/input";
    import { playerSchema, type FormSchema } from "./schema";
    import {
        type SuperValidated,
        type Infer,
        superForm,
    } from "sveltekit-superforms";
    import { zodClient } from "sveltekit-superforms/adapters";
    
    export let data: SuperValidated<Infer<FormSchema>>;
    
    const form = superForm(data, {
     validators: zodClient(playerSchema),
    });
    
    const { form: formData, enhance } = form;
</script>
    
<form method="POST" use:enhance>
    <Form.Field {form} name="email">
        <Form.Control let:attrs>
            <Form.Label>Email</Form.Label>
            <Input {...attrs} bind:value={$formData.email} />
        </Form.Control>
        <Form.Description>This is your university email address.</Form.Description>
        <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="firstname">
        <Form.Control let:attrs>
            <Form.Label>Firstname</Form.Label>
            <Input {...attrs} bind:value={$formData.firstname} />
        </Form.Control>
        <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="surname">
        <Form.Control let:attrs>
            <Form.Label>Surname</Form.Label>
            <Input {...attrs} bind:value={$formData.surname} />
        </Form.Control>
        <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="gender">
        <Form.Control let:attrs>
            <Form.Label>Gender</Form.Label>
            <Input {...attrs} bind:value={$formData.gender} />
        </Form.Control>
        <Form.FieldErrors />
    </Form.Field>

    <Form.Button>Submit</Form.Button>
</form>