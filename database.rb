class Database
  USERS = {
    1 => { name: 'Dave', band: 'radiohead' },
    2 => { name: 'Mike', band: 'oasis' }
  }
  
  def self.users
    USERS
  end
end
