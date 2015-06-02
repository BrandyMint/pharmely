# -*- coding: utf-8 -*-
# configures your navigation

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :pharmacies,  "Аптеки", pharmacies_url
    primary.item :products,  'Поиск лекарств', drugs_url
    primary.item :about, 'О сайте', about_url
    primary.item :cart,  'Корзина', cart_url

    primary.dom_class = 'nav navbar-nav pull-right'

    # you can turn off auto highlighting for a specific level
    primary.auto_highlight = true
  end
end
