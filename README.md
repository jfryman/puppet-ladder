puppet-ladder
=============

Automated Manifest Loading based on Facts

## What is this?

In today's Puppet world, everything is a hierarchy. Hiera is a hierarchy. The DAG of a catalog is a hierarchy. However, in the declarative language of Puppet, we have flow control. This can, and often does, result in classes that are mired in `if...then...else` blocks that make it next to impossible to modify.

It's possible to wire this up with good design and to keep things in isolated classes, but who wants to do that? Most people just rant that this is simply unacceptable.

Enter: Ladder!

## How does it work?

- Create a stack in $PUPPET_ROOT/stacks. Give it some load paths based on facts you want class autoloading to happen on.

```yaml
---
:base: frimante::platform
:hierarchy:
  - platform/%{::virtual}
  - platform/%{::productname}
  - platform/%{::operatingsystem}
  - platform/%{::operatingsystem}/%{::lsbdistcodename}
  - platform/%{::cloud}
  - platform/%{::datacenter}
  - platform/%{::datacenter}/%{::operatingsystem}
  - platform/%{::datacenter}/%{::operatingsystem}/%{::lsbdistcodename}

```

- Load up the stack.

```puppet
  ladder { ‘frimante::platform’: }
```

- Bask in all the goodness that is Ladder. (and :moneybag:s)
