# rebootrequired.rb
# Support methods for the reboot_required facts

module Facter::Util::RebootRequired

  def self.getinstalledkernels
    kernel_list = `/bin/rpm -qa | /bin/grep -E "^kernel-[0-9]"`

    kernel_list.strip.split("\n").map{|k| k.sub('kernel-', '') }.sort{ |a, b| versioncmp(a, b) }
  end


  # Copied from puppet:
  # https://github.com/puppetlabs/puppet/blob/master/lib/puppet/util/package.rb
  def self.versioncmp(version_a, version_b)
    vre = /[-.]|\d+|[^-.\d]+/
    ax = version_a.scan(vre)
    bx = version_b.scan(vre)

    while (ax.length>0 && bx.length>0)
      a = ax.shift
      b = bx.shift

      if( a == b )                 then next
      elsif (a == '-' && b == '-') then next
      elsif (a == '-')             then return -1
      elsif (b == '-')             then return 1
      elsif (a == '.' && b == '.') then next
      elsif (a == '.' )            then return -1
      elsif (b == '.' )            then return 1
      elsif (a =~ /^\d+$/ && b =~ /^\d+$/) then
        if( a =~ /^0/ or b =~ /^0/ ) then
          return a.to_s.upcase <=> b.to_s.upcase
        end
        return a.to_i <=> b.to_i
      else
        return a.upcase <=> b.upcase
      end
    end
    version_a <=> version_b;
  end

end
