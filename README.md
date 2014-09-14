puppet-ladder
=============

Automated Manifest Loading based on Facts

## What is this?

In today's Puppet world, everything is a hierarchy. Hiera is a hierarchy. The DAG of a catalog is a hierarchy. However, in the declarative language of Puppet, we have flow control. This can, and often does, result in classes that are mired in `if...then...else` blocks that make it next to impossible to modify.

It's possible to wire this up with good design and to keep things in isolated classes, but who wants to do that? Most people just rant that this is simply unacceptable.

Enter: Ladders!

## How does it work?

- Create a stack in $manifestdir/ladders. Give it some load paths based on facts you want class autoloading to happen on.

```yaml
# $manifestdir/ladders/platform.yaml
---
:base: platform
:hierarchy:
  - %{::virtual}
  - %{::productname}
  - %{::operatingsystem}
  - %{::operatingsystem}/%{::lsbdistcodename}
  - %{::cloud}
  - %{::datacenter}
  - %{::datacenter}/%{::operatingsystem}
  - %{::datacenter}/%{::operatingsystem}/%{::lsbdistcodename}

```

- Load up the stack.

```puppet
  ladder { ‘platform’: }
```

- Bask in all the goodness that is Ladder. (and :moneybag:s)
