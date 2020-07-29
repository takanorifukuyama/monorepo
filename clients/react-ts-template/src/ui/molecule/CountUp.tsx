import React, { Fragment } from 'react'

import ContainedButton from 'ui/atom/button/ContainedButton'
import Body1 from 'ui/atom/typography/Body1'

export type CountUpMoleculeProps = {
  onIncrement: () => void
  onDecrement: () => void
  count: number
}

const CountUp: React.FC<CountUpMoleculeProps> = (props) => {
  return (
    <Fragment>
      <ContainedButton onClick={props.onIncrement}>+</ContainedButton>
      <ContainedButton onClick={props.onDecrement}>-</ContainedButton>
      <Body1>{props.count}</Body1>
    </Fragment>
  )
}

export default CountUp
