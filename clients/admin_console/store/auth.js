import firebase, { auth } from '@/plugins/firebase'

export const store = () => ({
    status: "",
    token: localStorage.getItem('token') || '',
    username: "",
})

export const getters = {
    isSignedIn: state => state.status === "authenticated"
}

export const mutations = {
    setSignIn(state, user) {
        state.token = user.credential.accessToken
        state.status = "authenticated"
    } 
}

export const actions = {
    signIn({ commit }) {
        console.log("sign in actions");
        const provider = new firebase.auth.GoogleAuthProvider()
        auth.signInWithPopup(provider).then((result) => {
            console.log(result.user)
            commit("setSignIn", result)
        }).catch(err => {
            console.log(err.code)
        })
    },
    gotUser({ commit }, user) {
        commit("setUser", user)
    },
    logout({ commit }) {
        auth.signOut().then(() => {
            commit("signout")
        })
    }
}
