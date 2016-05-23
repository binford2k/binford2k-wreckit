# binford2k-wreckit

Most modules are designed to configure things. This one is designed to break them.

1. [Overview](#overview)
1. [Usage](#usage)
1. [Contributing](#contributing)

## Overview

This module is intended as a learning tool. It will allow the victim, I mean user,
to identify, troubleshoot, and recover from known error cases. The experience will
help build troubleshooting skills and practice recovery from disaster.

This is designed to apply a random subset of a curated list of misconfigurations
on the node it's enforced on. You should select how many scenarios you want to be
applied, and what context to choose from. By default, it will apply a single
randomly chosen scenario having to do with Puppet.

If you have successfully recovered from a scenario, and you'd like to attempt
another challenge, simply increment the count number. It defaults to `1`, so bump
it to `2` when you're ready for another.

## Usage

Default usage:

```
include wreckit
```

Specify parameters:

```puppet
class { 'wreckit':
  count   => 3,
  context => 'puppet',
}
```

You can also specify which scenario(s) you want to be applied:

```puppet
class { 'wreckit':
  scenario => 'wreckit::scenario::puppet::server',
}
```

```puppet
class { 'wreckit':
  scenario => ['wreckit::scenario::puppet::server', 'wreckit::scenario::puppet::ssl'],
}
```

Apply the `examples/available_scenarios.pp` manifest to see what scenarios you can choose from.


## Contributing

This will be most fun if community members contribute some misconfiguration scenarios.
Simply submit a pull request with a new `wreckit::scenario::<context>::<something>`
class. The default context is `puppet`, but you're free to create any other context
you like. For example, you may want to create a `network` context with scenarios to
remote the default route or set an invalid DNS server or the like.

To be accepted, your class should:

* Not make any changes that are irretrievable. If you destroy files, you should
  always back them up first. The `$wreckit::backups` variable is defined as the
  backup root. You should create files and directories under it for backup purposes.
* Be enforceable in a single run. **Your class will only be enforced once**.

Your class should set the following variables for documentation:

* Define a `$description` variable with information about the misconfiguration and
  why it's significant, or why it's commonly seen, etc.
* Define a `$recovery` variable with instructions on recovering from whatever
  shenanigans your class pulled.
* Define a `$backup` variable with information about any files that you backed up
  before mucking with them. Set to `undef` if you don't use this variable.
* Define a `$urls` variable with any URLs the end user can visit for more information
  about whatever your misconfiguration was. Set to `undef` if you don't use this variable.

See the existing scenarios for examples.


## Disclaimer

I take no liability for the use of this module. It's in early stages of development.

Contact
-------

binford2k@gmail.com

