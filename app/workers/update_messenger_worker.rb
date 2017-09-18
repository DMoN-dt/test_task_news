require 'sidekiq'

class UpdateMessengerWorker
	include Sidekiq::Worker
	
	def perform()
		NewsUpdatesChannel.broadcast_to "messages", "updated"
	end
end