module Game
  class Intro

    def initialize
      @interaction = Game.interaction
      @device = @interaction.device
      @device.reset
      sleep 2.0

      display_pattern
      sleep 0.5
      display_hello
      sleep 0.5
      display_start

      @interaction.response_to(:grid, :down) do |interaction, action|
        if action[:x].between?(2, 5) && action[:y].between?(5, 6)
          @device.test_leds
          sleep 1
          @device.reset
          Game::Easy.new
        end
      end
      @interaction.start
    end

    def paint_delay
      sleep 0.075
    end

    def display_pattern
      (0..7).each do |index|
        @device.change :grid, :x => index, :y => 0, :red => :high
        paint_delay
        @device.change :grid, :x => index, :y => 0, :red => :off
      end

      (0..7).each do |index|
        @device.change :grid, :x => 7, :y => index, :red => :high
        paint_delay
        @device.change :grid, :x => 7, :y => index, :red => :off
      end

      (0..7).each do |index|
        @device.change :grid, :x => 7 - index, :y => 7, :red => :high
        paint_delay
        @device.change :grid, :x => 7 - index, :y => 7, :red => :off
      end

      (0..7).each do |index|
        @device.change :grid, :x => 0, :y => 7 - index, :red => :high
        paint_delay
        @device.change :grid, :x => 0, :y => 7 - index, :red => :off
      end
    end

    def display_hello
      @device.change :grid, :x => 0, :y => 1, :green => :high, :red => :high
      @device.change :grid, :x => 0, :y => 2, :green => :high, :red => :high
      @device.change :grid, :x => 0, :y => 3, :green => :high, :red => :high
      @device.change :grid, :x => 1, :y => 2, :green => :high, :red => :high
      @device.change :grid, :x => 2, :y => 1, :green => :high, :red => :high
      @device.change :grid, :x => 2, :y => 2, :green => :high, :red => :high
      @device.change :grid, :x => 2, :y => 3, :green => :high, :red => :high

      @device.change :grid, :x => 5, :y => 1, :green => :high, :red => :high
      @device.change :grid, :x => 6, :y => 1, :green => :high, :red => :high
      @device.change :grid, :x => 7, :y => 1, :green => :high, :red => :high
      @device.change :grid, :x => 6, :y => 2, :green => :high, :red => :high
      @device.change :grid, :x => 6, :y => 2, :green => :high, :red => :high
      @device.change :grid, :x => 5, :y => 3, :green => :high, :red => :high
      @device.change :grid, :x => 6, :y => 3, :green => :high, :red => :high
      @device.change :grid, :x => 7, :y => 3, :green => :high, :red => :high
    end

    def display_start
      @device.flashing_auto
      @device.change :grid, :x => 2, :y => 5, :green => :high, :mode => :flashing
      @device.change :grid, :x => 3, :y => 5, :green => :high, :mode => :flashing
      @device.change :grid, :x => 4, :y => 5, :green => :high, :mode => :flashing
      @device.change :grid, :x => 5, :y => 5, :green => :high, :mode => :flashing
      @device.change :grid, :x => 2, :y => 6, :green => :high, :mode => :flashing
      @device.change :grid, :x => 3, :y => 6, :green => :high, :mode => :flashing
      @device.change :grid, :x => 4, :y => 6, :green => :high, :mode => :flashing
      @device.change :grid, :x => 5, :y => 6, :green => :high, :mode => :flashing
    end

  end
end
