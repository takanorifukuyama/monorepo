import React from 'react'
import Button from '@material-ui/core/Button'

export type containedButtonProps = {
  className?: string
  fillWidth?: boolean
  disable?: boolean
  children?: string
  onClick?: (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => void
}

const ContainedButton: React.FC<containedButtonProps> = (props) => (
  <Button variant="contained" color="primary" onClick={props.onClick}>
    {props.children}
  </Button>
)

export default ContainedButton
