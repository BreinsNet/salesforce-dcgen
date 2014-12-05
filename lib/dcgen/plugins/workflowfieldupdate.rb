require 'nokogiri'

module Dcgen

  def self.workflowfieldupdate master , destination

    remove_fieldupdates = []

    master_objects = Dir.glob(master + '/workflows/*workflow').map {|c| c.match(/^.*\/(.*).workflow$/)[1] }

    master_objects.each do |obj|

      master_obj_file = File.join(master,'workflows',obj + '.workflow')
      destination_obj_file = File.join(destination,'workflows',obj + '.workflow')

      if File.exists? destination_obj_file

        master_obj_xml = File.open(master_obj_file).read
        destination_obj_xml = File.open(destination_obj_file).read

        master_doc = Nokogiri::XML(master_obj_xml).remove_namespaces!
        destination_doc = Nokogiri::XML(destination_obj_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_doc.xpath('//fieldUpdates/fullName').each do |field|
          remove_fieldupdates << "#{obj}.#{field.text}" if master_doc.xpath("//fieldUpdates[fullName=\"#{field.text}\"]").empty?
        end

      end

    end

    puts "FieldUpdates:" if not remove_fieldupdates.empty?
    remove_fieldupdates.each do |fieldupdate|
      puts "  #{fieldupdate}"
    end

    remove_fieldupdates

  end
end
