# frozen_string_literal: true

require 'chunky_png'

# Image with invert y axis
class Image < ChunkyPNG::Image
  def [](x, y)
    super(x, height - 1 - y)
  end

  def []=(x, y, color)
    super(x, height - 1 - y, color)
  end
end
