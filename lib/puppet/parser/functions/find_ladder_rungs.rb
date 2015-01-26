require 'yaml'

module Puppet::Parser::Functions

  newfunction(:find_ladder_rungs, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall
    
    load_ladder   = args[0]
    ladder_config = File.join(File.dirname(Puppet.settings[:config]), "ladders", "#{load_ladder}.yaml")
    manifests     = []

    if File.exists? ladder_config
      ladder = YAML.load_file ladder_config
      ladder_base = ladder.has_key?[:base] ? ladder[:base].gsub(/::/, '/') : '/'

      ladder[:hierarchy].each do |rung|
        rung_lookup   = "#{ladder_base}/#{function_expand_rung([rung])}".split('/')
        manifest_file = "#{module_path}/#{rung_lookup[0]}/manifests/#{rung_lookup[1..-1].join('/')}.pp"
        
        manifests << rung_lookup.join('::') if File.exists? manifest_file
      end
    end

    manifests.delete_if { |x| x =~ /::::/ }.uniq
  end
end
