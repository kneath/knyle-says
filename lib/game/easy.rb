module Game
  # Easy mode. The surface is split into four quadrants. Just like Simon Says.
  class Easy

    def initialize
      @interaction = Game.interaction
      @device = @interaction.device
      sleep 1.0
      @device.reset

      @sequence = []
      @on = true

      start
    end

    # Just a little example light show.
    def example
      display [1, 3, 2, 4, 3, 4, 2 , 4, 1]
    end

    # Start the game!
    def start
      @level ||= 0
      @level += 1

      @device.reset

      @sequence = (1..@level*2).collect { Random.rand(1..4) }
      display(@sequence)
      sleep 0.5

      @interaction.response_to(:grid, :down) do |interaction, action|
        handle_press which_quadrant(action[:x], action[:y])
      end
      @interaction.start
    end

    # Display a little light show
    def display(arr=[])
      arr.each do |quad|
        @device.reset
        sleep 0.25
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
        @interaction.no_response_to [:grid], :both
        display_loss
      end

      if @sequence.empty?
        @interaction.no_response_to [:grid], :both
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
      sleep 5
      Game::Intro.new
    end

    def display_win
      (0..7).each do |x_index|
        (0..7).each do |y_index|
          @device.change :grid, :x => x_index, :y => y_index, :red => :off, :green => :high, :mode => :flashing
        end
      end
      @device.flashing_auto
      sleep 3
      start
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
