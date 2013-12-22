module Game
  # Easy mode. The surface is split into four quadrants. Just like Simon Says.
  class Easy

    def initialize
      @interaction = Launchpad::Interaction.new
      @device = @interaction.device
      sleep 1.0
      @device.reset

      @sequence = []
    end

    # Just a little example light show.
    def example
      display [1, 3, 2, 4, 3, 4, 2 , 4, 1]
    end

    # Start the game!
    def start
      @sequence = (1..6).collect { Random.rand(1..4) }
      display(@sequence)

      @interaction.response_to(:grid, :down) do |interaction, action|
        handle_press which_quadrant(action[:x], action[:y])
      end
      @interaction.start
      sleep 0.5
    end

    # Display a little light show
    def display(arr=[])
      arr.each do |quad|
        @device.reset
        light_up(quad)
        delay
      end
      @device.reset
    end

    # Light up the quadrant we want.
    def light_up(quad)
      case quad
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

    def handle_press(quad)
      @device.reset
      light_up(quad)

      if @sequence.shift != quad
        display_loss
      end

      if @sequence.empty?
        display_win
      end
    end

    def display_loss
      (0..7).each do |x_index|
        (0..7).each do |y_index|
          @device.change :grid, :x => x_index, :y => y_index, :red => :high, :green => :off, :mode => :flashing
        end
      end
      @device.flashing_auto
    end

    def display_win
      (0..7).each do |x_index|
        (0..7).each do |y_index|
          @device.change :grid, :x => x_index, :y => y_index, :red => :off, :green => :high, :mode => :flashing
        end
      end
      @device.flashing_auto
    end

    def which_quadrant(x, y)
      if x.between?(0, 3) && y.between?(0, 3)
        return 1
      elsif x.between?(4, 7) && y.between?(0, 3)
        return 2
      elsif x.between?(0, 3) && y.between?(4, 7)
        return 3
      elsif x.between?(4, 7) && y.between?(4, 7)
        return 4
      end
    end

    def delay
      sleep 0.3
    end

  end
end
