module Webclass::MessagesHelper

  def select_members(role)
    @current_webclass.group_members(role).collect{|m|"'#{m.user_id}'"}.join(",")
  end
end
