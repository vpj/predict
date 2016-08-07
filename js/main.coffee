Mod.require 'Weya.Base',
 'Weya'
 (Base, Weya) ->

  class App extends Base
   @initialize ->
    @elems =
     parent: document.body

   @listen 'error', (e) ->
    console.error e

   render: ->
    Weya elem: @elems.parent, context: this, ->
     @$.elems.canvas = @canvas "#canvas", null
     @div ->
      @button ".btn.btn-primary", "Run", on: {click: @$.on.runClick}
      @span " "
      @button ".btn.btn-default", "Clear", on: {click: @$.on.clearClick}

    @elems.canvas.addEventListener 'click', @on.canvasClick
    W = Math.min window.innerHeight, window.innerWidth
    W -= 50
    @elems.canvas.width = W #"#{W}px"
    @elems.canvas.height = W #"#{W}px"
    @W = W
    @points =
     x: []
     y: []

   @listen 'canvasClick', (e) ->
    x = e.pageX - @elems.canvas.offsetLeft
    y = e.pageY - @elems.canvas.offsetTop
    ctx = @elems.canvas.getContext '2d'
    ctx.fillStyle = 'rgba(30, 30, 100, 0.8)'
    ctx.beginPath()
    ctx.arc x, y, 2, 0, Math.PI * 2, true
    ctx.fill()
    @points.x.push x / @W
    @points.y.push y / @W

   @listen 'clearClick', (e) ->
    e.preventDefault()
    ctx = @elems.canvas.getContext '2d'
    ctx.clearRect 0, 0, @W, @W
    @points =
     x: []
     y: []


  APP = new App()
  APP.render()

document.addEventListener 'DOMContentLoaded', ->
 Mod.set 'Weya', Weya
 Mod.set 'Weya.Base', Weya.Base
 Mod.set 'CodeMirror', CodeMirror

 Mod.debug true

 Mod.initialize()
