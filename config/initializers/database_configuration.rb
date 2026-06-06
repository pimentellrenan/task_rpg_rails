database_config = YAML.safe_load(
  ERB.new(Rails.root.join("config/database.yml").read).result,
  aliases: true
)

ActiveRecord::Base.configurations = database_config
ActiveRecord::Base.establish_connection(Rails.env.to_sym)
