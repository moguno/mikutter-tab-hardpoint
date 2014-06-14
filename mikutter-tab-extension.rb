# coding:UTF-8

require File.join(File.dirname(__FILE__), "icon.rb")

Plugin.create(:mikutter_tab_extension) {
  Plugin[:gtk].instance_eval {
    alias :tab_update_icon_moguno :tab_update_icon

    def tab_update_icon(i_tab)
      Plugin[:mikutter_tab_extension].tab_update_widgets(i_tab)
    end
  }

  def tab_update_widgets(i_tab)
      type_strict i_tab => Plugin::GUI::TabLike

      tab = Plugin[:gtk].widgetof(i_tab)

      if tab
        tab.tooltip(i_tab.name)
        tab.remove(tab.child) if tab.child

        widgets = Plugin.filtering(:tab_update_widget, i_tab, {:left => [], :center => [], :right => []})

        box = ::Gtk::HBox.new

        [:left, :center, :right].each { |key|
          widgets[1][key].each { |widget|
            box.pack_start(widget)
          }
        }

        tab.add(box).show_all
    end
  end

  define_icon_proc(self)
}
