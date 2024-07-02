
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ут_УчетПлановыхТрудозатрат Приход
	Движения.ут_УчетПлановыхТрудозатрат.Записывать = Истина;
	Для Каждого ТекСтрокаПлановыеТрудозатраты Из ПлановыеТрудозатраты Цикл
		Движение = Движения.ут_УчетПлановыхТрудозатрат.Добавить();
		Движение.Период = Дата;
		Движение.Подзадача = ТекСтрокаПлановыеТрудозатраты.Подзадача;
		Движение.План = ТекСтрокаПлановыеТрудозатраты.План;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ут_ТехническийПроект.Ссылка КАК Ссылка
	               |ИЗ
	               |	Документ.ут_ТехническийПроект КАК ут_ТехническийПроект
	               |ГДЕ
	               |	ут_ТехническийПроект.ВнутренняяЗадача = &ВнутренняяЗадача
	               |	И ут_ТехническийПроект.Ссылка <> &ТекСсылка
	               |	И ут_ТехническийПроект.Проведен";
	
	Запрос.УстановитьПараметр("ВнутренняяЗадача", ВнутренняяЗадача);
	Запрос.УстановитьПараметр("ТекСсылка", Ссылка);
	РезЗапроса = Запрос.Выполнить();
	Если Не РезЗапроса.Пустой() Тогда
		
		Выборка = РезЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			ШаблонСообщения = НСтр("ru = 'Уже есть %1 с внутренней задачей %2'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, Выборка.Ссылка, ВнутренняяЗадача);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,Выборка.Ссылка,,,Отказ);
			
		КонецЦикла;
		
	КонецЕсли;
	// тест гит 2
КонецПроцедуры
