#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Объект.ВКМ_Год = ОбщегоНазначенияКлиентСервер.СтрокаВДату(Параметры.Год);   
	ПрочитатьДанныеИзВременногоХранилищаНаСервере(Параметры.АдресВХ)
	
КонецПроцедуры  

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПрочитатьДанныеИзВременногоХранилищаНаСервере(Адрес)
	ТаблицаЗначенийОтпускаСотрудников = ПолучитьИзВременногоХранилища(Адрес);
	Для каждого Стр Из ТаблицаЗначенийОтпускаСотрудников Цикл  
		
		Точка = ВКМ_Диаграмма.УстановитьТочку(Стр.ВКМ_Сотрудник);
		Серия = ВКМ_Диаграмма.УстановитьСерию("Отпуск");    // 
		
		        Серия.Цвет = WEBЦвета.Бирюзовый;
			Серия.Текст = "Отпуск";
			
		Значение = ВКМ_Диаграмма.ПолучитьЗначение(Точка,Серия);
		
		Интервал = Значение.Добавить();
		Интервал.Начало = Стр.ВКМ_ДатаНачало;
		Интервал.Конец = Стр.ВКМ_ДатаОкончания;
 
	КонецЦикла; 
КонецПроцедуры

#КонецОбласти
