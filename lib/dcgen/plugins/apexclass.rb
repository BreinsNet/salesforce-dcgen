module Dcgen

  def self.apexclass master , destination

    master_classes = Dir.glob(master + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }
    destination_classes = Dir.glob(destination + '/classes/*cls').map {|c| c.match(/^.*\/(.*).cls$/)[1] }

    destination_classes - master_classes

  end

end
