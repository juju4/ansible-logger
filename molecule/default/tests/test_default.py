import os

import testinfra.utils.ansible_runner

import pytest

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'


@pytest.mark.parametrize("filename,filemode,user", [
    ("/etc/kolide/kolide.yml", 0o644, "root"),
    ("/usr/local/bin/fleet", 0o755, "root"),
    ("/opt/zeek/etc/zeekctl.cfg", 0o664, "root"),
    ("/opt/zeek/bin/zeek", 0o755, "root"),
    ("/opt/splunk/etc/system/local/user-prefs.conf", 0o600, "_splunk"),
    ("/opt/splunk/bin/splunk", 0o555, "_splunk"),
    ("/etc/tomcat8/server.xml", 0o640, "root"),
    ("/usr/local/sbin/guacd", 0o755, "root"),
])
def test_files(host, filename, filemode, user):
    f = host.file(filename)
    assert f.exists
    assert f.user == user
    assert f.mode == filemode


@pytest.mark.parametrize("comm,user", [
    ("splunkd", "_splunk"),
    ("mongod", "_splunk"),
    ("mysqld", "mysql"),
    ("redis-server", "redis"),
    ("java", "tomcat8"),
    ("guacd", "root"),
    ("zeek", "root"),
    ("fleet", "_kolide"),
])
def test_processes(host, comm, user):
    p = host.process.filter(user=user, comm=comm)
    assert p.exists
    assert p.user == user
