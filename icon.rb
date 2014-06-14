# coding: UTF-8

def define_icon_proc(plugin)
  plugin.instance_eval { 
    i_tabs = []

    UserConfig[:tab_icon_size] ||= 24

    on_boot do
      UserConfig.connect(:tab_icon_size) { |key, val, before, id|
        i_tabs.each { |i_tab|
          icon = i_tab.icon
          i_tab.set_icon nil
          i_tab.set_icon icon
        }
      }
    end

    settings "タブのアイコンサイズ" do
      adjustment("アイコンサイズ", :tab_icon_size, 1, 100)
    end

    on_tab_created do |i_tab|
      i_tabs << i_tab
      i_tab.set_icon i_tab.icon
    end
  }
end
