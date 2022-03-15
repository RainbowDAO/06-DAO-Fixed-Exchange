import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import app from "./modules/app";
import tokenExchangeFactory from "./modules/tokenExchangeFactory";

import erc20 from "./modules/erc20";

Vue.use(Vuex)

export default new Vuex.Store({
  getters,
  modules: {
    app,
    tokenExchangeFactory,
    erc20
  }
})
