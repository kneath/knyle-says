$LOAD_PATH.unshift File.expand_path("..", __FILE__)

require 'launchpad'
require 'game/easy'
require 'game/intro'

module Game
  def self.interaction
    @interaction ||= Launchpad::Interaction.new
  end
end
