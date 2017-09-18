class NewsController < ApplicationController
	
	# Вывод актуальной новости
	def show
		@news = News.last_admin_top_active.first
		if(@news.present?)
			@news.top_until_time = @news.top_until.to_formatted_s(:input_datestr)
		else
			@news = News.last_feed.first
		end
		
		render json: @news, status: ((@news.present?) ? :ok : :not_found)
	end
	
	
	# Получение Авторской новости для редактирования
	def admin_news_get
		@news = News.last_admin_top.first
		if(@news.present?)
			@news.top_until_time = in_tz_offset(@news.top_until.to_s, params[:tz_offset], false, false)[:time]
			render json: @news.to_json #(:methods => [:top_until_time])
		else
			render json: {}
		end
	end
	
	
	# Обновление Авторской новости
	def admin_news_set
		pparams = params.require(:news).permit(:title, :text, :top_until)
		pparams[:top_until] = in_tz_offset(pparams[:top_until], params[:tz_offset], true)[:time]

		@news = News.where(is_top: true).first
		if(@news.present?)
			@news.assign_attributes(pparams)
			changed = @news.changed?
			if(changed)
				@news.pub_time = Time.now
				@news.save
			end
		else
			pparams[:is_top] = true
			pparams[:pub_time] = Time.now
			@news = News.create(pparams)
			changed = @news.present?
		end
		
		if(changed)
			NewsUpdatesChannel.broadcast_to "messages", "updated"
			
			render json: {'status': 'ok'}, status: :ok

			UpdateMessengerWorker.perform_at(@news.top_until) if(@news.top_until.utc > Time.now.utc)
			
		else
			render json: {'status': 'no_changes'}, status: :ok
		end
	end
	
	
	private
	
	
	def in_tz_offset (date_time_str, tz_offset, offset_exclude = false, format_w_tz = true)
		if(tz_offset.present?)
			tz_offset = tz_offset.to_i * (-60)
			
			visitor_zone_name = ActiveSupport::TimeZone::MAPPING.keys.find do |name|
				ActiveSupport::TimeZone[name].utc_offset == tz_offset
			end
			
			if(visitor_zone_name.present?)
				if(date_time_str.gsub(/\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}(:\d{2})?(\.\d{3,6})?(([\+\-])(\d{2}:\d{2}))?\z/).present?)
					begin
						tz_datetime = date_time_str.to_datetime.in_time_zone(visitor_zone_name)
						tz_datetime -= tz_offset if(offset_exclude)
						date_time_str = tz_datetime.strftime(format_w_tz ? "%FT%T.%L%:z" : "%FT%T.%L")
					rescue ArgumentError
						nil
					end
				end
			end
		else
			visitor_zone_name = nil
		end
		
		return {:time => date_time_str, :tz_name => visitor_zone_name.to_s}
	end
	
end
