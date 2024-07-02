			
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка = Истина Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("ЭтоНовый", ЭтоНовый());
	
КонецПроцедуры

			
Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка = Истина Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.ЭтоНовый Тогда
		СоздатьПодзадачи(Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура СоздатьПодзадачи(Отказ)
	
	МассивПодзадач = Новый Массив;
	МассивПодзадач.Добавить(Наименование);
	МассивПодзадач.Добавить("Анализ");
	МассивПодзадач.Добавить("Проектирование");
	МассивПодзадач.Добавить("Кодирование");
	МассивПодзадач.Добавить("Подготовка тестового примера");
	МассивПодзадач.Добавить("Тестирование");
	МассивПодзадач.Добавить("Устранение замечаний");
	МассивПодзадач.Добавить("Написание инструкций");
	МассивПодзадач.Добавить("Неучтенные работы");
	
	Для каждого ИмяПодзадачи Из МассивПодзадач Цикл
		
		НовПодзадача = Справочники.ут_ПодзадачиВнутреннегоУчета.СоздатьЭлемент();
		НовПодзадача.Наименование = ИмяПодзадачи;
		НовПодзадача.ПолноеНаименование = ИмяПодзадачи;
		НовПодзадача.Владелец = Ссылка;
		
		Попытка
			НовПодзадача.Записать();
		Исключение
			ШаблонСообщения = НСтр("ru = 'Не удалось создать подзадачу %1 по причине %2'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, ИмяПодзадачи, ОписаниеОшибки());
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ПолноеНаименование = ТекстЗаполнения;
	
КонецПроцедуры