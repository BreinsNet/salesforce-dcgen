require 'nokogiri'

module Dcgen

  def self.workflowrule master , destination

    remove_workflowrules = []

    master_workflowrules = Dir.glob(master + '/workflows/*workflow').map {|c| c.match(/^.*\/(.*).workflow$/)[1] }

    master_workflowrules.each do |workflowrule|

      master_workflowrules_file = File.join(master,'workflows',workflowrule + '.workflow')
      destination_workflowrules_file = File.join(destination,'workflows',workflowrule + '.workflow')

      if File.exists? destination_workflowrules_file

        master_workflowrules_xml = File.open(master_workflowrules_file).read
        destination_workflowrules_xml = File.open(destination_workflowrules_file).read

        master_doc = Nokogiri::XML(master_workflowrules_xml).remove_namespaces!
        destination_doc = Nokogiri::XML(destination_workflowrules_xml).remove_namespaces!

        # Find all the customfields that are in destination, if they are not present in
        # master, then they have to be in the remove list
        destination_doc.xpath('//rules/fullName').each do |rule|
          remove_workflowrules << "#{workflowrule}.#{rule.text}" if master_doc.xpath("//rules[fullName=\"#{rule.text}\"]").empty?
        end

      end

    end

    puts "WorkflowRules:" if not remove_workflowrules.empty?
    remove_workflowrules.each do |workflowrule|
      puts "  #{workflowrule}"
    end

    remove_workflowrules

  end
end

