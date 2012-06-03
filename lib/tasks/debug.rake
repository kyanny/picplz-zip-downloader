desc 'debug'
task :debug => :environment do
  Rake::Task['jobs:clear'].invoke
  Pic.destroy_all
  user = User.first
  user.get_pics_from_picplz
end
