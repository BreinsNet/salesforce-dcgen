module Dcgen

  def self.apexclass master , destination

    master_classes = Dir.glob(master + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }
    destination_classes = Dir.glob(destination + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }

    remove_classes = destination_classes - master_classes

    puts "ApexClasses:" if not remove_classes.empty?
    remove_classes.each do |apexclass|
      puts "  #{apexclass}"
    end

    remove_classes

  end

end
