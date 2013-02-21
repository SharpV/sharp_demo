class MeController < ApplicationController
  	def index
      puts "\n ********* " + session[:assets].inspect
  	end
end
