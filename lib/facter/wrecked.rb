Facter.add(:wrecked) do
  setcode do
    Dir.glob('/var/spool/wrecked/*.wreck').collect {|e| File.basename(e, '.wreck')}
  end
end
