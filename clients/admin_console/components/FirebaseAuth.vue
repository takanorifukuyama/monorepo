<template lang="html">
  <div class="container">
    <button @click="signIn">
      Sign In
    </button>
  </div>
</template>

<script lang="js">
export default {
  name: "SignInButton",
  methods: {
    signIn() {
      console.log("sign in")
      this.$store.dispatch('auth/signIn')
    }
  } 
}
</script>

<style scoped>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}
</style>