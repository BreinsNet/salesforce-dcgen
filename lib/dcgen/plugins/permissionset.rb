module Dcgen

  def self.permissionset master , destination

    master_permissionset = Dir.glob(master + '/permissionsets/*permissionset').map {|c| c.match(/^.*\/(.*).permissionset$/)[1] }
    destination_permissionset = Dir.glob(destination + '/permissionsets/*permissionset').map {|c| c.match(/^.*\/(.*).permissionset$/)[1] }

    destination_permissionset - master_permissionset

  end

end
