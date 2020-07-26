import { auth } from '@/plugins/firebase'

export const store = () => ({
    status: "",
    token: localStorage.getItem('token') || '',
    username: "",
})

export const getters = {
    isLoggedIn: state => state.status === "loggedIn"
}

export const actions = {
    gotUser({ commit }, user) {
        commit("setUser")
    },
    logout({ commit }) {
        auth.signOut().then(() => {
            commit("signout")
        })
    }
}
