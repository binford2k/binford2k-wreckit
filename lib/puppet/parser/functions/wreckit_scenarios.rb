Puppet::Parser::Functions.newfunction(:wreckit_scenarios, :type => :rvalue) do |args|
  begin
    raise(ArgumentError, 'wreckit_scenarios() expects a single optional argument') if args.size > 1

    context = args.first
    modpath = Puppet::Module.find('wreckit', compiler.environment.to_s).path
    klasses = []

    Dir.chdir("#{modpath}/manifests/scenario") do
      klasses = Dir.glob("**/*.pp").collect do |path|
        klass     = File.basename(path, '.pp')
        namespace = File.dirname(path).gsub('/', '::')

        "wreckit::scenario::#{namespace}::#{klass}"
      end
    end

    # Filter externally instead of in the Dir.glob because I was getting hangs on some platforms
    klasses.select! { |klass| klass.start_with? "wreckit::scenario::#{context}" }
  rescue => e
    Puppet.warning "Could not resolve Wreckit scenarios for context #{context}"
    Puppet.debug e.message
    Puppet.debug e.backtrace
    klasses = []
  end

  klasses
end
