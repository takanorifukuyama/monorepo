import React from 'react'
import { ReactScreenshotTest } from 'react-screenshot-test'
import H1 from './H1'
import Body1 from './Body1'

ReactScreenshotTest.create('App')
  .viewport('iPhone X', {
    width: 375,
    height: 812,
    deviceScaleFactor: 3,
    isMobile: true,
    hasTouch: true,
    isLandscape: false,
  })
  .shoot('app', <H1>H1</H1>)
  .shoot('body1', <Body1>Body1</Body1>)
  .run()
