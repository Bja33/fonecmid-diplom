///начало доработки Барышникова Ю.А 08.11.2024

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	НовыйЭлемент = Элементы.Добавить("НачалоДействия", Тип("ПолеФормы"));
	НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_НачалоДействияДоговора"; 
	НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.Заголовок = "Начало действия";
	
	НовыйЭлемент = Элементы.Добавить("КонецДействия", Тип("ПолеФормы"));
	НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_КонецДействияДоговора"; 
	НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.Заголовок = "Конец действия";
	
	НовыйЭлемент = Элементы.Добавить("АбонентскаяПлата", Тип("ПолеФормы"));
	НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_СуммаАбоненскойПлаты"; 
	НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.Заголовок = "Абонентская плата";
	
	НовыйЭлемент = Элементы.Добавить("ЧасоваяСтавка", Тип("ПолеФормы"));
	НовыйЭлемент.ПутьКДанным    = "Объект.ВКМ_СтоимостьЧасаРаботы"; 
	НовыйЭлемент.Вид            = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.Заголовок = "Часовая ставка";
	
	Если НЕ Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание Тогда  
		Элементы.НачалоДействия.Видимость = Ложь;  
		Элементы.КонецДействия.Видимость = Ложь;    
		Элементы.АбонентскаяПлата.Видимость = Ложь;    
		Элементы.ЧасоваяСтавка.Видимость = Ложь; 
	Иначе 	
		Элементы.НачалоДействия.Видимость = Истина;  
		Элементы.КонецДействия.Видимость = Истина;    
		Элементы.АбонентскаяПлата.Видимость = Истина;    
		Элементы.ЧасоваяСтавка.Видимость = Истина; 
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание 
	И Не ЗначениеЗаполнено(Объект.ВКМ_НачалоДействияДоговора) Тогда
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Не заполнена дата начала договора";
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
	
	Если Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание 
		И Не ЗначениеЗаполнено(Объект.ВКМ_КонецДействияДоговора) Тогда
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Не заполнена дата окончания договора";
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидДоговораПриИзменении(Элемент)
	
	ВидДоговораПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ВидДоговораПриИзмененииНаСервере()
	
	Если НЕ Объект.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание Тогда  
		Элементы.НачалоДействия.Видимость = Ложь;  
		Элементы.КонецДействия.Видимость = Ложь;    
		Элементы.АбонентскаяПлата.Видимость = Ложь;    
		Элементы.ЧасоваяСтавка.Видимость = Ложь; 
	Иначе 	
		Элементы.НачалоДействия.Видимость = Истина;  
		Элементы.КонецДействия.Видимость = Истина;    
		Элементы.АбонентскаяПлата.Видимость = Истина;    
		Элементы.ЧасоваяСтавка.Видимость = Истина; 
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

//КонецДоработки

