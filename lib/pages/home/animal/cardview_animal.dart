import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/animal.dart';
import 'package:flutter_with_firebase_course/pages/home/animal/form_page.dart';

class CardViewAnimal extends StatelessWidget {
  final BuildContext context;
  final Animal animal;

  CardViewAnimal({@required this.context, @required this.animal});

  Widget get petImage => ClipOval(
        child: FadeInImage.assetNetwork(
          image: animal.image,
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
          placeholder: "assets/images/flying_dog.jpg",
        ),
      );

  void onTapHandler() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => AnimalFormPage(
            animal: animal,
          ),
        ),
      );

  Widget contentRow({Icon icon, Widget content}) => Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(7.0),
            child: icon,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: content,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTapHandler,
        child: Card(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(7.0),
                child: petImage,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    contentRow(
                      icon: Icon(
                        Icons.pets,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      content: Text(
                        animal.name,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    contentRow(
                      icon: Icon(
                        Icons.cake,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      content: Text(
                        animal.age,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
