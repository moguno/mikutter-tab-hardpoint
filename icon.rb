# coding: UTF-8

def define_icon_proc(plugin)
  plugin.instance_eval { 
    i_tabs = []

    UserConfig[:tab_icon_size] ||= 24

    on_boot do
      UserConfig.connect(:tab_icon_size) { |key, val, before, id|
        Plugin::GUI::Tab.cuscaded.each { |slug, i_tab|
          Plugin[:mikutter_tab_hardpoint].tab_update_widgets(i_tab)
        }
      }
    end

    settings "タブのアイコンサイズ" do
      adjustment("アイコンサイズ", :tab_icon_size, 1, 100)
    end

    filter_tab_update_widget { |i_tab, widgets|
      widget = if i_tab.icon.is_a?(String)
        ::Gtk::WebIcon.new(i_tab.icon, UserConfig[:tab_icon_size], UserConfig[:tab_icon_size])
      else
        ::Gtk::Label.new(i_tab.name)
      end

      widgets[:left] = [widget] + widgets[:left]

      [i_tab, widgets]
    }
  }
end
