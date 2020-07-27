import { auth } from '@/plugins/firebase'

export const store = () => ({
    status: "",
    token: localStorage.getItem('token') || '',
    username: "",
})

export const getters = {
    isSignedIn: state => state.status === "signedIn"
}

export const actions = {
    gotUser({ commit }, user) {
        commit("setUser", user)
    },
    logout({ commit }) {
        auth.signOut().then(() => {
            commit("signout")
        })
    }
}
