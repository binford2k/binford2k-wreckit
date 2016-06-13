class wreckit::scenario::puppet::vim_pollution {
  $description = "Vim users have this tendency to leave the string `:wq` littered around..."
  $recovery    = "You should remove `:wq` from puppet.conf."
  $backup      = undef
  $urls        = undef

  file_line { 'vim pollution':
    ensure => present,
    path   => '/etc/puppetlabs/puppet/puppet.conf',
    line   => 'pluginsync = true:wq',
    match  => 'pluginsync',
  }

}
