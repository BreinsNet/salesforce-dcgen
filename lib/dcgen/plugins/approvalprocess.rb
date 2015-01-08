module Dcgen

  def self.approvalprocess master , destination, output = true

    master_approvalprocess = Dir.glob(master + '/approvalProcesses/*approvalProcess').map {|c| c.match(/^.*\/(.*).approvalProcess$/)[1] }
    destination_approvalprocess = Dir.glob(destination + '/approvalProcesses/*approvalProcess').map {|c| c.match(/^.*\/(.*).approvalProcess$/)[1] }

    remove_approvalprocess = destination_approvalprocess - master_approvalprocess

    if output
      puts "ApprovalProcesses:" if not remove_approvalprocess.empty?
      remove_approvalprocess.each do |approvalprocess|
        puts "  #{approvalprocess}"
      end
    end

    remove_approvalprocess

  end

end
