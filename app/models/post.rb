class Post < ApplicationRecord
  belongs_to :category

  accepts_nested_attributes_for(:category, update_only: true)
  has_many :comments, dependent: :destroy

  state_machine :state, initial: :create do
    state :moderator
    state :publish

    event :moderator do
      transition create: :moderator
    end

    event :publish do
      transition moderator: :publish
    end

    state :publish do
      validates_presence_of :link
      validates_presence_of :category_id
    end
  end
end

# create
# moderator
# publish