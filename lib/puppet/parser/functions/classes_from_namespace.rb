Puppet::Parser::Functions.newfunction(:classes_from_namespace, :type => :rvalue) do |args|
  begin
    known_resource_types.loader.import_all
    klasses = known_resource_types.hostclasses.values.collect { |e| e.name }
    klasses.select! {|e| e.start_with? args.first }
  rescue => e
    Puppet.warning e.message
    Puppet.debug e.backtrace
    klasses = []
  end

  klasses
end
