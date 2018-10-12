class Post < ApplicationRecord
  belongs_to :category, optional: true

  accepts_nested_attributes_for(:category, update_only: true)
  has_many :comments, dependent: :destroy

  state_machine :state, initial: :created do
    state :created
    state :on_moderation
    state :published

    event :send_to_moderation do
      transition created: :on_moderation
    end

    event :send_to_published do
      transition on_moderation: :published
    end

    state :published do
      validates_presence_of :link
      validates_presence_of :category_id
    end
  end
end
