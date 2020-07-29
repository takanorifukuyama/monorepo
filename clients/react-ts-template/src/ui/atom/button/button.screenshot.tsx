import React from 'react'
import { ReactScreenshotTest } from 'react-screenshot-test'
import ContainedButton from './ContainedButton'

ReactScreenshotTest.create('App')
  .viewport('iPhone X', {
    width: 375,
    height: 812,
    deviceScaleFactor: 3,
    isMobile: true,
    hasTouch: true,
    isLandscape: false,
  })
  .shoot('Contained Button', <ContainedButton>ContainedButton</ContainedButton>)
  .run()
