import React from 'react'
import Button from '@material-ui/core/Button'

export type containedButtonProps = { children: string }

const ContainedButton: React.FC<containedButtonProps> = (props) => (
  <Button variant="contained" color="primary">
    {props.children}
  </Button>
)
export default ContainedButton
