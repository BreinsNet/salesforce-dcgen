require 'nokogiri'

module Dcgen

  def self.validationrule master , destination, output = true

    remove_validationrules = []

    master_obj = Dir.glob(master + '/objects/*object').map {|c| c.match(/^.*\/(.*).object$/)[1] }

    master_obj.each do |obj|

      master_obj_file = File.join(master,'objects',obj + '.object')
      destination_obj_file = File.join(destination,'objects',obj + '.object')

      if File.exists? destination_obj_file

        master_obj_xml = File.open(master_obj_file).read
        destination_obj_xml = File.open(destination_obj_file).read

        master_obj_xml = Nokogiri::XML(master_obj_xml).remove_namespaces!
        destination_obj_xml = Nokogiri::XML(destination_obj_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_obj_xml.xpath('//validationRules/fullName').each do |vr|
          remove_validationrules << "#{obj}.#{vr.text}" if master_obj_xml.xpath("//validationRules[fullName=\"#{vr.text}\"]").empty?
        end

      end

    end

    
    if output
      puts "ValidationRules:" if not remove_validationrules.empty?
      remove_validationrules.each do |obj|
        puts "  #{obj}"
      end
    end

    remove_validationrules

  end
end

