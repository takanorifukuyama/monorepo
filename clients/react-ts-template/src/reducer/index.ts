import { combineReducers } from 'redux'

import countUp from './countUp'

const rootReducer = () =>
  combineReducers({
    countUp,
  })

export default rootReducer
