module Group::MessagesHelper

  def select_members(role)
    @current_group.group_members(role).collect{|m|"'#{m.user_id}'"}.join(",")
  end
end
