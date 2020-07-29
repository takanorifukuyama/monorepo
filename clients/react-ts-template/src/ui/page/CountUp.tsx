import React from 'react'
import UI from 'ui/template/CountUp'
import { useDispatch, useSelector } from 'react-redux'
import { TStore } from 'store'

export default () => {
  const num = useSelector((state: TStore) => state.countUp.num)
  const dispatch = useDispatch()
  return (
    <UI
      onIncrement={() => dispatch({ type: 'INCREMENT' })}
      onDecrement={() => dispatch({ type: 'DECREMENT' })}
      count={num}
    />
  )
}
