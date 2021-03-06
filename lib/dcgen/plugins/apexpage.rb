module Dcgen

  def self.apexpage master , destination, output = true

    master_pages = Dir.glob(master + '/pages/*page').map {|c| c.match(/^.*\/(.*).page$/)[1] }
    destination_pages = Dir.glob(destination + '/pages/*page').map {|c| c.match(/^.*\/(.*).page$/)[1] }

    remove_pages = destination_pages - master_pages

    if output
      puts "ApexPages:" if not remove_pages.empty?
      remove_pages.each do |aplexpage|
        puts "  #{aplexpage}"
      end
    end

    remove_pages

  end

end
