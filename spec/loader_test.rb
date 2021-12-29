# frozen_string_literal: true

require_relative '../lib/map-visualizer/loader'

# test Loader class
describe Loader do
  info_data1 = {
    "tree": '0',
    "hum": '2',
    "tem": '4',
    "biome": '2',
    "height": '23'
  }
  info_data2 = {
    "tree": '1',
    "hum": '3',
    "tem": '5',
    "biome": '3',
    "height": '24'
  }

  chunk_data = {
    "pos": [0, 0],
    "meta": [info_data2, info_data1, info_data1, info_data1]
  }

  describe 'when parsing block info' do
    bi_expected = BlockInfo.new(false, 2, 4, 2, 23)

    it 'returns BlockInfo from string representation' do
      bi = Loader.parse_info(info_data1)

      expect(bi.tree).to eq bi_expected.tree
      expect(bi.humidity).to eq bi_expected.humidity
      expect(bi.temperature).to eq bi_expected.temperature
      expect(bi.height).to eq bi_expected.height
    end

    it 'returns BlockInfo from numeric representation' do
      bi = Loader.parse_info({
                               "tree": 0,
                               "hum": 2,
                               "tem": 4,
                               "biome": 2,
                               "height": 23
                             })
      expect(bi.tree).to eq bi_expected.tree
      expect(bi.humidity).to eq bi_expected.humidity
      expect(bi.temperature).to eq bi_expected.temperature
      expect(bi.biome).to eq bi_expected.biome
      expect(bi.height).to eq bi_expected.height
    end
  end

  describe 'when parsing chunk' do
    it 'returns Chunk' do
      chunk = Loader.parse_chunk(chunk_data)

      expect(chunk.size).to eq 2
      expect(chunk.position).to eq Vec.new(0, 0)
      expect(chunk[3].height).to eq 23
      expect(chunk[0, 0].height).to eq 24
    end
  end

  describe 'when parsing scene' do
    it 'returns Scene object' do
      scene = Loader.parse_scene('spec/test_data/scene1.json')

      expect(scene.chunks.size).to eq 2
      scene.each do |chunk|
        expect(chunk.size).to eq 2
      end
    end
  end
end
