<template lang="html">
    <firebaseui-auth-container />
</template>

<script lang="js">
import { auth, authProvider } from '@/plugins/firebase'
import firebaseui from 'firebaseui'

export default {
  name: "FirebaseAuth",
  mounted() {
    auth.onAuthStateChanged(user => {
      if (!user) {
        const ui = firebaseui.auth.AuthUI.getInstance() || new firebaseui.auth.AuthUI(auth)

        ui.start('#firebaseui-auth-container', {
          signInOptions: [
            authProvider.Google,
          ],
          callbacks: {
            signInSuccessWithAuthResult: (authResult) => {
              window.location.href = "/"
              return false
            }
          },
          signInSuccessUrl: "/",
          signInFlow: 'popup',
        })
      }
    })
  }
}
</script>
