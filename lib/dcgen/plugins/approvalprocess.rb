module Dcgen

  def self.approvalprocess master , destination

    master_approvalprocess = Dir.glob(master + '/approvalProcesses/*approvalProcess').map {|c| c.match(/^.*\/(.*).approvalProcess$/)[1] }
    destination_approvalprocess = Dir.glob(destination + '/approvalProcesses/*approvalProcess').map {|c| c.match(/^.*\/(.*).approvalProcess$/)[1] }

    destination_approvalprocess - master_approvalprocess

  end

end
