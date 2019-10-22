import 'package:firebase_database/firebase_database.dart';

class Animal {
  String key, name, age, image;

  Animal({this.key, this.name, this.age, this.image});

  Animal.getAnimal(DataSnapshot snap)
      : key = snap.key,
        name = snap.value["name"],
        age = snap.value["age"],
        image = snap.value["image"];
}
