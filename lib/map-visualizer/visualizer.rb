# frozen_string_literal: true

require 'chunky_png'
require 'color'
require_relative 'scene'

# visualize scene as a 2D map
class Visualizer
  def initialize(scene)
    @scene = scene
  end

  def trees(file_name)
    create_image

    (0..@scene.width - 1).each do |x|
      (0..@scene.height - 1).each do |y|
        @image[x, y] =
          @scene[x, y].tree ? ChunkyPNG::Color(Color::RGB::Red.hex) : ChunkyPNG::Color(Color::RGB::Snow.hex)
      end
    end

    save_image(file_name)
  end

  def create_image
    @image = ChunkyPNG::Image.new(@scene.width, @scene.height)
  end

  def save_image(file_name)
    @image.save(file_name)
  end
end
