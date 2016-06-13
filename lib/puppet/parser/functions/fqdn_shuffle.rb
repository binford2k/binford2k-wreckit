Puppet::Parser::Functions.newfunction(:fqdn_shuffle, :type => :rvalue) do |args|
  raise(Puppet::ParseError, 'fqdn_shuffle: wrong number of args') unless args.size = 1
  raise(Puppet::ParseError, 'fqdn_shuffle: requires an array') unless args.first.is_a?(Array)

  result = args.first.clone
  count  = result.size
  seed   = Digest::MD5.hexdigest([self['::fqdn'], count, args].join(':')).hex

  # Simple implementation of Fisher–Yates in-place shuffle ...
  count.times do |i|
    j = Puppet::Util.deterministic_rand_int(seed, count)
    result[j], result[i] = result[i], result[j]
  end

  result
end
