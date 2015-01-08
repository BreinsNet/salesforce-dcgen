module Dcgen

  def self.layout master , destination, output = true

    master_layout = Dir.glob(master + '/layouts/*layout').map {|c| c.match(/^.*\/(.*).layout$/)[1] }
    destination_layout = Dir.glob(destination + '/layouts/*layout').map {|c| c.match(/^.*\/(.*).layout$/)[1] }

    remove_layout = destination_layout - master_layout

    if output
      puts "Layouts:" if not remove_layout.empty?
      remove_layout.each do |layout|
        puts "  #{layout}"
      end
    end

    remove_layout

  end

end
