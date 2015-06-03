include GLI::App

# @alltodos
module Wally

  class App

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

      desc 'Tell version, short form'
      command :version do |c|
        c.action do
          puts "#{Wally::NAME} #{Wally::VERSION}"
        end
      end

      desc 'Run the main window'
      command :gui do |c|
        c.action do
          Gtk.init
          @mainwindow = MainWindow.new
          Gtk.main
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
  
  end

end
