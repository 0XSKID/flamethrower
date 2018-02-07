class ProcessUpdatesWorker
  include Sidekiq::Worker

  attr_reader :update

  def perform(update_id)
    @update = Update.find(update_id)

    update['matches'].each do |match|
      process(match)
    end
  end

  private

  def process(match)
    return if match['person'].nil?

    person = Person.includes(:messages).find_by(tinder_id: match['person']['_id'])
    existing_message_ids = person.messages.map(&:tinder_id)

    match['messages'].each do |message|
      next if existing_message_ids.include?(message['_id'])
      message = Message.build_from(message)
      message.save
    end

    CheckPersonsTypeWorker.perform_async(person.id)
  end
end
