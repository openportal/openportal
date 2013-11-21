class WelcomeController < ApplicationController
  def index
    if current_user
      return render(template: 'welcome/user_home')
    end
  end
end
