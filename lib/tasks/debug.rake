desc 'debug'
task :debug => :environment do
  Archive.connect_to_s3
  Rake::Task['jobs:clear'].invoke
  Pic.destroy_all
  Archive.destroy_all
  user = User.first
  FileUtils.rm_r("#{Rails.root.join('tmp', 'ex')}",              { :verbose => true, :force => true })
  FileUtils.rm_r("#{Rails.root.join('tmp', user.nickname)}",     { :verbose => true, :force => true })
  FileUtils.rm_r("#{Rails.root.join('tmp', user.nickname)}.zip", { :verbose => true, :force => true })
  archive = Archive.create!(:user_id => user.id)
  archive.delay.archive
end
