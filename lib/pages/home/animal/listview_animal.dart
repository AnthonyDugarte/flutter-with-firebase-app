import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/animal.dart';
import 'package:flutter_with_firebase_course/pages/home/animal/cardview_animal.dart';

class ListViewAnimal extends StatefulWidget {
  final BuildContext context;
  ListViewAnimal({@required this.context});

  @override
  _ListViewAnimalState createState() => _ListViewAnimalState();
}

class _ListViewAnimalState extends State<ListViewAnimal> {
  List<Animal> animals = List();

  DatabaseReference ref = FirebaseDatabase.instance.reference().child("Animal");
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangedSubs;

  @override
  void initState() {
    super.initState();

    onAddedSubs = ref.onChildAdded.listen(onEntryAdded);
    onChangedSubs = ref.onChildChanged.listen(onEntryChanged);
    onChangedSubs = ref.onChildRemoved.listen(onEntryRemoved);
  }

  void onEntryChanged(Event e) {
    Animal oldEntry =
        animals.singleWhere((Animal entry) => entry.key == e.snapshot.key);

    setState(() {
      animals[animals.indexOf(oldEntry)] = Animal.getAnimal(e.snapshot);
    });
  }

  void onEntryAdded(Event e) {
    setState(() {
      animals.add(Animal.getAnimal(e.snapshot));
    });
  }

  void onEntryRemoved(Event e) {
    Animal oldEntry =
        animals.singleWhere((Animal entry) => entry.key == e.snapshot.key);

    setState(() {
      animals.removeAt(animals.indexOf(oldEntry));
    });
  }

  void deleteItem(int index) => ref.child(animals[index].key).remove();

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        itemCount: animals.length,
        itemBuilder: (BuildContext context, int index) => Dismissible(
          key: ObjectKey(animals[index]),
          onDismissed: (DismissDirection direction) {
            deleteItem(index);
          },
          child: CardViewAnimal(
            context: context,
            animal: animals[index],
          ),
        ),
      );

  @override
  void dispose() {
    onAddedSubs.cancel();
    onChangedSubs.cancel();

    super.dispose();
  }
}
