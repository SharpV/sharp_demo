class My::PasswordsController < Devise::PasswordsController
  set_tab :home, :site_menus
  layout "my"
end
