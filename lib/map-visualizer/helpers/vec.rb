# frozen_string_literal: true

# Represents lexicographically comparable vector with x, y, z, w components
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

  alias eql? ==

  def hash
    @data.hash
  end

  def +(other)
    if other.is_a? Vec
      new_data = []
      (0..3).each do |i|
        new_data << @data[i] + other.instance_variable_get(:@data)[i]
      end

      return Vec.new(*new_data)
    end

    raise ArgumentError, 'other must be Vec'
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
