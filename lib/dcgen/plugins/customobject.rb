module Dcgen

  def self.customobject master , destination, output = true

    master_customobject = Dir.glob(master + '/objects/*object').map {|c| c.match(/^.*\/(.*).object$/)[1] }
    destination_customobject = Dir.glob(destination + '/objects/*object').map {|c| c.match(/^.*\/(.*).object$/)[1] }

    remove_customobject = destination_customobject - master_customobject

    if output
      puts "CustomObjects:" if not remove_customobject.empty?
      remove_customobject.each do |customobject|
        puts "  #{customobject}"
      end
    end

    remove_customobject

  end

end
