require 'launchpad'

@device = Launchpad::Device.new
sleep 1.0
@device.reset

def top_left
  @device.reset
  (0..3).each do |x_index|
    (0..3).each do |y_index|
      @device.change :grid, :x => x_index, :y => y_index, :green => :high
    end
  end
end

def top_right
  @device.reset
  (4..7).each do |x_index|
    (0..3).each do |y_index|
      @device.change :grid, :x => x_index, :y => y_index, :green => :high, :red => :high
    end
  end
end

def bottom_left
  @device.reset
  (0..3).each do |x_index|
    (4..7).each do |y_index|
      @device.change :grid, :x => x_index, :y => y_index, :red => :high
    end
  end
end

def bottom_right
  @device.reset
  (4..7).each do |x_index|
    (4..7).each do |y_index|
      @device.change :grid, :x => x_index, :y => y_index, :green => :low, :red => :medium
    end
  end
end

top_left
sleep 0.5
bottom_right
sleep 0.5
bottom_left
sleep 0.5
top_right
sleep 0.5
top_left
sleep 0.5
bottom_right
sleep 0.5
bottom_left
sleep 0.5
top_right
sleep 0.5
top_left
sleep 0.5
bottom_right
sleep 0.5
bottom_left
sleep 0.5
top_right
sleep 0.5

@device.reset
