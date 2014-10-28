module Dcgen

  def self.workflow master , destination

    master_workflow = Dir.glob(master + '/workflows/*workflow').map {|c| c.match(/^.*\/(.*).workflow$/)[1] }
    destination_workflow = Dir.glob(destination + '/workflows/*workflow').map {|c| c.match(/^.*\/(.*).workflow$/)[1] }

    destination_workflow - master_workflow

  end

end
