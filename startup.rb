require 'launchpad'

delay = 0.075

device = Launchpad::Device.new
device.reset
sleep 2.0

(0..7).each do |index|
  device.change :grid, :x => index, :y => 0, :red => :high
  sleep delay
  device.change :grid, :x => index, :y => 0, :red => :off
end

(0..7).each do |index|
  device.change :grid, :x => 7, :y => index, :red => :high
  sleep delay
  device.change :grid, :x => 7, :y => index, :red => :off
end

(0..7).each do |index|
  device.change :grid, :x => 7 - index, :y => 7, :red => :high
  sleep delay
  device.change :grid, :x => 7 - index, :y => 7, :red => :off
end

(0..7).each do |index|
  device.change :grid, :x => 0, :y => 7 - index, :red => :high
  sleep delay
  device.change :grid, :x => 0, :y => 7 - index, :red => :off
end

# HI
sleep 0.5
device.change :grid, :x => 0, :y => 1, :green => :high, :red => :high
device.change :grid, :x => 0, :y => 2, :green => :high, :red => :high
device.change :grid, :x => 0, :y => 3, :green => :high, :red => :high
device.change :grid, :x => 1, :y => 2, :green => :high, :red => :high
device.change :grid, :x => 2, :y => 1, :green => :high, :red => :high
device.change :grid, :x => 2, :y => 2, :green => :high, :red => :high
device.change :grid, :x => 2, :y => 3, :green => :high, :red => :high

device.change :grid, :x => 5, :y => 1, :green => :high, :red => :high
device.change :grid, :x => 6, :y => 1, :green => :high, :red => :high
device.change :grid, :x => 7, :y => 1, :green => :high, :red => :high
device.change :grid, :x => 6, :y => 2, :green => :high, :red => :high
device.change :grid, :x => 6, :y => 2, :green => :high, :red => :high
device.change :grid, :x => 5, :y => 3, :green => :high, :red => :high
device.change :grid, :x => 6, :y => 3, :green => :high, :red => :high
device.change :grid, :x => 7, :y => 3, :green => :high, :red => :high

# Start Square
sleep 0.5
device.flashing_auto
device.change :grid, :x => 2, :y => 5, :green => :high, :mode => :flashing
device.change :grid, :x => 3, :y => 5, :green => :high, :mode => :flashing
device.change :grid, :x => 4, :y => 5, :green => :high, :mode => :flashing
device.change :grid, :x => 5, :y => 5, :green => :high, :mode => :flashing
device.change :grid, :x => 2, :y => 6, :green => :high, :mode => :flashing
device.change :grid, :x => 3, :y => 6, :green => :high, :mode => :flashing
device.change :grid, :x => 4, :y => 6, :green => :high, :mode => :flashing
device.change :grid, :x => 5, :y => 6, :green => :high, :mode => :flashing


sleep 1
