module Wally

  class MainWindow < Gtk::Window
    def initialize
      super
      setup
    end

    def setup
      set_title "Wall viewer"
      signal_connect 'destroy' do
        Gtk.main_quit
      end
      @packer = Gtk::Fixed.new
      add @packer

      show_all

    end

  end


end
