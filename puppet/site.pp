File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}

node default {
  include awstats
  include base
  include exim-conf
  include logrotate
  include mailman-conf
  include mariadb
  include memcached
  include nginx
  include php
  include puppet
  include ssh-conf
  include sudo
  include translationmemory
  include users
  include composer
  include hhvm

  class { 'backup':
    databases => ['translatewiki_net'],
  }

  class { 'wiki':
    config => '/home/betawiki/config',
    user   => 'betawiki',
  }

  package { 'elasticsearch':
    provider => dpkg,
    ensure => latest,
    source => '/root/packages/elasticsearch-0.90.3.deb'
  }
}
