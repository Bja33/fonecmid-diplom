//НачалоДоработки. Барышникова Ю.А
//Массовое создание реализации за прошлый месяцна все договора обслуживания (абонентская плата и выполненные работы)

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

	#Область ПрограммныйИНтерфейс
	///&НаСервере

	// Выделяет все договоры обслуживания в справочнике, 
	//проверяет наличие реализаций и выполненных работ за предыдущий месяц
	//
	//Параметры:
	//   Период - дата.
	//
	//Возвращаемое значение: 
	//	массив. 
	Функция ТяжелаяОперацияСозданиеРеализаций(Период) Экспорт          

		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДоговорыКонтрагентов.ВидДоговора КАК ВидДоговора,
		|	ДоговорыКонтрагентов.Представление КАК Представление,
		|	ДоговорыКонтрагентов.Наименование КАК Наименование,
		|	ДоговорыКонтрагентов.Ссылка КАК Договор,
		|	ДоговорыКонтрагентов.Организация КАК Организация,
		|	ДоговорыКонтрагентов.Владелец.Ссылка КАК Контрагент,
		|	ДоговорыКонтрагентов.ВКМ_НачалоДействия КАК ВКМ_НачалоДействия,
		|	ДоговорыКонтрагентов.ВКМ_КонецДействия КАК ВКМ_КонецДействия
		|ПОМЕСТИТЬ ВТ_ВидДоговора
		|ИЗ
		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|ГДЕ
		|	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
		|	И ДоговорыКонтрагентов.ВКМ_НачалоДействия <= &НачалоПериода
		|	И ДоговорыКонтрагентов.ВКМ_КонецДействия >= &НачалоПериода
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
		|	РеализацияТоваровУслуг.Договор КАК Договор,
		|	РеализацияТоваровУслуг.Договор.ВидДоговора КАК ДоговорВидДоговора
		|ПОМЕСТИТЬ ВТ_Реализации
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	РеализацияТоваровУслуг.Дата >= &НачалоПериода
		|	И РеализацияТоваровУслуг.Дата <= &КонецПериода
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ВидДоговора.Договор КАК Договор,
		|	ВТ_Реализации.Ссылка КАК ДокСсылка,
		|	ВТ_ВидДоговора.Контрагент КАК Контрагент,
		|	ВТ_ВидДоговора.Организация КАК Организация
		|ИЗ
		|	ВТ_ВидДоговора КАК ВТ_ВидДоговора
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Реализации КАК ВТ_Реализации
		|		ПО ВТ_ВидДоговора.Договор = ВТ_Реализации.Договор";

		Запрос.УстановитьПараметр("ВидДоговора", Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбоненскоеОбслуживание);   

		РасчетныйМесяц = ДобавитьМесяц(Период,0);                    
		Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(РасчетныйМесяц)); 
		Запрос.УстановитьПараметр("КонецПериода", КонецМесяца(РасчетныйМесяц));

		РезультатЗапроса = Запрос.Выполнить(); 

		Реестр = Новый ТаблицаЗначений; 
		Реестр.Колонки.Добавить("Реализация");
		Реестр.Колонки.Добавить("Контрагент");
		Реестр.Колонки.Добавить("Договор");

		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

			Если НЕ ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.ДокСсылка) Тогда             

				НовыйДокумент = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
				ЗаполнитьЗначенияСвойств(НовыйДокумент, ВыборкаДетальныеЗаписи);    //заполняет Контрагент, договор, орг-ция 

				НовыйДокумент.Дата = КонецМесяца(РасчетныйМесяц);
				НовыйДокумент.Основание = ВыборкаДетальныеЗаписи.Договор; 
				НовыйДокумент.ВыполнитьАвтозаполнение();
				НовыйДокумент.Записать(РежимЗаписиДокумента.Проведение);   


				СтрокаТабЗн = Реестр.Добавить();
				СтрокаТабЗн.Реализация = НовыйДокумент.Ссылка;
				СтрокаТабЗн.Контрагент = НовыйДокумент.Контрагент;
				СтрокаТабЗн.Договор = ВыборкаДетальныеЗаписи.Договор;

			КонецЕсли;

		КонецЦикла; 

		Хранилище = Новый ХранилищеЗначения (Реестр);  
		Возврат Хранилище;   

	КонецФункции 	

	#КонецОбласти

#КонецЕсли   

//КонецДоработки
