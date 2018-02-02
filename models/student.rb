require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/dev.db",
)

class Student < ActiveRecord::Base
end
