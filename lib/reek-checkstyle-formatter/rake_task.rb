require 'reek/rake/task'
require 'reek-checkstyle-formatter'

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
  t.reek_opts = '-y -n'
end

namespace :reek do
  desc 'Generate checkstyle XML for code smells analyzed by reek.'
  task :checkstyle do
    Reek::CheckstyleFormatter.new({
      :glob_pattern => "#{Dir.pwd}/lib/**/*.rb",
      :output => "#{Dir.pwd}/reek_checkstyle.xml",
      :smell_doc_url => 'https://github.com/troessner/reek/wiki',
    }.merge(Reek::CheckstyleFormatter.rake_task_options)).run
  end
end