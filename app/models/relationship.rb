class Relationship < ApplicationRecord

  belongs_to :following, class_name: "User"
  belongs_to :be_followed, class_name: "User"
  

end
