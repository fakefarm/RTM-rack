# This file should only contain initialization, setup, and routing code

require_relative 'UsersApplication'
require_relative 'ConcertsApplication'
require_relative 'database'

map("/users") do
  run UsersApplication.new
end

map("/concerts") do
  run ConcertsApplication.new
end
