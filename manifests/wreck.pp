define wreckit::wreck {
  $scenario = regsubst($title, '^wreckit::scenario::([^:]+)::', '\1_')

  unless $scenario in $::wrecked {
    include $title

    $description = getvar("${title}::description")
    $recovery    = getvar("${title}::recovery")
    $backup      = getvar("${title}::backup")
    $urls        = getvar("${title}::urls")

    file { "${wreckit::logpath}/${scenario}.wreck":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('wreckit/log.erb'),
    }
  }

}