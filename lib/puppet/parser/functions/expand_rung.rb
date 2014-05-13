module Puppet::Parser::Functions
  newfunction(:expand_rung, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall
    rung = args.first

    render = rung.sub(/%{([:a-zA-Z]+)}/) { |match| lookupvar($1) }

    if render.match(/%{([:a-zA-Z]+)}/)
      function_expand_rung([render])
    else
      return render.downcase
    end
  end
end

