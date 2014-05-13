define ladder(
  $stack = $name,
) {
  include ladder::config

  # Find all eligible manifests to load based on the stack hierarchy definitions.
  $rungs = find_ladder_rungs($stack)
  if size($rungs) != 0 {
    ladder::loader { $rungs: }
  } else {
      notify { "Unable to load the ladder ${stack}. No manifests found.": }  
  }
}
