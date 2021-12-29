# frozen_string_literal: true

require_relative 'chunk'

# Stores chunks
class Scene
  attr_reader :width, :height, :size, :chunks

  def initialize(chunks)
    raise IndexError, 'Scene cannot be empty' if chunks.to_a.size.zero?

    @chunks = chunks
    calc_size
  end

  def calc_size
    bottom_left = @chunks[0].position
    top_right = @chunks[0].position

    @chunks.each do |chunk|
      bottom_left = chunk.position if chunk.position < bottom_left
      top_right = chunk.position if chunk.position > top_right
    end

    top_right += Vec.new(@chunks[0].size, @chunks[0].size)
    @width = top_right.x - bottom_left.x
    @height = top_right.y - bottom_left.y
    @size = Vec.new(width, height)
  end

  # Iterates over all chunks
  def each(&block)
    return enum_for(:each) unless block_given?

    @chunks.each(&block)
  end
end
