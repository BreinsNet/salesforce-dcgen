module Dcgen
  class App

    attr_accessor :master, :destination

    def initialize 

      @metadata = {}

    end

    def validate_directories

      @master = File.join(Dir.pwd,@master)
      @destination = File.join(Dir.pwd,@destination)
      raise ArgumentError, "#{@master} dir not found" if not Dir.exists? @master
      raise ArgumentError, "#{@destination} dir not found" if not Dir.exists? @destination
      raise ArgumentError, "#{@master} package.xml not found" if not File.exists? File.join(@master,'package.xml')
      raise ArgumentError, "#{@destination} package.xml not found" if not File.exists? File.join(@destination,'package.xml')

    end

    def generate_xml

      # Generate destructive change
      dc_erb_tpl = File.open(File.join(File.dirname(__FILE__),'..','..','tpl','destructiveChanges.xml.erb')).read
      renderer = ERB.new(dc_erb_tpl,0,'>') 

      puts "info: destructiveChanges.xml successfully generated"

      File.open('destructiveChanges.xml','w') do |file|
        file.write renderer.result(binding)
      end

    end

    def generate_destructive_changes

      # Validate directories
      validate_directories

      # Load plugins and build metadata variables
      plugins = Dir.glob(File.dirname(__FILE__) + "/plugins/*" )

      plugins.each do |plugin|
        require_relative plugin

        plugin_name = plugin.match(/^.*\/(.*).rb$/)[1]
        @metadata[plugin_name.to_sym] = eval "Dcgen::#{plugin_name} @master, @destination"

      end

      # Generate the template and write to file
      generate_xml
    
    end

  end
end
