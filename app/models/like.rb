class Like < ApplicationRecord
    belongs_to :drink
    belongs_to :user

    validates_uniqueness_of :drink_id, scope: :user_id

end
