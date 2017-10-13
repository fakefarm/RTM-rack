require 'json'
class ConcertsApplication
  def call(env)
    request = Rack::Request.new(env)
    if env["PATH_INFO"] == ""
      if request.post?
        show = JSON.parse(request.body.read)
        Database.add_show(show)
        [200, {}, ['ROCK ON']]
      else
        [200, {}, [Database.concerts.to_s]]
      end
    elsif env["PATH_INFO"] =~ %r{/\d+}
      id = env["PATH_INFO"].split('/').last.to_i
      [200, {}, [ Database.concerts[id].to_s ]]
    else
      [404, {}, ['SOLD OUT.']]
    end
  end
end
