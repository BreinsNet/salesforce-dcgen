module Dcgen
  class App

    attr_accessor :master, :destination, :output, :exclude, :verbose, :include

    def initialize 

      @verbose = true
      @metadata = {}
      @exclude = []
      @include = []

    end

    def validate_directories

      raise ArgumentError, "#{@master} dir not found" if not Dir.exists? @master
      raise ArgumentError, "#{@destination} dir not found" if not Dir.exists? @destination
      raise ArgumentError, "#{@master} package.xml not found" if not File.exists? File.join(@master,'package.xml')
      raise ArgumentError, "#{@destination} package.xml not found" if not File.exists? File.join(@destination,'package.xml')

    end

    def generate_xml

      # Generate destructive change
      dc_erb_tpl = File.open(File.join(File.dirname(__FILE__),'..','..','tpl','destructiveChanges.xml.erb')).read
      renderer = ERB.new(dc_erb_tpl,0,'>') 

      out_file = @output || 'destructiveChanges.xml' 

      File.open(out_file,'w') do |file|
        file.write renderer.result(binding)
      end

      puts "
File generated:
===============

#{out_file}

" if @verbose

    end

    def print_header

      puts "
Diff between:
=============
      
   master:      #{master} 
   destination: #{destination}:
   excluded: #{@exclude.join(' ')}
   included: #{@include.join(' ')}
      
Changes detected:
=================
      
" 

    end

    def generate_destructive_changes

      # Validate directories
      validate_directories

      # header output
      print_header if @verbose

      # Load plugins and build metadata variables
      plugins = Dir.glob(File.dirname(__FILE__) + "/plugins/*")

      plugins.each do |plugin|

        require_relative plugin

        plugin_name = plugin.match(/^.*\/(.*).rb$/)[1]

        if @include.include?(plugin_name) || @include.empty?
          plugin_metadata = eval "Dcgen::#{plugin_name} @master, @destination, @verbose" 
          @metadata[plugin_name.to_sym] = plugin_metadata - @exclude unless plugin_metadata.nil?
        else
          @metadata[plugin_name.to_sym] = []
        end

      end

      # Generate the template and write to file
      generate_xml
    
    end

  end
end
