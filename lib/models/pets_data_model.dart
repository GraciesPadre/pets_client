class PetData {
  PetData(this.name, this.age, this.breed);

  final String name;
  final int age;
  final String breed;

  factory PetData.fromJson(String name, Map<String, dynamic> json) => PetData(name, json['age'], json['breed']); 
}

class AllPetsData {
  AllPetsData(this.petsData);

  final List<PetData> petsData;

  factory AllPetsData.fromJson(Map<String, dynamic> json) {
    List<PetData> result = [];

    var petData = json["pets_collection"];

    for (var name in petData.keys) {
      var pet = petData[name];
      result.add(PetData.fromJson(name, pet));
    }

    return AllPetsData(result);
  }
}
