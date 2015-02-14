class OutbreakPlace < ActiveRecord::Base

  belongs_to :outbreak
  belongs_to :place
end
