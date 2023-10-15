import { createStore } from 'vuex'

const store = createStore({
  state: {
    isCollapse: false,
  },
  getters: {
  },
  mutations: {
    collapseChange(state) {
      state.isCollapse = !state.isCollapse
    }
  },
  actions: {
  },
  modules: {
  }
})

export default store;
