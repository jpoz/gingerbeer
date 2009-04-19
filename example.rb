#!/usr/local/bin/macruby
require 'gingerbeer'

@points = [120,30,300,250,100,300,20,100]

canvas = Canvas.new :type => :image, :filename => 'line.png', :size => [900,500]
canvas.background(Color.new(0.1,0.1,0.1))

graph = LineGraph.new(100, 100, 700, 300)
graph.points = @points
graph.title = "This is my Graph"
graph.draw(canvas)

canvas.save