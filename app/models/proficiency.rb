class Proficiency < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :skill
  belongs_to :user

  validates_inclusion_of :formal?, :in => [true, false]
end
