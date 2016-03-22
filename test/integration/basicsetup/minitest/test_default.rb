require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::JUnitReporter.new(reports_dir="/tmp/result/junit")]

describe 'check R version' do

  it "check R version" do
    system('echo "q()" > /tmp/showversion.R')
    system('R CMD BATCH /tmp/showversion.R')
    assert system('grep "R version 3.2.4" showversion.Rout'), 'R version is not expected version. patched version is updated'
  end
  it "check R library version" do
    system('echo "library()" > /tmp/showlibrary.R')
    system('R CMD BATCH /tmp/showlibrary.R')
    assert system('grep "^dplyr" showlibrary.Rout'), 'dplyr must be installed'
    assert system('grep "^rglwidget" showlibrary.Rout'), 'rglwidget must be installed'
  end
end
describe 'check galaxy venv library' do
  it "check galaxy user" do
    system("su -l galaxy -c 'source /usr/local/galaxy/galaxy-dist/.venv/bin/activate; pip list > /tmp/galaxy.venv.pip.list'")
    assert system('grep "^GitPython" /tmp/galaxy.venv.pip.list'), 'GitPython must be installed in .venv'
    assert system('grep "^bioblend" /tmp/galaxy.venv.pip.list'), 'GitPython must be installed in .venv'
  end
end
