class Resumesection < ActiveRecord::Base

	attr_accessible :resumeid, :sectionid, :ordernum
	
	belongs_to :resume
	belongs_to :section, :class_name => 'Section', :foreign_key => 'sectionid'
	
	
	validates :resumeid, :presence => true
	validates :sectionid, :presence => true
	validates :ordernum, :presence => true
	
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

