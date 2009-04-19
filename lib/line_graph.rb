#!/usr/local/bin/macruby

require 'hotcocoa/graphics'
include HotCocoa
include Graphics

class LineGraph
  attr_accessor :x, :y, :width, :height, :points
  attr_accessor :base_width, :back_width, :main_width
  attr_accessor :base_stroke, :back_stroke, :main_stroke
  attr_accessor :base_fill, :back_fill, :main_fill
  attr_accessor :font, :font_size, :title
  
  def initialize(x,y,width,height)
    @points = nil
    @x, @y, @width, @height = x, y, width+0.0, height+0.0
    self.stroke = Color.new(1,1,1)
    self.fill = Color.new(0.9,0.9,0.9)
    self.strokewidth= 2
    @font = 'Myraid Pro'
    @font_size = 24
    @title = nil
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
    draw_base(canvas)
    draw_back(canvas)
    draw_main(canvas)
    add_title(canvas) if @title
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
      point = [x,@y+p]
      x += diff
      point
    end
    canvas.lines(back_points) if back_points
  end
  
  def draw_main(canvas)
    canvas.stroke(@main_stroke)
    canvas.fill(@main_fill)
    canvas.strokewidth(@main_width)
    diff = (@width/(@points.size-1))
    x = @x
    # puts "diff #{diff} width #{@width} #{@points.size} points"
    @points.size.times do |i|
      y = @y+@points[i]
      point = [x,y]
      canvas.lines([[x,@y],point])
      canvas.draw(Path.new.oval(x,y,10,10,:center))
      x += diff
    end
  end
  
  def add_title(canvas)
    canvas.font('Myraid Pro')
    canvas.fontsize(48)
    canvas.text(@title, @x, @y+@height-@font_size)
  end
end