module Wally

  class AppController

    def self.load_tk
      require 'tk'
    end

    def initialize

      self.class.load_tk # deferred loading of API on demand

      @root = TkRoot.new do
        title 'Wall Viewer app'
        # geometry '1920x1080+0+0'
        geometry '1024x800+10+10' # if Tk.windowingsystem == 'x11'
      end
      setup_menu!
      setup_panes!
    end

    def do_frobnify
      STDERR.puts "frobbing foo and bar"
    end

    def do_quit
      STDERR.puts "Quitting"
      @root.destroy # will end mainloop
    end

    def setup_logger!(frame)
      @log_list = TkListbox.new(
        frame,
        height: 10,
        yscrollcommand: proc{|*args| @log_scroller.set(*args)}
      ).pack(expand: :true, fill: :both, side: :left)
      @log_scroller = Tk::Tile::Scrollbar.new(
        frame,
        orient: :vertical,
        command: proc{|*args| @log_list.yview(*args)}
      ).pack(fill: :y, side: :right)
      (1 ... 30).each do |i|
        @log_list.insert :end, "New line: #{i}"
      end
    end

    def setup_panes!
      @content = Tk::Tile::Frame.new(@root).pack(fill: :both, expand: true)
      # see .rvm/src/ruby-2.2.3/ext/tk/sample/demos-en/ttkpane.rb
      outer = Tk::Tile::Paned.new(@content, orient: :vertical)
      inner = Tk::Tile::Paned.new(outer, orient: :horizontal)
      service_frame = Tk::Tile::Labelframe.new(
        inner,
        text: 'Service Status',
        height: 40,
        width: 500,
      )
      build_frame = Tk::Tile::Labelframe.new(
        inner,
        text: 'Build Status',
        height: 40,
        width: 500,
      )
      log_frame = Tk::Tile::Labelframe.new(
        outer,
        text: 'Messages',
        height: 50,
        width: 300,
      )
      setup_logger! log_frame
      outer.add inner, weight: 10 
      outer.add log_frame, weight: 2
      inner.add service_frame, weight: 5
      inner.add build_frame, weight: 5
      outer.pack fill: :both, expand: true
    end

    def setup_menu!
      # see http://www.tutorialspoint.com/ruby/ruby_tk_menu.htm
      # see http://www.tkdocs.com/tutorial/menus.html

      TkOption.add '*tearOff', 0
      menubar = TkMenu.new(@root)

      file_menu = TkMenu.new(menubar)
      file_menu.add :command, label: 'Test...', underline: 0, command: proc{do_frobnify}
      file_menu.add :separator
      file_menu.add :command, label: 'Quit', underline: 0, command: proc{do_quit}
      # connect menus to a bar and the bar to the window
      menubar.add :cascade, menu: file_menu, label: 'File'
      @root.menu menubar
    end

    def run!
      Tk.mainloop
    end

  end


end
