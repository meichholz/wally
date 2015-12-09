module Wally

  class MainWindow
    def initialize
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
