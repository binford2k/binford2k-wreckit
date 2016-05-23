class wreckit (
  $count    = 1,
  $context  = 'puppet',
  $scenario = undef,
) {
  $logpath   = '/var/spool/wrecked'
  $backups   = '/var/spool/wrecked/backup'

  if $scenario {
    $enforced = $scenario
  } else {
    $available = classes_from_namespace("wreckit::scenario::${context}")
    $enforced  = slice($available, $count)[0]
  }

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  wreckit::wreck { $enforced: }

  file { $logpath:
    ensure  => directory,
  }
  file { $backups:
    ensure  => directory,
  }

  file { "${logpath}/README.md":
    ensure  => file,
    content => template('wreckit/README.md.erb'),
  }

  notify { 'wreckit message':
    message => "Your system is currently being wrecked. Please see ${logpath}/README.md for more information.",
  }
}
