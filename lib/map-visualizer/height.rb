# frozen_string_literal: true

require 'color'
require 'chunky_png'

# Convert height value to color
class Height
  # Color intervals from lowest to heighest altitude
  @@height_to_color = [
    '#2ab653',
    '#f2f172',
    '#c67148',
    '#988aa4',
    '#ffffff'
  ].freeze

  def initialize(min = 0, max = 0)
    @min = min
    @max = max
  end

  # Lineary interpolate between set color points
  def height_color(height)
    norm = (height - @min).to_f / (@max - @min) * (@@height_to_color.size - 1)

    k = norm - norm.floor
    low = ChunkyPNG::Color.from_hex(@@height_to_color[norm.floor])
    hi = ChunkyPNG::Color.from_hex(@@height_to_color[norm.ceil])

    ChunkyPNG::Color.rgb(
      ((1 - k) * ChunkyPNG::Color.r(low) + k * ChunkyPNG::Color.r(hi)).to_i,
      ((1 - k) * ChunkyPNG::Color.g(low) + k * ChunkyPNG::Color.g(hi)).to_i,
      ((1 - k) * ChunkyPNG::Color.b(low) + k * ChunkyPNG::Color.b(hi)).to_i
    )
  end
end
