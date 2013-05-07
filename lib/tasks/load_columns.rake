#encoding: utf-8 

namespace :db do
  namespace :columns do
    task :load => :environment do
      load_columns   
    end

    def load_columns
      ['课程教学', '教育随笔', '师生园地', '学前教育', '外语教育', '师生园地', '心灵港湾', '走向名师', 
      '教育活动', '教育动态', '学习生活', '学校管理', '班级管理', '读书笔记', '旅游摄影',
      '琴棋书画', '信息技术', '站务讨论'].each_with_index do |name, index|
        column = Column.new name: name, position: index
        if column.save
          puts "create column #{column.name}"
        end
      end
    end
  end
end
