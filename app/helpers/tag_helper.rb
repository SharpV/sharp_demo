module TagHelper
  def linked_tag_list(tags, type="all")
    raw tags.collect {|tag| link_to(tag.name, tag_path(tag.name, :type=>type), :class=>'tag')}.join(" ")
  end
end
