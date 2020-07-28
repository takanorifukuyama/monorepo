import React from 'react'
import reset from 'styled-reset'
import { ThemeProvider } from '@material-ui/core'
import { theme } from 'theme'
import { createGlobalStyle } from 'styled-components'

const GloablStyle = createGlobalStyle`
  ${reset}
`

const App = () => {
  return (
    <GloablStyle>
      <ThemeProvider theme={theme}></ThemeProvider>
    </GloablStyle>
  )
}

export default App
