include GLI::App

# see http://naildrivin5.com/gli/ for quick hints

# @alltodos
module Wally

  class App < BaseObject

    def initialize
      @argv = []
    end

    def setup!(argv)
      @argv = argv.clone
      wire_gli
    end

    def wire_gli
      program_desc 'Wall viewer app for alarms and team information'

      desc 'Usage and version'
      version Wally::VERSION

      desc 'Quick test'
      command :test do |c|
        c.action do
          not_implemented_yet
        end
      end

      desc 'Tell version, short form'
      command :version do |c|
        c.action do
          puts "#{Wally::NAME} #{Wally::VERSION}"
        end
      end

      desc 'Run the main window'
      command :gui do |c|
        c.action do
          @mainwindow = AppController.new
          @mainwindow.run!
        end
      end
      desc 'Use verbose output'
      switch [:v,:verbose]

      desc 'Set debug mask'
      default_value 0
      arg_name 'DEBUGMASK'
      flag [:D,:debugmask]
    end

    def run!
      exit run(@argv)
    end
  
      # @!attribute logger
      #   @return [Logger]
      #   the logger ist based on {::Logger} but is stripped down to be useful
      #   one the mere console. It is configured only during the first call.
      attr_writer :logger
      def logger
        return @logger if @logger
        @logger = Logger.new(STDERR)
        @logger.datetime_format = ""
        line = ""
        @logger.formatter = proc do |severity, datetime, progname, msg|
          line = msg[0]=='#' ?
            msg[1..-1] :
            "#{severity}: #{msg}"
          line = case severity
                 when 'INFO' then line
                 when 'WARN' then line.yellow
                 when 'FATAL' then line.red
                 when 'DEBUG' then line.yellow.on_light_black
                 else line
                 end
          line+"\n"
        end
        @logger
      end
  end

end
