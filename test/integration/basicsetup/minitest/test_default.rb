require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::JUnitReporter.new(reports_dir="/tmp/result/junit")]

#def user_command(user, cmd)
#  command("su -l #{user} -c '#{cmd}'")
#end
#describe user_command("galaxy", 'source galaxy-dist/.venv/bin/activate;pip list') do
#  its(:stdout) { should match /system/ }
#end

describe 'check R version' do

  it "check R version" do
    system('echo "q()" > /tmp/showversion.R')
    system('R CMD BATCH /tmp/showversion.R')
    #assert system('grep "R version 3.2.3 Patched" showversion.Rout'), 'R version is not expected version. patched version is updated'
    #assert system('grep "R version 3.2.3 Patched" showversion.Rout'), 'R version is not expected version. patched version is updated'
  end
  it "check R library version" do
    system('echo "library()" > /tmp/showlibrary.R')
    system('R CMD BATCH /tmp/showlibrary.R')
    assert system('grep "^dplyr" showlibrary.Rout'), 'dplyr must be installed'
    assert system('grep "^rglwidget" showlibrary.Rout'), 'rglwidget must be installed'
  end
end
