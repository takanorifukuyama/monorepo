import { Reducer } from 'redux'

export type TCountUp = {
  num: number
}

const initialState: TCountUp = {
  num: 0,
}

const countUp: Reducer<TCountUp> = (state = initialState, action) => {
  switch (action.type) {
    case 'DECREMENT':
      return Object.assign(
        {},
        {
          ...state,
          num: state.num - 1,
        },
      )
    case 'INCREMENT':
      return Object.assign(
        {},
        {
          ...state,
          num: state.num + 1,
        },
      )
    default:
      return state
  }
}

export default countUp
