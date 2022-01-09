# frozen_string_literal: true

require 'optparse'
require_relative 'map-visualizer/visualizer'
require_relative 'map-visualizer/loader'

# CLI app for visualizing maps
class MapVisualizer
  def initialize
    @params = {
      out: 'map.png',
      map: 'biomes'
    }
  end

  def parse(options)
    begin
      parse_options(options)
    rescue OptionParser::MissingArgument => e
      puts "Fill all required arguments - #{e.message}"
      help
    rescue OptionParser::InvalidOption => e
      puts "unrecognised option - #{e.message}"
      help
    end

    if !@params[:in]
      puts 'You have to specify input file -i INPUT_FILE'
      help
    elsif !File.exist? @params[:in]
      puts "File '#{@params[:in]}' does not exist"
      exit
    end
  end

  def parse_options(options)
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Map Visualizer'

      opts.on('-i', '--input FILE', 'Specify input file') do |file|
        @params[:in] = file
      end
      opts.on('-o', '--output FILE', 'Specify output file') do |file|
        @params[:out] = file
      end
      opts.on('-g', '--generate MAP p1 p2',
              'Specify map type <biomes, humidity, temperature, trees, height [min, max]>') do |map|
        @params[:map] = map
        # following height params
        if ARGV[0] && ARGV[1] && !ARGV[0].start_with?('-') && !ARGV[1].start_with?('-')
          @params[:p1] = ARGV[0].to_i
          @params[:p2] = ARGV[1].to_i

          if @params[:p1].zero? && @params[:p2].zero?
            puts "At least one height argument must be non zero. Supplied #{ARGV[0]}, #{ARGV[1]}"
            exit
          end
        end
      end
      opts.on('-h', '--help', 'Usage: -i INPUT_FILE -o OUTPUT_FILE -g MAP_TYPE') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    ARGV
  end

  def run
    select_map
    begin
      scene = Loader.parse_scene(@params[:in])
      vis = Visualizer.new(scene)
      @params[:map].call(vis, @params[:out])
    rescue JSON::ParserError
      puts "File '#{@params[:in]}' is not valid JSON"
      exit
    rescue ArgumentError => e
      puts "Wrong input arguments. #{e.message}"
    rescue => e
      puts "Failed to parse file. #{e.message}"
    end
  end

  def select_map
    case @params[:map]
    when 'trees'
      @params[:map] = :trees.to_proc
    when 'biomes'
      @params[:map] = :biomes.to_proc
    when 'humidity'
      @params[:map] = :humidity.to_proc
    when 'temperature'
      @params[:map] = :temperature.to_proc
    when 'height'
      @params[:map] = proc { |x, file|
        x.height(
          file, @params[:p2] ? [@params[:p1].to_i, @params[:p2].to_i] : :default
        )
      }
    else
      puts "Unsuported map type '#{@params[:map]}'"
      help
    end
  end

  def help
    MapVisualizer.new.parse %w[--help]
  end
end

vis = MapVisualizer.new
vis.parse(ARGV.empty? ? %w[--help] : ARGV)
vis.run
