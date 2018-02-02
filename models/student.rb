require "active_record"
require "yaml"

db_config_file = File.read("db/config.yml")
db_config = YAML::load(db_config_file)

ActiveRecord::Base.establish_connection(db_config)

class Student < ActiveRecord::Base
end
