require 'sidekiq'
require 'rss'
require 'open-uri'

class RssFeedWorker
	include Sidekiq::Worker
	
	def perform()
		feed_item = nil
		
		begin
			open('https://news.yandex.ru/world.rss') do |rss|
				@feed = RSS::Parser.parse(rss)
				feed_item = @feed.items.first
			end
		rescue
			logger.fatal('Unable to open Yandex RSS')
		end
		
		if(feed_item.present?)
			news = News.where(is_top: false).first
			feed_item_guid_hash = XXhash.xxh32(feed_item.guid.to_json)
			
			if(news.blank? or news.guid_hash.blank? or (feed_item_guid_hash != news.guid_hash))
				news_update = {
					title: feed_item.title,
					text: feed_item.description,
					url: feed_item.link,
					pub_time: feed_item.pubDate,
					guid_hash: feed_item_guid_hash,
					is_top: false,
				}
				
				if(news.present?)
					news.assign_attributes(news_update)
					changed = news.changed?
					news.save if(changed)
				else
					news = News.create(news_update)
					changed = news.present?
				end
				
				if(changed && News.last_admin_top_active.first.blank?)
					NewsUpdatesChannel.broadcast_to "messages", "updated"
				end
			end
		end
	end
end