set :output, "#{path}/log/cron.log"
set :environment, "development"

 every 5.minutes do
	runner "User.when_birthday"
end

# crontab -l
# whenever --update-crontab
# bundle exec wheneverize
# bundle exec whenever --clear-crontab



# every 1.minute do
# 	runner "FirstJob.perform"
# end



# every  1.days, at: "3:00 AM" do
# 	runner "User.bd"
# end



# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
