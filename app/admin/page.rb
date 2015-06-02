ActiveAdmin.register Page do

  menu label: 'Страницы сайта'

  controller do
    def new
      @page = Page.new
    end
    def edit

    end
  end

  form do |f|

    f.inputs "Страница" do
      f.input :title
      f.input :path
      f.input :content, as: :html_editor

    end
    f.actions
  end

  permit_params Page.attribute_names

end