module ControllerMacros
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:admin)
    @current_user = admin
    sign_in admin
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    @current_user = user
    sign_in user
  end
end