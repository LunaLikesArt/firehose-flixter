class User < ActiveRecord::Base
	has_many :courses
	has_many :enrollments
	has_many :enrolled_courses, through: :enrollments, source: :course
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable


	# Version 1 (Array 'include' method)
	# def enrolled_in?(course)
	# 	enrolled_courses = []
	# 	enrollments.each do |enrollment|
	# 		enrolled_courses << enrollment.course
	# 	end
	# 	return enrolled_courses.include?(course)
	# end

	# Version 2 (Array 'collect' method)
	# 	def enrolled_in?(course)
	# 		enrolled_courses = enrollments.collect do |enrollment|
	# 			enrollment.course
	# 		end
	#
	# 		return enrolled_courses.include?(course)
	# 	end

	# Version 3 (N+1 Query)
	# def enrolled_in?(course)
	# 	enrolled_courses = enrollments.collect(&:course)
	# 	return enrolled_courses.include?(course)
	# end

	# Version 4 (has_many :through relationship)
	def enrolled_in?(course)
		return enrolled_courses.include?(course)
	end

end
