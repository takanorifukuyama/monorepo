import firebase from 'firebase/app'
import 'firebase/firestore'
import 'firebase/auth'

import config from '../firebase.config'

if (!firebase.apps.length) {
    firebase.initializeApp(config)
}

export const authProvider = {
    Google: firebase.auth.GoogleAuthProvider.PROVIDER_ID
}
export const auth = firebase.auth()
export const firestore = firebase.firestore()