<template>
    <firebase-auth />
</template>

<script lang="js">
import FirebaseAuth from '@/components/FirebaseAuth'
import { mapState, mapGetters, mapActions } from 'vuex'
export default {
    name: 'SignIn',
    components: {
        FirebaseAuth
    }
}
</script>