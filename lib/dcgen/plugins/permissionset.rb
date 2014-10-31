module Dcgen

  def self.permissionset master , destination

    master_permissionset = Dir.glob(master + '/permissionsets/*permissionset').map {|c| c.match(/^.*\/(.*).permissionset$/)[1] }
    destination_permissionset = Dir.glob(destination + '/permissionsets/*permissionset').map {|c| c.match(/^.*\/(.*).permissionset$/)[1] }

    remove_permissionset = destination_permissionset - master_permissionset

    puts "PermissionSets:" if not remove_permissionset.empty?
    remove_permissionset.each do |permissionset|
      puts "  #{permissionset}"
    end

    remove_permissionset

  end

end
