require 'serverspec'

# Required by serverspec
set :backend, :exec

pkg_list1804 = [ 'zeek', 'tomcat8', 'suricata' ]
pkg_list1604 = [ 'bro', 'tomcat7', 'suricata' ]

if (os[:family] == 'ubuntu' && os[:release] == '16.04')
  pkg_list = pkg_list1604
elsif (os[:family] == 'ubuntu' && os[:release] == '18.04')
  pkg_list = pkg_list1804
end

for p in pkg_list do
    describe package("#{p}") do
      it { should be_installed }
    end
end
