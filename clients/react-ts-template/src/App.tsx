import React from 'react'
import reset from 'styled-reset'
import { ThemeProvider } from '@material-ui/core'
import { theme } from 'theme'
import { createGlobalStyle } from 'styled-components'
import { Provider } from 'react-redux'

import CountUp from 'ui/page/CountUp'

import store from 'store'

const GloablStyle = createGlobalStyle`
  ${reset}
`

const App = () => {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <GloablStyle />
        <CountUp />
      </ThemeProvider>
    </Provider>
  )
}

export default App
