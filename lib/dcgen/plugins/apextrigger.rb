module Dcgen

  def self.apextrigger master , destination

    master_triggers = Dir.glob(master + '/triggers/*trigger').map {|c| c.match(/^.*\/(.*).trigger$/)[1] }
    destination_triggers = Dir.glob(destination + '/triggers/*trigger').map {|c| c.match(/^.*\/(.*).trigger$/)[1] }

    remove_triggers = destination_triggers - master_triggers

    puts "ApexTriggers:" if not remove_triggers.empty?
    remove_triggers.each do |apextrigger|
      puts "  #{apextrigger}"
    end

    remove_triggers

  end

end
