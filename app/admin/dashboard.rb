ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  action_item :reindex do
      link_to "Переиндексировать", admin_dashboard_reindex_path, method: :post
  end

  page_action :reindex, method: :post do
    ReindexWorker.perform_async
    redirect_to admin_dashboard_path, notice: "Реиндекс запущен. Процесс займет 10-30 минут"
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "В поиске товаров"
        small DrugsIndex.filter{ match_all }.total_count
        span "В базе товаров"
        small Drug.count
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
