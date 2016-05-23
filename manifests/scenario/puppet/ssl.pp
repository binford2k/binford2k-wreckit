class wreckit::scenario::puppet::ssl {
  $description = "Puppet's SSL directory has been removed. The agent will generate new certificates,
but then they won't match what's on the server.

The first thing the agent does when it starts a run is to check to see if it's
got SSL certificates. If not, it will generate certificates and make a signing
request to the master. If it's already done this, though, the agent will just
attempt to continue with its run. If the master already has a CSR or a signed
certificate for that node, then there will be a mismatch and the agent will
display the error message you've probably already witnessed."

  $recovery    = "Recovering is simplest if you're enforcing this on an-only agent node. You or your
administrator will need to remove this node's certificates on the master using:

    root@master:~ # puppet cert clean ${::clientcert}

Then remove the ssldir on the agent and run again:

    root@agent:~ # rm -rf $(puppet agent --configprint ssldir)
    root@agent:~ # puppet agent -t

If you've enforced on a master node, you should refer to the instructions in the
linked pages for help. A guide for a monolithic PE master and one for an open
Puppet master are included."

  $backup      = "The existing SSL directory has been backed up to ${wreckit::backups}/ssldir"
  $urls        = [
    'https://docs.puppet.com/pe/latest/agent_cert_regen.html',
    'https://docs.puppet.com/pe/latest/trouble_regenerate_certs_monolithic.html',
    'https://docs.puppet.com/puppet/4.5/reference/ssl_regenerate_certificates.html',
    ]

  file { "${wreckit::backups}/ssldir":
    ensure  => directory,
    source  => '/etc/puppetlabs/puppet/ssl',
    recurse => true,
  }

  file { '/etc/puppetlabs/puppet/ssl':
    ensure  => absent,
    force   => true,
    require => File["${wreckit::backups}/ssldir"],
  }
}
