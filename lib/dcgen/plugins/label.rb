require 'nokogiri'

module Dcgen

  def self.label master , destination

    remove_labels = []

    master_labels = Dir.glob(master + '/labels/*labels').map {|c| c.match(/^.*\/(.*).labels$/)[1] }

    master_labels.each do |label|

      master_labels_file = File.join(master,'labels',label + '.labels')
      destination_labels_file = File.join(destination,'labels',label + '.labels')

      if File.exists? destination_labels_file

        master_labels_xml = File.open(master_labels_file).read
        destination_labels_xml = File.open(destination_labels_file).read

        master_doc = Nokogiri::XML(master_labels_xml).remove_namespaces!
        destination_doc = Nokogiri::XML(destination_labels_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_doc.xpath('//labels/fullName').each do |lb|
          remove_labels << "#{lb.text}" if master_doc.xpath("//labels[fullName=\"#{lb.text}\"]").empty?
        end

      end

    end

    remove_labels

  end
end

