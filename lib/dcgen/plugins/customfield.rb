require 'nokogiri'

module Dcgen

  def self.customfield master , destination

    remove_customfields = []

    master_objects = Dir.glob(master + '/objects/*object').map {|c| c.match(/^.*\/(.*).object$/)[1] }

    master_objects.each do |obj|

      master_obj_file = File.join(master,'objects',obj + '.object')
      destination_obj_file = File.join(destination,'objects',obj + '.object')

      if File.exists? destination_obj_file

        master_obj_xml = File.open(master_obj_file).read
        destination_obj_xml = File.open(destination_obj_file).read

        master_doc = Nokogiri::XML(master_obj_xml).remove_namespaces!
        destination_doc = Nokogiri::XML(destination_obj_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_doc.xpath('//fields/fullName').each do |field|
          remove_customfields << "#{obj}.#{field.text}" if master_doc.xpath("//fields[fullName=\"#{field.text}\"]").empty?
        end

      end

    end

    puts "CustomFields:" if not remove_customfields.empty?
    remove_customfields.each do |customfield|
      puts "  #{customfield}"
    end

    remove_customfields

  end
end
