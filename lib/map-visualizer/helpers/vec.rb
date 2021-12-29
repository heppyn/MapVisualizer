# frozen_string_literal: true

# Represents comparable vector with x, y, z, w coordinates
class Vec
  include Comparable
  def initialize(*params)
    @data = params[0, 4]
    @data << 0 while @data.size < 4
  end

  def <=>(other)
    return nil unless other.is_a? Vec

    (0..3).each do |i|
      return @data[i] <=> other.instance_variable_get(:@data)[i] if @data[i] != other.instance_variable_get(:@data)[i]
    end

    0
  end

  def x
    @data[0]
  end

  def y
    @data[1]
  end

  def z
    @data[2]
  end

  def w
    @data[3]
  end
end
