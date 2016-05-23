class wreckit::scenario::puppet::server {
  $description = "The server setting in `puppet.conf` has been wrecked. It has been changed to point to a non-existant server."
  $recovery    = "You should correct puppet.conf to point `server` in the `agent` section back to ${servername}."
  $backup      = undef
  $urls        = ['https://docs.puppet.com/puppet/latest/reference/configuration.html#server']

  ini_setting { 'wreckit: server':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'agent',
    setting => 'server',
    value   => shuffle($servername),
  }
}
