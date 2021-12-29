# frozen_string_literal: true

require_relative '../lib/map-visualizer/helpers/vec'

# test Vec class
describe Vec do
  describe 'when creating vector' do
    arr = []

    (0..3).each do |i|
      it "it can be created from #{i + 1} arguments" do
        arr << i + 1
        vec = Vec.new(*arr)

        expect(vec.x).to eq arr[0].nil? ? 0 : arr[0]
        expect(vec.y).to eq arr[1].nil? ? 0 : arr[1]
        expect(vec.z).to eq arr[2].nil? ? 0 : arr[2]
        expect(vec.w).to eq arr[3].nil? ? 0 : arr[3]
      end
    end
  end

  describe 'when comparing vectors' do
    it 'it compares lexicographically' do
      vec = Vec.new(1, 2, 3, 4)

      expect(vec).to be > Vec.new(0, 5, 5, 5)
      expect(vec).to be < Vec.new(2, 0, 0, 0)
      expect(vec).to be > Vec.new(1, 1, 5, 5)
      expect(vec).to be > Vec.new(1, 2, 3, 3)
      expect(vec).to be < Vec.new(1, 2, 3, 5)
      expect(vec).to eq Vec.new(1, 2, 3, 4)
    end
  end

  describe 'when adding two vectors' do
    it 'returns new vector' do
      expect(Vec.new(1) + Vec.new(1, 2)).to eq Vec.new(2, 2)
    end

    it 'can self assign' do
      vec = Vec.new(2)
      vec += Vec.new(3, 2)
      expect(vec).to eq Vec.new(5, 2)
    end
  end
end
