class Resumesection < ActiveRecord::Base

	attr_accessible :resumeid, :sectionid, :ordernum
	
	belongs_to :resume, :class_name => 'Resume', :foreign_key => 'resumeid'
	belongs_to :section, :class_name => 'Section', :foreign_key => 'sectionid'
	
	
	validates :resumeid, :presence => true
	validates :sectionid, :presence => true
	validates :ordernum, :presence => true
	
	
	def self.search(search)
	  if search
		find(:all, :conditions => ['name ILIKE ?', "%#{search}%"]) #Set ILIKE for Heroku to make case-insensitive
																	#LIKE for git
	  else
		find(:all)
	  end
	end
	
end




# == Schema Information
#
# Table name: resumesections
#
#  id         :integer         not null, primary key
#  resumeid   :integer
#  sectionid  :integer
#  orderNum   :integer
#  created_at :datetime
#  updated_at :datetime
#

