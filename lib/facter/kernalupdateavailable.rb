# kernelupdateavailable.rb
# Determine if there is an updated kernel installed

require 'facter'
require 'facter/util/rebootrequired'

Facter.add(:kernelupdateavailable) do
  setcode do
    # Compare the running kernel version with the latest installed kernel
    Facter::Util::RebootRequired.versioncmp(Facter.value('kernelrelease'), Facter.value('kernellatestinstalled')) == 1
  end
end

