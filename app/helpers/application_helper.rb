#encoding: utf-8
module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end

  def size_by_mode(mode)
    case mode
    when 'm' then 75
    when 'b' then 125
    when 's' then 45
    end
  end

  def user_avatar_tag(user, mode='m')
    if user.avatar and !user.avatar.blank?
      image_tag user.avatar.url(mode), class: 'img-rounded'
    else
      gravatar_image_tag(user.email.gsub('spam', 'mdeering'), :alt => user.nickname, 
        :gravatar => {:size => size_by_mode(mode), default: :identicon }, class: 'img-rounded')
    end
  end


  def avatar_tag(model, mode='m')
     if model.avatar and !model.avatar.blank? 
      image_tag model.avatar.url(mode) 
    else
      gravatar_image_tag('', :gravatar => {:size => size_by_mode(mode)})
    end
  end
  
  def link_to_bookmark(post)
    classes = %w(button bookmark replaceable icon-bookmark-empty)
    link_to '', me_like_path(post),
      { class: classes, remote: true, method: :post, title: 'Bookmark' }
  end
  
  def link_to_unbookmark(post)
    classes = %w(button bookmark replaceable icon-bookmark)
    link_to '', account_bookmark_path(post),
      { class: classes, remote: true, method: :delete, title: 'Unbookmark' }
  end
  
  def link_to_collect(post)
    classes = %w(button observe replaceable icon-eye-close)
    link_to "", me_collection_path(post),
      { class: classes, remote: true, method: :post, title: 'Observe' }
  end
  
  def link_to_unobserve(post)
    classes = %w(button observe replaceable icon-eye-open)
    link_to "", account_observe_path(post),
      { class: classes, remote: true, method: :delete, title: 'Unobserve' }
  end
  
  def link_to_like(post)
    classes = %w(like button replaceable)
    link_to %{<span>#{post.likes_count}</span> <i class="icon-heart-empty"></i>}.html_safe, me_likes_path(:post_id => post.id), class: classes, remote: true, method: :post, title: 'Like post :)'
  end
  
  def link_to_unlike(post)
    classes = %w(like button replaceable)
    link_to %{<span>#{post.likes_count}</span> <i class="icon-heart"></i>}.html_safe, me_likes_path(:post_id => post.id), method: :delete, remote: true, class: classes, title: 'Unlike post'
  end
  
  def link_to_subscribe(tag, options = {})
    default_options = {
      method:    :post,
      class:     %w(button subscribe replaceable),
      :remote    => true,
      :'data-id' => tag.id
    }
    options = default_options.merge(options)
    if options[:onoff]
      name = options[:method] == :post ? 'Subscribe' : 'Subscribed'
    else
      name = tag.name
    end
    link_to name, account_subscribe_path(tag, :onoff => options[:onoff]),
      options
  end
  
  def link_to_unsubscribe(tag, options = {})
    default_options = {
      class: 'button subscribe replaceable active',
      method: :delete
    }
    link_to_subscribe(tag, default_options.merge(options))
  end
  
  def link_to_follow(user, name = 'Follow', method = :post)
    link_to name, account_follow_path(user),
      { :remote    => true,
        :method    => method,
        :class     => 'button follow replaceable',
        :'data-id' => user.id }
  end
  
  def link_to_unfollow(user)
    link_to_follow user, 'Unfollow', :delete
  end
  
  def link_to_tag(tag)
    link_to tag.with_sign, tag
  end
  
  def link_to_comments(post)
    link_to '', post, class: 'button comment', title: 'Comments'
  end
end
