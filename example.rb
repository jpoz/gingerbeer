#!/usr/local/bin/macruby
require 'gingerbeer'

@points =  [10,7,9,100,10,5,6,6,3,6,7]
@points2 = [5,6,1,2,4,100,9,9,3,3,10]

canvas = Canvas.new :type => :image, :filename => 'line.png', :size => [900,500]
canvas.background(Color.new(0.1,0.1,0.1))

graph = LineGraph.new(100, 100, 700, 300)
graph.points = @points
graph.base_stroke = Color.new(0.6,0.6,0.4)
graph.fill = Color.new(0.2,0.2,0.2)
graph.vertical = false
graph.numbers  = true
graph.draw(canvas)

graph2 = LineGraph.new(100, 100, 700, 300)
graph.points = @points2
graph.base_line = false
graph.vertical  = false
graph.scale     = false
graph.stroke = Color.pink
graph.fill   = Color.yellow
graph.draw(canvas)

canvas.save