import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/utils/common.dart';
import 'package:image_picker/image_picker.dart';

class AnimalFormPage extends StatefulWidget {
  @override
  _AnimalFormPageState createState() => _AnimalFormPageState();
}

class _AnimalFormPageState extends State<AnimalFormPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  File _petFile;

  @override
  Widget build(BuildContext context) => scaffolded(
        title: Text("Animal"),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.pets),
                hintText: "What is your pet's name?",
                labelText: "Name",
              ),
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.cake),
                hintText: "What is your pet's age?",
                labelText: "Age",
              ),
              controller: _ageController,
            ),
            RaisedButton(
              child: Text("Selecciona una imagen"),
              onPressed: imageSelectGalery,
            ),
            SizedBox(
              child: showImage(),
            ),
            RaisedButton(
              child: Text("Guardar"),
              onPressed: sendData,
            ),
          ],
        ),
      );

  sendData() {}

  showImage() => _petFile != null ? Image.file(_petFile) : Text("Hello");

  Future<void> imageSelectGalery() async {
    _petFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 700,
    );

    setState(() {});
  }
}
