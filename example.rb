#!/usr/local/bin/macruby
require 'gingerbeer'

@points = [10,7,9,10,10,5,6,6,3,6,7]

canvas = Canvas.new :type => :image, :filename => 'line.png', :size => [2000,1000]
canvas.background(Color.new(0.1,0.1,0.1))

graph = LineGraph.new(100, 100, 1800, 350)
graph.points = @points
graph.base_stroke = Color.new(0.2,0.6,0.4)
graph.fill = Color.new(0.2,0.2,0.2)
graph.vertical = false
graph.numbers  = true
graph.draw(canvas)

canvas.translate(0,500)
graph.draw(canvas)

canvas.save