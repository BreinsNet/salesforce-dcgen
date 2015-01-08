module Dcgen

  def self.apexclass master , destination, output = true

    master_classes = Dir.glob(master + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }
    destination_classes = Dir.glob(destination + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }

    remove_classes = destination_classes - master_classes

    if output
      puts "ApexClasses:" if not remove_classes.empty?
      remove_classes.each do |apexclass|
        puts "  #{apexclass}"
      end
    end

    remove_classes

  end

end
