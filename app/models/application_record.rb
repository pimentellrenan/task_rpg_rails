class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  establish_connection ENV.fetch("DATABASE_URL", Rails.env.to_sym)
end
