module Dcgen

  def self.apexcomponent master , destination, output = true

    master_components = Dir.glob(master + '/components/*component').map {|c| c.match(/^.*\/(.*).component$/)[1] }
    destination_components = Dir.glob(destination + '/components/*component').map {|c| c.match(/^.*\/(.*).component$/)[1] }

    remove_components = destination_components - master_components

    if output
      puts "ApexComponents:" if not remove_components.empty?
      remove_components.each do |apexcomponent|
        puts "  #{apexcomponent}"
      end
    end

    remove_components

  end

end
