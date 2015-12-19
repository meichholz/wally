module Wally

  class MainWindow

    def self.load_tk
      require 'tk'
    end

    def initialize
      self.class.load_tk
      TkOption.add '*tearoff', 0
      @root = TkRoot.new { title 'Wall Viewer app' }
      setup_menu!
    end

    def do_frobnify
      # TODO: find out, when and how the callback is triggered
      puts "frobbing the foodle"
    end

    def setup_menu!
      @filemenu = TkMenu.new(@root)
      @filemenu.add :command, label: 'Frobnify', command: do_frobnify
      # connect menus to a bar and the bar to the window
      @menubar = TkMenu.new(@root)
      @menubar.add :cascade, menu: @filemenu, label: 'Filefrobnify'
      @root.menu @menubar
    end

    def run!
      Tk.mainloop
    end

  end


end
