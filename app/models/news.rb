class News < ApplicationRecord
	attr_accessor :top_until_time
	
	validates :title, presence: true
	validates :text,  presence: true
	
	scope :last_admin_top,        -> {where('(is_top IS TRUE)').order('top_until desc NULLS LAST, pub_time desc')}
	scope :last_admin_top_active, -> {last_admin_top.where('(top_until IS NOT NULL) AND (top_until >= CURRENT_TIMESTAMP)')}
	scope :last_feed,             -> {where(is_top: false).order('pub_time desc')}
	
	
	def attributes
		super.merge({'top_until_time' => top_until_time})
	end
end
