load 'devsupport/tasks/setup.rb'
ds_tasks_for :hoe

ds_configure do |c|
  c.program_name = 'wally'
  c.yard_options = [ ]
end

projectname = ds_env.program_name
load File.join(File.dirname(__FILE__), 'lib', projectname, 'version.rb')

# @see README.md

ds_hoe_spec(projectname) do |spec|
  spec.developer "Marian Eichholz", "marian.eichholz@freenet.ag"
  spec.extra_deps << ['netaddr']
  spec.extra_deps << ['gli']
end

# glue tasks
Rake::Task[:default].clear
task :default => 'run:gui'

namespace :run do
  @testconfig = ""
  # construct rake tasks for each command
  %w(
    version gui 
  ).each do |command|
    desc "Command: #{command}"
    task command do |t|
      command = t.to_s.gsub(/^.*:/,"")
      sh "bundle exec #{ds_env.frontend} #{@testconfig} -v #{command}"
    end
  end

end

