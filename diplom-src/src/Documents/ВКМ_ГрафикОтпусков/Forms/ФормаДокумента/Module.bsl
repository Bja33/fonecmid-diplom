//НачалоДоработки. Барышникова Ю.А Заполнение графика отпусков, проверка длительности, чтобы не превышали 28 календарных дней,  
//построение диаграммы с отпусками на дополнительной форме.

#Область ОбработчикиСобытийФормы

 &НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)   

	Если НЕ ЗначениеЗаполнено(Объект.ВКМ_Год) Тогда

		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Нужно выбрать год для графика отпусков";
		Сообщение.Сообщить();
		Отказ = Истина;

	Иначе 
	Для Каждого Строка из Объект.ВКМ_ОтпускаСотрудников Цикл   

		Если Строка.ВКМ_ДатаОкончания >= КонецГода(Объект.ВКМ_Год) ИЛИ Строка.ВКМ_ДатаНачало <= НачалоГода(Объект.ВКМ_Год) Тогда  
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = СтрШаблон("Даты отпуска сотрудника %1 выходят за пределы года", Строка.ВКМ_Сотрудник);
			Сообщение.Сообщить(); 
			Отказ = Истина; 
		КонецЕсли;  

	КонецЦикла;  
	
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ) 

	ПроверкаДлительностиОтпусков();

КонецПроцедуры
#КонецОбласти


#Область ОбработчикиСобытийЭлементовТаблицыФормыВКМ_ОтпускаСотрудников

&НаКлиенте
Процедура ВКМ_ОтпускаСотрудниковПриИзменении(Элемент)   

	 ПроверкаДлительностиОтпусков();

 КонецПроцедуры  

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВКМ_ОткрытьАнализГрафика(Команда)  

	ПоместитьТЧВоВременноеХранилищеНаСервере();

	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Год", Объект.Дата);
	ПараметрыФормы.Вставить("АдресВХ", Объект.АдресВХ);

	ОткрытьФорму("Документ.ВКМ_ГрафикОтпусков.Форма.ФормаАнализГрафика", ПараметрыФормы);
КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПроверкаДлительностиОтпусков()
	
МассивСтрок = Новый Массив;

	Для Каждого Строка из Объект.ВКМ_ОтпускаСотрудников Цикл   

		СтруктураСтроки = Новый Структура ("Сотрудник, ПериодОтпуска");		
         
		Строка.ВКМ_ПревышениеОтпуска = Ложь;
		ПериодОтпуска = (Строка.ВКМ_ДатаОкончания - Строка.ВКМ_ДатаНачало)/86400  + 1;
		
		Если ПериодОтпуска > 28 Тогда 
			
			Строка.ВКМ_ПревышениеОтпуска = Истина;

			УсловноеОформлениеДлинногоОтпуска(Строка.ВКМ_ПревышениеОтпуска);
			
		КонецЕсли;

		Если МассивСтрок.Количество() = 0 Тогда 
			
			СтруктураСтроки.Сотрудник = Строка.ВКМ_Сотрудник; 
			СтруктураСтроки.ПериодОтпуска = ПериодОтпуска;
			МассивСтрок.Добавить(СтруктураСтроки); 

		Иначе 
			СотрудникаНет = Истина;

			Для а = 0 по МассивСтрок.Количество()-1 Цикл
				
				Если МассивСтрок.Получить(а).Сотрудник = Строка.ВКМ_Сотрудник тогда
					СотрудникаНет = Ложь;   
					НовыйПериодОтпуска = МассивСтрок.Получить(а).ПериодОтпуска + ПериодОтпуска;     
					МассивСтрок[а].ПериодОтпуска = НовыйПериодОтпуска;    

					Если НовыйПериодОтпуска > 28 Тогда 
						Строка.ВКМ_ПревышениеОтпуска = Истина; 
						УсловноеОформлениеДлинногоОтпуска(Строка.ВКМ_ПревышениеОтпуска);
					КонецЕсли; 

				КонецЕсли;

			КонецЦикла;
			
			Если СотрудникаНет Тогда

				СтруктураСтроки.Сотрудник = Строка.ВКМ_Сотрудник;
				СтруктураСтроки.ПериодОтпуска = ПериодОтпуска;  
				МассивСтрок.Добавить(СтруктураСтроки);
				 
			КонецЕсли;

		КонецЕсли; 

	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура  УсловноеОформлениеДлинногоОтпуска(ФактПревышенияОтпуска)  

	Если ФактПревышенияОтпуска Тогда 

		УсловноеОформление.Элементы.Очистить();

		Элемент = УсловноеОформление.Элементы.Добавить();  
		ОформлениеЦветФона = Элемент.Оформление.Элементы.Найти("ЦветФона");
		ОформлениеЦветФона.Значение = WebЦвета.Бирюзовый;
		ОформлениеЦветФона.Использование = Истина;

		НастройкаОтбора = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		НастройкаОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ВКМ_ОтпускаСотрудников.ВКМ_ПревышениеОтпуска");
		НастройкаОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		НастройкаОтбора.ПравоеЗначение = Истина;

		ПолеЭлемента1 = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента1.Поле = Новый ПолеКомпоновкиДанных("Объект.ВКМ_ОтпускаСотрудников.ВКМ_Сотрудник");
		ПолеЭлемента1.Использование = Истина;  

		ПолеЭлемента2 = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента2.Поле = Новый ПолеКомпоновкиДанных("Объект.ВКМ_ОтпускаСотрудников.ВКМ_ДатаОкончания");
		ПолеЭлемента2.Использование = Истина;

		ПолеЭлемента3 = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента3.Поле = Новый ПолеКомпоновкиДанных("Объект.ВКМ_ОтпускаСотрудников.НомерСтроки");
		ПолеЭлемента3.Использование = Истина;   

		ПолеЭлемента4 = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента4.Поле = Новый ПолеКомпоновкиДанных("Объект.ВКМ_ОтпускаСотрудников.ВКМ_ДатаНачало");
		ПолеЭлемента4.Использование = Истина;   

	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПоместитьТЧВоВременноеХранилищеНаСервере()   

	ТаблицаЗначенийВКМ_ОтпускаСотрудников = Объект.ВКМ_ОтпускаСотрудников.Выгрузить(); 
	Объект.АдресВХ = ПоместитьВоВременноеХранилище(ТаблицаЗначенийВКМ_ОтпускаСотрудников); 
  
КонецПроцедуры

#КонецОбласти

//Конец доработки	.





