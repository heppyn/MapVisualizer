# frozen_string_literal: true

# Convert temperature value to color
class Temperature
  @@temp_to_color = [
    '#4800a6',
    '#470160',
    '#0063fe',
    '#00a7fb',
    '#00d388',

    '#65ff00',
    '#f7ff08',
    '#fe9123',
    '#de5208',
    '#a40502'
  ].freeze

  def self.temperature_color(temp)
    raise IndexError, "Color not defined for temp #{temp}" if temp >= @@temp_to_color.size

    ChunkyPNG::Color.from_hex(@@temp_to_color[temp])
  end
end
