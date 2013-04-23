module TagHelper
  def linked_tag_list(tags, type="all")
    raw tags.collect {|tag| link_to(tag.name, tag_path(tag.name, :type=>type), :class=>'tag')}.join(" ")
  end

  def post_tags(tags)
    tags.collect{|tag|"'#{tag.name}'"}.join(",")
  end
end
