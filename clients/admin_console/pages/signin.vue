<template>
    <div class="container" >
        <sign-in-button />
    </div>
</template>

<script lang="js">
import SignInButton from '@/components/FirebaseAuth'
export default {
    components: {
        SignInButton,
    }
}
</script>