module Dcgen

  def self.group master , destination, output = true

    master_groups = Dir.glob(master + '/groups/*group').map {|c| c.match(/^.*\/(.*).group$/)[1] }
    destination_groups = Dir.glob(destination + '/groups/*group').map {|c| c.match(/^.*\/(.*).group$/)[1] }

    remove_groups = destination_groups - master_groups

    if output
      puts "Groups:" if not remove_groups.empty?
      remove_groups.each do |group|
        puts "  #{group}"
      end
    end

    remove_groups

  end

end
