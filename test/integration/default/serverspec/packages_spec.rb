require 'serverspec'

# Required by serverspec
set :backend, :exec

pkg_list1804 = [ 'zeek', 'tomcat8', 'suricata' ]
pkg_list1604 = [ 'bro', 'tomcat7', 'suricata' ]

for p in pkg_list do
    describe package("#{p}"), :if => os[:family] == 'ubuntu' || os[:family] == 'debian'  do
      it { should be_installed }
    end
end

