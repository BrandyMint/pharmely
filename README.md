Аптеки чебоксар (http://APTEKA.WS)
---------------

* https://bugsnag.com/brandymint/rails/errors
* Шаблон таблицы: https://docs.google.com/spreadsheets/d/1nqeLMCIG0la0b2efO8IuCpviE1XZ2T1tQ26g-Jy84ss/edit?usp=sharing


Запуск:

> bundle exec sidekiq


1С
--

* https://github.com/BrandyMint/apteka_export_1c
* https://github.com/BrandyMint/apteka_export_1c/blob/master/apteki.ert

development
-----------

> bundle exec cap production assets:pull
> bundle exec cap production db:pull

sidekiq
-------

http://3004.vkontraste.ru/sidekiq/

Парсинг
-------
* Установить на сервере phantomjs

Запуск:

> rake parser:wer[5]

аргумент указыает на количество секунд между запросами бота
