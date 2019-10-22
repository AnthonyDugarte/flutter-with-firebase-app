import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/animal.dart';
import 'package:flutter_with_firebase_course/pages/home/animal/form_page.dart';

class CardViewAnimal extends StatelessWidget {
  final BuildContext context;
  final Animal animal;

  CardViewAnimal({@required this.context, @required this.animal});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AnimalFormPage(
              animal: animal,
            ),
          ),
        ),
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                height: 144.0,
                width: 500.0,
                color: Colors.green,
                child: FadeInImage.assetNetwork(
                  image: animal.image,
                  height: 144.0,
                  width: 160.0,
                  placeholder: "assets/images/flying_dog.jpg",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.pets),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(
                        animal.name,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.cake),
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(
                        animal.age,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
