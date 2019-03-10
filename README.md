# RealmHWProject

## Home Work: 
Создать приложение - файловую систему.   
Функционал:
* Все данные хранятся в Realm
* Возможность создать новую папку, задать имя папки. 
* Внутри папки можно добавить текстовую записку, картинку, видео или новую папку.
* При создании/добавления объекта (папки, текста, картинки, видео) в subtitle ячейки пишется дата создания/добавления. 
* Есть возможность удалить любой объект. 
* Есть возможность отредактировать любой объект.
* Есть возможность перейти на детальный просмотр объекта. 
* Для работы с бд DataBaseManager - дженерик штука, которая умеет работать с любыми объектами Realm.

## Home Work 2 NSCache/SDWebImage/Nuke: 

Добавить возможность подгружать любое изображение из сети по ссылке и сохранять его в вашу файловую систему. 
Функционал: 
* Ввод url для подгрузки изображения
* Валидация не правильного урла
* Отображение изображения
* Возможность сохранить изображение в файловую систему/на устройство. 
* Отображение картинок в файловой системе. 

Можно использовать любой из пройденных способов кеширования изображения (с помощью либ, или нет).  
Если пользователь сохраняет изображение к себе на телефон, то автоматом кешируем **URL** в файловую систему, и далее подгружаем в системе эту картинку по урлу.   
Если пользователь сохранил изображение в приложение, то подгружаем картинки напрямую из Realm. 

### PS: 
Картинки/видео добавляется напрямую из галереи на телефоне;   
Создание папки можно реализовать через UIAlertController с UITextField внутри него (чекните как это);    
Создание заметки можно в UIAlertController с UITextField или на новом экране с UITextView;  
У папок неограниченная вложенность;  
Можно использовать KVO для обсервинга изменений в бд;  
Можно использовать NotificationCenter для обсервинга изменений в БД;  
Задание на доп балл - отображать размер объектов в папке (в мб/кб) учитывая всю вложенность;   
Чтобы сделать иллюзию бесконечной вложенности таблицы, и оставить возможность перемещаться внутрь папок push переходами можно сделать UISegue таблицы самого на себя.
