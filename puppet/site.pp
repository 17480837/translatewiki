File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

# web1 / Primary web server
node 'translatewiki.net' {
  include base
  include puppet
  include sshd
  include sudo
  include users

  include awstats
  include base::web1
  include hhvm
  include logrotate
  include mariadb
  include memcached
  include nginx::sites

  include eximconf
  include eximconf::web1
  include mailmanconf

  include kitanonl

  class { 'backup':
    databases => ['translatewiki_net'],
  }

  class { 'wiki':
    config => '/home/betawiki/config',
    user   => 'betawiki',
  }

  sysctl { 'net.ipv4.tcp_window_scaling': value => '1' }
  sysctl { 'net.ipv4.tcp_slow_start_after_idle': value => '0' }
  sysctl { 'net.ipv4.tcp_fastopen': value => '3' }
}

# es / Elastic Search
node 'v220150764426371.yourvserver.net' {
  include base
  include puppet
  include sshd
  include sudo
  include users

  include base::es
  include eximconf
  include eximconf::es
  include profile::mwelasticsearch
}
