abstract class Car {
  int milleage = 0;
  final DateTime releaseYear;
  final List<Details> detais;
  final List<Characteristics> charachteristics;
  Make make;

  Car(
      {required this.milleage,
      required this.releaseYear,
      required this.detais,
      required this.charachteristics,
      required this.make});

  @override
  String toString() {
    return 'Car{milleage: $milleage, '
        'releaseYear: $releaseYear, '
        'detais: $detais, '
        'charachteristics: $charachteristics, '
        'make: $make}';
  }

  void showInDisplay() {
    print('Name: ${make._name}');
    print('ReleaseYear: $releaseYear');
    print('Characteristics: $charachteristics');
    print('Details: $detais');
    print('Mileage: $milleage');
  }

  int ride() => milleage = milleage + 100;
}

abstract class Make {
  String? _name;

  set name(String value) {
    _name = value;
  }
}

class Kia extends Make {
  @override
  String? get _name => "Kia";
}

class Lamborgini extends Make {
  String? get _name => "Lambo";
}

class Volvo extends Make {
  String? get _name => "Volvo";
}

class Scania extends Make {
  String? get _name => "Scania";
}

class Details {
  final String engine;
  final String brakes;
  final String transmission;

  Details(
      {required this.engine, required this.brakes, required this.transmission});

  @override
  String toString() {
    return 'engine: $engine, '
        'brakes: $brakes, '
        'transmission: $transmission';
  }
}

class Characteristics {
  int weight;
  int horsepower;
  int fuelConsumption;
  int torque;

  Characteristics(
      this.weight, this.horsepower, this.fuelConsumption, this.torque);

  @override
  String toString() {
    return '_weight: $weight,'
        ' _horsepower: $horsepower, '
        '_fuelConsumption: $fuelConsumption,'
        ' _torque: $torque';
  }

  void chipTuning(){
    horsepower+= 80;
    fuelConsumption+= 1;
    torque+= 30;

  }
}

class RacingCar extends Car {
  RacingCar(milleage, releaseYear, detais, charachteristics, make)
      : super(
            milleage: milleage,
            releaseYear: releaseYear,
            detais: detais,
            charachteristics: charachteristics,
            make: make);

  void goForARace() {
    var carName = make._name;
    print('going for a race on $carName \n');

    milleage = ride();

    print('milleage= $milleage\n');
  }
}

class Truck extends Car {
  Truck(milleage, releaseYear, detais, charachteristics, make)
      : super(
            milleage: milleage,
            releaseYear: releaseYear,
            detais: detais,
            charachteristics: charachteristics,
            make: make);

  void goForARide() {
    var carName = make._name;
    print('going for a race on $carName \n');

    milleage = ride();

    print('milleage= $milleage');
  }
}

void main() {
  var detail = Details(engine: "V8", brakes: "cheramic", transmission: "auto");
  List<Details> details = [detail];

  var characteristics = Characteristics(100, 1500, 30, 700);
  List<Characteristics> caract = [characteristics];

  RacingCar car = RacingCar(0, DateTime.now(), details, caract, Lamborgini());
  car.showInDisplay();
  car.goForARace();
  car.goForARace();

  characteristics.chipTuning();
  print(' characteristics of lambo after tuning: $characteristics\n');



  var truckDetail =
      Details(engine: "D13A440", brakes: "disk", transmission: "auto");
  List<Details> truckDetails = [truckDetail];

  var truckCharacteristics = Characteristics(100, 1500, 30, 700);
  List<Characteristics> truckCaract = [truckCharacteristics];

  Truck truck =
      Truck(0, DateTime.utc(2004, 11, 19 , 20), truckDetails, truckCaract, Volvo());
  truck.showInDisplay();
  truck.goForARide();
}
