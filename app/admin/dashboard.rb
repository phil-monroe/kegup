ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end 
  
  action_item :flush_cache do
    link_to 'View on site', admin_dashboard_flush_cache_path, method: :post
  end

  page_action :flush_cache, method: :post do
    Rails.cache.clear 
    redirect_to :back, notice: "Cache Cleared!"
  end
end
