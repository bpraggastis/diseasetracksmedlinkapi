class Outbreak < ActiveRecord::Base

  # an outbreak is defined as a collection of events with
  # a common concern: mosquito born, under-vaccination, ebola

  has_many :events

end
