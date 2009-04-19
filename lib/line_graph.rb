#!/usr/local/bin/macruby
require 'hotcocoa/graphics'
include HotCocoa
include Graphics

class LineGraph
  attr_accessor :x, :y, :width, :height, :points
  attr_accessor :base_width, :back_width, :main_width
  attr_accessor :base_stroke, :back_stroke, :main_stroke
  attr_accessor :base_fill, :back_fill, :main_fill
  attr_accessor :scale, :base_line, :horizontal, :vertical, :numbers
  
  def initialize(x,y,width,height)
    @numbers = @base_line = @horizontal = @vertical = @scale = true
    @points = nil
    @x, @y, @width, @height = x, y, width+0.0, height+0.0
    self.stroke = Color.new(1,1,1)
    self.fill = Color.new(0.9,0.9,0.9)
    self.strokewidth= 2
  end
  
  def stroke=(stroke)
    @base_stroke = @back_stroke = @main_stroke = stroke
  end
  
  def strokewidth=(width)
    @base_width = @back_width = @main_width = width
  end
  
  def fill=(fill)
    @base_fill = @back_fill = @main_fill = fill
  end
  
  def draw(canvas)
    draw_base(canvas) if base_line
    draw_back(canvas) if horizontal
    draw_main(canvas)
    draw_scale(canvas) if scale
  end
  
  private
  
  def draw_base(canvas)
    canvas.stroke(@base_stroke)
    canvas.fill(@base_fill)
    canvas.strokewidth(@base_width)
    canvas.lines([[@x,@y],[@x+@width,@y]])
  end
  
  def draw_back(canvas)
    canvas.stroke(@back_stroke)
    canvas.fill(@back_fill)
    canvas.strokewidth(@back_width)
    diff = @width/(@points.size-1)
    x = @x
    back_points = @points.map do |p|
      point = [x,@y+(p*multi)]
      x += diff
      point
    end
    canvas.lines(back_points) if back_points
  end
  
  def draw_main(canvas)
    font_size = 24
    canvas.font('Myraid Pro')
    canvas.fontsize(font_size)
    
    canvas.stroke(@main_stroke)
    canvas.fill(@main_fill)
    canvas.strokewidth(@main_width)
    diff = (@width/(@points.size-1))
    
    x = @x
    @points.size.times do |i|
      y = @y+(@points[i]*multi)
      point = [x,y]
      canvas.lines([[x,@y],point]) if vertical
      canvas.draw(Path.new.oval(x,y,10,10,:center))
      canvas.text("#{points[i]}", x-(font_size/4), y+(font_size/2)) if numbers
      x += diff
    end
  end
  
  def draw_scale(canvas)
    # height = 100 #max = 32 #segments = 4 #segment_height = 25
    font_size = 48
    canvas.font('Myraid Pro')
    canvas.fontsize(font_size)
    canvas.stroke(@back_stroke)
    canvas.fill(@back_fill)
    canvas.strokewidth(@back_width)
    segments = ((@points.max/10.0).ceil+0.0)*2
    segment_height = @height/segments
    
    (segments+1).times do |i|
      y = @y+segment_height*i
      canvas.text("#{i*5}", @x-(font_size/2)-20, y-(font_size/8))
      canvas.lines([[@x-5,y],[@x-15,y]])
    end
  end
  
  def multi
    @height/(((@points.max/10.0).ceil+0.0)*10)
  end
end
