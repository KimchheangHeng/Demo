// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

func PopTransition(progress: Float, start startValue:Float, end endValue: Float) -> Float {
  return startValue + (progress * (endValue - startValue))
}

for i in 1...100 {
  
  let progress = Float(i)
  let scale = PopTransition(progress, start: 1.0, end: 0.5)
  
  let x = PopTransition(progress, start: 0, end: 320)
  let y = PopTransition(progress, start: 0, end: 568)
}