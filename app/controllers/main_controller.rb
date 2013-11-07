class MainController < ApplicationController
	def about_us
		# Here is where we go to the DB and get a lit of forbidden words
		@words = ["Forking", "Dongle", "Stuff"]
		@my_name = "Amy"
		@color = "red"
	end

	def contact_us
	end

	def tos
	end

	def our_team
	end 

	def vision
	end
	
end