require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('splunk') do
  it { should be_enabled }
#  it { should be_running }
end

describe process("splunkd") do
  its(:user) { should eq "_splunk" }
  its(:args) { should match /-p 8089 restart \[process-runner\]/ }
end

describe port(8000) do
  it { should be_listening }
end
describe port(8089) do
  it { should be_listening }
end
describe port(9997) do
  it { should be_listening }
end
