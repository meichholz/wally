module Wally

  class MainWindow

    def self.load_tk
      if @opt_tweak_load_path
        corepath = $LOAD_PATH.select{|p| p=~/\/ruby\/[0-9]+[^\/]+$/ }[0]
        $LOAD_PATH.unshift File.join(corepath, 'tk')
        $LOAD_PATH.unshift File.join(corepath, 'tkextlib')
        [ 'vu', 'ICONS', 'itk', 'tclx', 'tile',
          'tcllib', 'itcl', 'bwidget', 'blt', 'blt/tile', ].each do |dir|
          $LOAD_PATH.unshift File.join(corepath, 'tkextlib', dir)
        end
        $LOAD_PATH.unshift corepath
        $LOAD_PATH.unshift File.join(corepath, 'i686-linux')
        #puts $LOAD_PATH
      end
      require 'tk'
    end

    def initialize
      self.class.load_tk
      @frame = TkRoot.new { title 'Wall Viewer app' }
      setup!
    end

    def setup!
    end

    def run!
      Tk.mainloop
    end

  end


end
