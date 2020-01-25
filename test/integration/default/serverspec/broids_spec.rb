require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('bro'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('bro'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_installed }
end
describe package('zeek'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  it { should be_installed }
end

describe process('bro'), :if => os[:family] == 'redhat' || (os[:family] == 'ubuntu' && os[:release] == '16.04') do
  it { should be_running }
  it "is listening on port 47760" do
    expect(port(47760)).to be_listening
  end
end
describe process('zeek'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  it { should be_running }
  it "is listening on port 47760" do
    expect(port(47760)).to be_listening
  end
end

describe file('/var/log/bro/current/stderr.log'), :if => os[:family] == 'redhat' || (os[:family] == 'ubuntu' && os[:release] == '16.04') do
  its(:size) { should > 0 }
  its(:content) { should match /listening on/ }
end
describe file('/var/log/bro/current/conn.log'), :if => os[:family] == 'redhat' || (os[:family] == 'ubuntu' && os[:release] == '16.04') do
  its(:size) { should > 0 }
end
describe file('/var/log/zeek/current/stderr.log'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  its(:size) { should > 0 }
  its(:content) { should match /listening on/ }
end
describe file('/var/log/zeek/current/conn.log'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  its(:size) { should > 0 }
end
