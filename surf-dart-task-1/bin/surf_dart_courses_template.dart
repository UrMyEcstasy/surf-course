/* данный код выполняет несколько функций в рамках задания ООО "Травка - Муравка"
 для ревлизации задания было создано несколько функций:

 * функция  mapFiller принимает данные из хранилища ( в нашем случае mapBefore2010 и mapAfter2010) и записывает
  всю информацию о существующей технике в новую структуру Map<String, DateTime>. В итоге мы получаем структуру,
  в которой хранится название техники в качестве ключа и год ее выпуска в качестве значения
  ( при этом вся техника будет уникальна)


 * функция ageCalculator высчитывает возраст техники, вычитая средний год выпуска из текущего года

 * функция averageYearCalculator суммирует год выпуска каждой единицы техники из ранее созданной структуры Map,
   после чего высчитывает средний год выпуска, а потом вычитает его из текущего года c помощью
   функции  ageCalculator ( таким образом функция будет актуальна для любой даты обращения,
   вследствие чего вернет возраст техники именно в текущий момент)

 * функция theOldestHalfFinder создает новый массив currentMachinery, в который записывается информация
   о произведеной технике ( класс AgriculturalMachinery) из ранее созданной структуры Map
   ( таким образом получится избежжать повторений техники в массиве),
   после чего сортирует данный массив и выбирает из него 50% самой старой техники
   (List<AgriculturalMachinery> oldestItems)

*/

enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
      this.areaInHectare,
      this.crops,
      this.machineries,
      );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
      this.id,
      this.releaseDate,
      );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery('Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void mapFiller ( Map<Countries, List<Territory>> mapSender,  Map<String, DateTime> mapReceiver ){

  mapSender.forEach((country, territories) {
    territories.forEach((territory) {
      territory.machineries.forEach((machinery) {
        mapReceiver[machinery.id] = machinery.releaseDate;
      });
    });
  });

}

int ageCalculator (int averageYear){
  DateTime now = DateTime.now();
  int momentYear = now.year;

  int currentYear = momentYear - averageYear;

  return currentYear;
}

int averageYearCalculator (Map<String, DateTime> mapOfMachines){

   int totalYears = 0;

     mapOfMachines.forEach((id, date) {
     totalYears += date.year;
   });

   int averageYear = totalYears ~/ mapOfMachines.length;

   return ageCalculator(averageYear);
}


List<AgriculturalMachinery> theOldestHalfFinder(Map<String, DateTime> mapOfMachines){

  List<AgriculturalMachinery> currentMachinery = mapOfMachines.entries
      .map((entry) => AgriculturalMachinery(entry.key, entry.value))
      .toList();

  currentMachinery.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));


  int halfSize = (currentMachinery.length * 0.5).ceil();
  List<AgriculturalMachinery> oldestItems = currentMachinery.sublist(0, halfSize);
return oldestItems;
}


void main() {
  var mapOfMachinery = <String, DateTime>{};

  print ('The following equipment exists on all territories:\n');

  mapFiller(mapBefore2010, mapOfMachinery);
  mapFiller(mapAfter2010, mapOfMachinery);

  for(final element in mapOfMachinery.entries){
   String key = element.key;
   int value = element.value.year;
    print('Name: $key, Year: $value');
  }
  print(' ');


  int averageYear = averageYearCalculator(mapOfMachinery);
  print('the average age of the equipment: $averageYear years\n');

  var theOldestHalf = theOldestHalfFinder(mapOfMachinery);


  print('50% of the oldest equipment:\n');
  int theOldestHalfYear = 0;
  theOldestHalf.forEach((item) {
    theOldestHalfYear += item.releaseDate.year;

    print('Name: ${item.id}, Year: ${item.releaseDate.year}');

  });

  int oldestAverageYear = theOldestHalfYear ~/ theOldestHalf.length;

  int currentYear = ageCalculator(oldestAverageYear);

  print('\n the average age of the oldest half = $currentYear years');
}



