import React from 'react'
import Typography from '@material-ui/core/Typography'
import { makeStyles } from '@material-ui/core/styles'

export type h1Props = { children: string }

const useStyles = makeStyles({
  root: {
    width: '100%',
  },
})

const H1: React.FC<h1Props> = (props) => {
  const classes = useStyles()

  return (
    <div className={classes.root}>
      <Typography variant="h1">{props.children}</Typography>
    </div>
  )
}
export default H1
