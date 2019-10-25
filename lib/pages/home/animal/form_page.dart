import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/animal.dart';
import 'package:flutter_with_firebase_course/utils/common.dart';
import 'package:image_picker/image_picker.dart';

class AnimalFormPage extends StatelessWidget {
  final Animal animal;

  AnimalFormPage({this.animal});

  @override
  Widget build(BuildContext context) => scaffolded(
        title: Text("${animal != null ? "Update" : "Add"} Pet"),
        child: AnimalForm(
          animal: animal,
        ),
      );
}

class AnimalForm extends StatefulWidget {
  final Animal animal;

  AnimalForm({this.animal});

  @override
  _AnimalFormPageState createState() => _AnimalFormPageState();
}

class _AnimalFormPageState extends State<AnimalForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  File _petFile;
  String petImageUrl;
  bool loading = false;

  void initState() {
    super.initState();

    if (widget.animal != null) {
      _nameController.text = widget.animal.name;
      _ageController.text = widget.animal.age;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.pets),
              hintText: "What is your pet's name?",
              labelText: "Name",
            ),
            controller: _nameController,
            readOnly: loading,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.cake),
              hintText: "What is your pet's age?",
              labelText: "Age",
            ),
            controller: _ageController,
            readOnly: loading,
          ),
          RaisedButton(
            child: Text("Selecciona una imagen"),
            color: Theme.of(context).primaryColorLight,
            onPressed: !loading ? imageSelectGalery : null,
          ),
          SizedBox(
            child: showImage(),
          ),
          RaisedButton(
            child: Text("Guardar"),
            color: Theme.of(context).primaryColorDark,
            onPressed: !loading ? sendData : null,
          ),
        ],
      );

  Future<void> sendData() async {
    setState(() {
      loading = true;
    });

    await saveFirebase(_nameController.text);

    DatabaseReference animalDb =
        FirebaseDatabase.instance.reference().child("Animal");

    if (widget.animal != null)
      await animalDb.child(widget.animal.key).set(getAnimal);
    else
      await animalDb.push().set(getAnimal);

    Navigator.of(context).pop();
  }

  Map<String, dynamic> get getAnimal {
    Map<String, dynamic> data = Map();

    data['name'] = _nameController.text;
    data["age"] = _ageController.text;

    if (widget.animal != null && _petFile == null)
      data["image"] = widget.animal.image;
    else
      data["image"] = petImageUrl != null ? petImageUrl : "";

    return data;
  }

  Future<void> saveFirebase(String imageId) async {
    if (_petFile != null) {
      StorageReference imgStorageRef =
          FirebaseStorage.instance.ref().child("animal").child(imageId);

      StorageUploadTask imgUploadTask = imgStorageRef.putFile(_petFile);
      StorageTaskSnapshot imgStorageSnap = await imgUploadTask.onComplete;
      petImageUrl = await imgStorageSnap.ref.getDownloadURL();
    }
  }

  Widget showImage() {
    if (_petFile != null) return Image.file(_petFile);

    if (widget.animal != null && widget.animal.image != null)
      return FadeInImage.assetNetwork(
        image: widget.animal.image,
        fit: BoxFit.contain,
        placeholder: "assets/images/flying_dog.jpg",
      );

    return Image.asset("assets/images/flying_dog.jpg");
  }

  Future<void> imageSelectGalery() async {
    _petFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 700,
    );

    setState(() {});
  }
}
