class MenuTabBuilder < TabsOnRails::Tabs::TabsBuilder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = (current_tab?(tab) ? 'active' : '')
    ext = item_options.delete :ext || ""
    @context.content_tag(:li, item_options) do
      	@context.link_to(name, options) + ext
    end
  end
end