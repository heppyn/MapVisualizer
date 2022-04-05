# frozen_string_literal: true

require 'color'
require_relative 'scene'
require_relative 'biome'
require_relative 'temperature'
require_relative 'height'
require_relative 'helpers/image'

# visualize scene as a 2D map
class Visualizer
  def initialize(scene)
    @scene = scene
  end

  def trees(file_name)
    create_image
    create_background(200)

    execute_on_pixel do |x, y|
      @image[x, y] = ChunkyPNG::Color(Color::RGB::Red.hex) if @scene[x, y].tree
    end

    save_image(file_name)
  end

  def biomes(file_name)
    create_image

    execute_on_pixel do |x, y|
      @image[x, y] = Biome.biome_color(@scene[x, y].biome)
    end

    save_image(file_name)
  end

  def humidity(file_name)
    create_image

    execute_on_pixel do |x, y|
      @image[x, y] = ChunkyPNG::Color.rgb(
        0, 0, @scene[x, y].humidity.zero? ? 255 : 170 - 15 * @scene[x, y].humidity
      )
    end

    save_image(file_name)
  end

  def temperature(file_name)
    create_image

    execute_on_pixel do |x, y|
      @image[x, y] = Temperature.temperature_color(@scene[x, y].temperature)
    end

    save_image(file_name)
  end

  def height(file_name, minmax = :default)
    create_image
    h = Height.new(
      minmax == :default ? @scene.minmax(&:height) : minmax
    )

    execute_on_pixel do |x, y|
      @image[x, y] = if Biome.water?(@scene[x, y].biome)
                       Biome.biome_color(@scene[x, y].biome)
                     else
                       h.height_color(@scene[x, y].height)
                     end
    end

    save_image(file_name)
  end

  # Create background from biomes
  #
  # @param [Float] alpha of the background [0, 1]
  def create_background(alpha)
    execute_on_pixel do |x, y|
      @image[x, y] = ChunkyPNG::Color.grayscale_alpha(
        ChunkyPNG::Color.grayscale_teint(
          Biome.biome_color(@scene[x, y].biome)
        ), alpha
      )
    end
  end

  # Execute block on every block of the scene
  #
  # @param block to execute
  def execute_on_pixel(&block)
    (0..@scene.width - 1).each do |x|
      (0..@scene.height - 1).each do |y|
        block.call(x, y)
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
