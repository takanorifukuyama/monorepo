import React, { Fragment } from 'react'
import CountUp, { CountUpMoleculeProps } from 'ui/molecule/CountUp'

export type CountUpTemplateProps = CountUpMoleculeProps & {}

export default (props: CountUpTemplateProps) => {
  return (
    <Fragment>
      <CountUp {...props} />
    </Fragment>
  )
}
