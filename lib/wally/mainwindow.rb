module Wally

  class MainWindow

    def self.load_tk
      require 'tk'
    end

    def initialize
      self.class.load_tk
      @root = TkRoot.new do
        title 'Wall Viewer app'
        # geometry '1920x1080+0+0'
        geometry '1024x800+10+10' if Tk.windowingsystem == 'x11'
      end
      setup_menu!
    end

    def do_frobnify
      STDERR.puts "frobbing foo and bar"
    end

    def do_quit
      STDERR.puts "Quitting"
      @root.destroy # will end mainloop
    end

    def setup_menu!
      # see http://www.tutorialspoint.com/ruby/ruby_tk_menu.htm
      # see http://www.tkdocs.com/tutorial/menus.html

      TkOption.add '*tearOff', 0
      menubar = TkMenu.new(@root)

      file_menu = TkMenu.new(menubar)
      file_menu.add :command, label: 'Test...', underline: 0, command: Proc.new{ do_frobnify }
      file_menu.add :separator
      file_menu.add :command, label: 'Quit', underline: 0, command: Proc.new{ do_quit }
      # connect menus to a bar and the bar to the window
      menubar.add :cascade, menu: file_menu, label: 'File'
      @root.menu menubar
    end

    def run!
      Tk.mainloop
    end

  end


end
