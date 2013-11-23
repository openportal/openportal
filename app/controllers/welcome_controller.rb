class WelcomeController < ApplicationController
  def index
  	@debug = ENV["CLIENT_ID"]
  	@issues_from_site = JSON.parse(RestClient.get("https://api.github.com/repos/rails/rails/issues?client_id=#{ENV["CLIENT_ID"]}&client_secret=#{ENV["CLIENT_SECRET"]}"))

    if current_user
      return render(template: 'welcome/user_home')
    end
  end
end
