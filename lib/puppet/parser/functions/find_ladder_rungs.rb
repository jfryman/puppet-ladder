require 'yaml'

module Puppet::Parser::Functions

  newfunction(:find_ladder_rungs, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall

    load_stack   = args[0]
    module_path  = File.expand_path('..', Puppet::Module.find('ladder', compiler.environment.to_s).path)
    stacks_path  = File.expand_path('../stacks', module_path)
    stack_config = "#{stacks_path}/#{load_stack}.yaml"
    manifests    = []


    if File.exists? stack_config
      stack = YAML.load_file stack_config
      stack_base = stack[:base].gsub(/::/, '/')

      stack[:hierarchy].each do |rung|
        rung_lookup   = "#{stack_base}/#{function_expand_rung([rung])}".split('/')
        manifest_file = "#{module_path}/#{rung_lookup[0]}/manifests/#{rung_lookup[1..-1].join('/')}.pp"
        
        manifests << rung_lookup.join('::') if File.exists? manifest_file
      end
    end

    manifests.delete_if { |x| x =~ /::::/ }.uniq
  end
end
