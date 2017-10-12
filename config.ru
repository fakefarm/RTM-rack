class Application
  def call(env)
    [200, {}, ["my first Rack App!"]]
  end
end

run Application.new
