import React from 'react'
import Typography from '@material-ui/core/Typography'
import { makeStyles } from '@material-ui/core/styles'

export type body1Props = {
  className?: string
  children?: any
}

const useStyles = makeStyles({
  root: {
    margin: '20',
  },
})

const Body1: React.FC<body1Props> = (props) => {
  const classes = useStyles()

  return (
    <div className={classes.root}>
      <Typography variant="body1">{props.children}</Typography>
    </div>
  )
}

export default Body1
