class ConcertsApplication
  def call(env)
    if env["PATH_INFO"] == '/'
      [200, {}, [Database.concerts.to_s]]
    elsif env["PATH_INFO"] =~ %r{/\d+}
      id = env["PATH_INFO"].split('/').last.to_i
      [200, {}, [ Database.concerts[id].to_s ]]
    else
      [404, {}, ['SOLD OUT.']]
    end
  end
end
