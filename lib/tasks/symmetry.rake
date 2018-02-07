# encoding: UTF-8
desc "Setup test db and run tests"
task runtests: :environment do
  #Rake::Task['app:db:create'].execute
  #Rake::Task['app:db:migrate'].execute
  #Rake::Task['app:db:test:prepare'].execute
  Rake::Task['app:test:db'].execute
  Rake::Task['app:db:schema:load'].execute
  Rake::Task['spec'].execute
end
