class Event < Crabfarm::BaseStruct

  has_string :title
  has_string :link
  has_string :location
  has_string :date
  has_field :attendance
  has_string :image_url

end
