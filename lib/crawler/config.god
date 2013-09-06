BootFile = File.expand_path("boot.rb", File.dirname(__FILE__))

God.watch do |w|
  w.name = "crawler"
  w.start = "ruby #{BootFile}"
end
