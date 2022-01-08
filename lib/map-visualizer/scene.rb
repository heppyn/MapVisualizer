# frozen_string_literal: true

require_relative 'chunk'

# Stores chunks
class Scene
  attr_reader :width, :height, :size, :chunks

  def initialize(chunks)
    raise IndexError, 'Scene cannot be empty' if chunks.to_a.size.zero?

    calc_size(chunks)
    @chunks = {}
    chunks.each do |chunk|
      # start chunks from [0, 0]
      @chunks[chunk.position + Vec.new(@bottom_left.x.abs, @bottom_left.y.abs)] = chunk
    end
  end

  def calc_size(chunks)
    @bottom_left, top_right = chunks.map(&:position).minmax

    @chunk_size = chunks[0].size

    top_right += Vec.new(@chunk_size, @chunk_size)

    @width = top_right.x - @bottom_left.x
    @height = top_right.y - @bottom_left.y
    @size = Vec.new(width, height)
  end

  # Iterates over all chunks
  def each(&block)
    return enum_for(:each_value) unless block_given?

    @chunks.each_value(&block)
  end

  # Iterates over all block in the scene
  def each_block(&block)
    unless block_given?
      return Enumerator.new do |res|
        each do |chunk|
          chunk.each do |bi|
            res << bi
          end
        end
      end
    end

    each_block.each(&block)
  end

  # Return BlockInfo at position on the scene
  #
  # @param [int] x coord
  # @param [int] y coord
  # @return [BlockInfo] block at location
  def [](x, y)
    mod_x = x % @chunk_size
    mod_y = y % @chunk_size
    pos = Vec.new(x - mod_x, y - mod_y)

    raise ArgumentError, "Chunk not in the scene #{pos}, #{@chunks.keys}" unless @chunks.key?(pos)

    @chunks[pos][mod_x, mod_y]
  end
end
