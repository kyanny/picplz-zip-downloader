desc 'debug'
task :debug => :environment do
  Rake::Task['jobs:clear'].invoke
  Pic.destroy_all
  user = User.first
  FileUtils.rm_r("#{Rails.root.join('tmp', 'ex')}",              { :verbose => true, :force => true })
  FileUtils.rm_r("#{Rails.root.join('tmp', user.nickname)}",     { :verbose => true, :force => true })
  FileUtils.rm_r("#{Rails.root.join('tmp', user.nickname)}.zip", { :verbose => true, :force => true })
  user.get_pics_from_picplz
end
