require 'json'

class Database
  USERS = {
    1 => { name: 'Dave', band: 'radiohead' },
    2 => { name: 'Mike', band: 'oasis' }
  }
  
  def self.users
    USERS
  end
  
  CONCERTS = {
    1 => { user_id: 1, location: 'Boulder, CO', show: 'stone roses', date: '2019-09-01' },
    2 => { user_id: 1, location: 'Boulder, CO', show: 'daft punk', date: '2019-09-03' },
    3 => { user_id: 2, location: 'San Diego, CA', show: 'Doves', date: '2019-12-03' },
  }
  
  def self.concerts
    CONCERTS
  end

  def self.add_show(data)
      id = CONCERTS.size + 1
      CONCERTS[id] = data
  end
end
