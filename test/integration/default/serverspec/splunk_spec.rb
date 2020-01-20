require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('splunkd') do
  it { should be_enabled }
  it { should be_running }
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
