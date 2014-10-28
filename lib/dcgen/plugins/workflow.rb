require 'nokogiri'

module Dcgen

  def self.workflow master , destination

    remove_workflows = []

    master_workflows = Dir.glob(master + '/workflows/*workflow').map {|c| c.match(/^.*\/(.*).workflow$/)[1] }

    master_workflows.each do |workflow|

      master_workflows_file = File.join(master,'workflows',workflow + '.workflow')
      destination_workflows_file = File.join(destination,'workflows',workflow + '.workflow')

      if File.exists? destination_workflows_file

        master_workflows_xml = File.open(master_workflows_file).read
        destination_workflows_xml = File.open(destination_workflows_file).read

        master_doc = Nokogiri::XML(master_workflows_xml).remove_namespaces!
        destination_doc = Nokogiri::XML(destination_workflows_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_doc.xpath('//rules/fullName').each do |rule|
          remove_workflows << "#{workflow}.#{rule.text}" if master_doc.xpath("//rules[fullName=\"#{rule.text}\"]").empty?
        end

      end

    end

    remove_workflows

  end
end

