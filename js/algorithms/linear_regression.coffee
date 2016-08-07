Mod.require 'App', (APP) ->
 algorithm = (x, y) ->
  X = 0
  Y = 0
  XY = 0
  X2 = 0
  Y2 = 0
  N = x.length
  for i in [0...N]
   X += x[i]
   Y += y[i]
   XY += x[i] * y[i]
   X2 += x[i] * x[i]
   Y2 += y[i] * y[i]

  covariance = (XY * N - X * Y)
  variance = (X2 * N - X * X)
  m = covariance / variance
  c = (Y - m * X) / N

  e = 0
  for i in [0...N]
   r = m * x[i] + c
   e += (y[i] - r) * (y[i] - r)

  res =
   x: [0, 1]
   y: [c, m + c]
   error: e


 APP.addAlgorithm
  name: 'Linear Regression'
  func: algorithm
