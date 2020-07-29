import rootReducer from '../reducer'
import { createStore, applyMiddleware } from 'redux'
import { TCountUp } from '../reducer/countUp'
import { persistReducer } from 'redux-persist'
import storage from 'redux-persist/lib/storage'
import { composeWithDevTools } from 'redux-devtools-extension'
import { createLogger } from 'redux-logger'
import ReactGA from 'react-ga'

export type TStore = {
  countUp: TCountUp
}

if (process.env.NODE_ENV !== 'development') {
  ReactGA.initialize('')
}

const persistconfig = {
  key: 'root',
  storage,
}

const logger = createLogger({
  collapsed: true,
  diff: true,
})

const persistedReducer = persistReducer(persistconfig, rootReducer())

const store = createStore(
  persistedReducer,
  composeWithDevTools(applyMiddleware(logger)),
)

export default store
