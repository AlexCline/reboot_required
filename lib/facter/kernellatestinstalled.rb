# kernellatestinstalled.rb
# Return the latest kernel version that is installed on the system.

require 'facter'
require 'facter/util/rebootrequired'

Facter.add(:kernellatestinstalled) do
  setcode do
    Facter::Util::RebootRequired.getinstalledkernels.first
  end
end
