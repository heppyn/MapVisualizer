# frozen_string_literal: true

require 'color'
require_relative 'scene'
require_relative 'biome'
require_relative 'helpers/image'

# visualize scene as a 2D map
class Visualizer
  def initialize(scene)
    @scene = scene
  end

  def trees(file_name)
    create_image
    create_background(200)

    (0..@scene.width - 1).each do |x|
      (0..@scene.height - 1).each do |y|
        @image[x, y] = ChunkyPNG::Color(Color::RGB::Red.hex) if @scene[x, y].tree
      end
    end

    save_image(file_name)
  end

  def biomes(file_name)
    create_image

    (0..@scene.width - 1).each do |x|
      (0..@scene.height - 1).each do |y|
        @image[x, y] = Biome.biome_color(@scene[x, y].biome)
      end
    end

    save_image(file_name)
  end

  def create_background(alpha)
    (0..@scene.width - 1).each do |x|
      (0..@scene.height - 1).each do |y|
        @image[x, y] = ChunkyPNG::Color.grayscale_alpha(
          ChunkyPNG::Color.grayscale_teint(
            Biome.biome_color(@scene[x, y].biome)
          ), alpha
        )
      end
    end
  end

  def create_image
    @image = Image.new(@scene.width, @scene.height)
  end

  def save_image(file_name)
    @image.save(file_name)
  end
end
