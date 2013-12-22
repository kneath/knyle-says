module Game
  # Easy mode. The surface is split into four quadrants. Just like Simon Says.
  class Easy

    def initialize
      @device = Launchpad::Device.new
      sleep 1.0
      @device.reset
    end

    # Just a little example light show.
    def example
      display [1, 3, 2, 4, 3, 4, 2 , 4, 1]
    end

    # Display a little light show
    def display(arr=[])
      arr.each do |index|
        @device.reset
        light_up(index)
        delay
      end
      @device.reset
    end

    # Light up the quadrant we want.
    def light_up(index)
      case index
      when 1
        (0..3).each do |x_index|
          (0..3).each do |y_index|
            @device.change :grid, :x => x_index, :y => y_index, :green => :high
          end
        end
      when 2
        (4..7).each do |x_index|
          (0..3).each do |y_index|
            @device.change :grid, :x => x_index, :y => y_index, :green => :high, :red => :high
          end
        end
      when 3
        (0..3).each do |x_index|
          (4..7).each do |y_index|
            @device.change :grid, :x => x_index, :y => y_index, :red => :high
          end
        end
      when 4
        (4..7).each do |x_index|
          (4..7).each do |y_index|
            @device.change :grid, :x => x_index, :y => y_index, :green => :low, :red => :medium
          end
        end
      end
    end

    def delay
      sleep 0.3
    end

  end
end
