class Person < ApplicationRecord
  belongs_to :account
  has_one :raw_data, as: :owner
  has_many :messages
  has_many :sent_messages
  has_many :received_messages
  has_many :updates

  def opener
    sent_messages.first
  end

  def replies
    recieved_messages.where(created_at: open.created_at..followup.created_at)
  end

  def followup
    sent_messages.second
  end

  def opener_text
    'You seem interesting if you want to chat, just say hi.'
  end

  def followup_text
    'Tell me something about yourself.'
  end

  def conversation
    messages.ordered_by(:created_at).map(&:text)
  end
end
