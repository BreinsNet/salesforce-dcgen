module Dcgen

  def self.apexpage master , destination

    master_pages = Dir.glob(master + '/pages/*page').map {|c| c.match(/^.*\/(.*).page$/)[1] }
    destination_pages = Dir.glob(destination + '/pages/*page').map {|c| c.match(/^.*\/(.*).page$/)[1] }

    destination_pages - master_pages

  end

end
