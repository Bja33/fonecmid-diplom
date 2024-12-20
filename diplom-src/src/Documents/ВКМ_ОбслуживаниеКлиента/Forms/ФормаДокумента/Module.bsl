#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	//	ПрисоединенныеФайлы.ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи, Параметры);  
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда 
		
		ВКМ_СозданиеНовогоУведомленияБоту
		(Объект.ВКМ_Клиент, Объект.ВКМ_Специалист, Объект.ВКМ_ДатаПроведенияРабот, 
		Объект.ВКМ_ВремяНачалаРаботПлан, Объект.ВКМ_ВремяОкончРаботПлан, Объект.ВКМ_ОписаниеПроблемы);	
	КонецЕсли;  
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы 

&НаКлиенте
Процедура ВКМ_ДатаПроведенияРаботПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ВКМ_ДатаПроведенияРаботПриИзмененииНаСервере();  
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ВКМ_ВремяНачалаРаботПланПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ВКМ_ВремяНачалаРаботПланПриИзмененииНаСервере(); 
	КонецЕсли;
	
КонецПроцедуры  


&НаКлиенте
Процедура ВКМ_ВремяОкончанияРаботПланПриИзменении(Элемент)
Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ВКМ_ВремяОкончРаботПланПриИзмененииНаСервере();  
	КонецЕсли;  
	
КонецПроцедуры
#КонецОбласти


#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ВКМ_ДатаПроведенияРаботПриИзмененииНаСервере() 
	
	ВКМ_СозданиеНовогоУведомленияБоту
		(Объект.ВКМ_Клиент, Объект.ВКМ_Специалист, Объект.ВКМ_ДатаПроведенияРабот, 
		Объект.ВКМ_ВремяНачалаРаботПлан, Объект.ВКМ_ВремяОкончанияРаботПлан, Объект.ВКМ_ОписаниеПроблемы);
		
КонецПроцедуры

&НаСервере
Процедура ВКМ_ВремяНачалаРаботПланПриИзмененииНаСервере()
	
	ВКМ_СозданиеНовогоУведомленияБоту
		(Объект.ВКМ_Клиент, Объект.ВКМ_Специалист, Объект.ВКМ_ДатаПроведенияРабот, 
		Объект.ВКМ_ВремяНачалаРаботПлан, Объект.ВКМ_ВремяОкончанияРаботПлан, Объект.ВКМ_ОписаниеПроблемы);
		
КонецПроцедуры

&НаСервере
Процедура ВКМ_ВремяОкончРаботПланПриИзмененииНаСервере() 
	
	ВКМ_СозданиеНовогоУведомленияБоту
		(Объект.ВКМ_Клиент, Объект.ВКМ_Специалист, Объект.ВКМ_ДатаПроведенияРабот, 
		Объект.ВКМ_ВремяНачалаРаботПлан, Объект.ВКМ_ВремяОкончанияРаботПлан, Объект.ВКМ_ОписаниеПроблемы); 
	
КонецПроцедуры

&НаСервере                                                                       
Процедура ВКМ_СозданиеНовогоУведомленияБоту(Клиент, Специалист, Дата, НачалоРабот, ОкончаниеРабот, Проблема)  
	
	НовыйЭлемент = Справочники.ВКМ_УведомленияТелеграмБоту.СоздатьЭлемент();
	НовыйЭлемент.ТекстСообщения=СтрШаблон("Обслуживание клиента %1 специалистом %2 запланировано на %3 с %4 ч по %5. Проблема: %6.", 
	Клиент, Специалист, Дата, Формат(НачалоРабот, "ДЛФ=T"), Формат(ОкончаниеРабот, "ДЛФ=T"), Проблема); 
	НовыйЭлемент.Записать();   
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти   


