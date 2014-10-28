module Dcgen

  def self.group master , destination

    master_groups = Dir.glob(master + '/groups/*group').map {|c| c.match(/^.*\/(.*).group$/)[1] }
    destination_groups = Dir.glob(destination + '/groups/*group').map {|c| c.match(/^.*\/(.*).group$/)[1] }

    destination_groups - master_groups

  end

end
