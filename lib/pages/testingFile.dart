import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'FirebaseDataClass.dart';

class FirebaseDataClass extends StatefulWidget {
  const FirebaseDataClass({Key? key}) : super(key: key);

  @override
  State<FirebaseDataClass> createState() => _FirebaseDataClassState();
}

class _FirebaseDataClassState extends State<FirebaseDataClass> {
  File? _image;
  final picker = ImagePicker();

  // Controllers for different text fields
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  Future<void> getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No file selected");
      }
    });
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child("uploads/$fileName");

      await ref.putFile(_image!);
      String downloadUrl = await ref.getDownloadURL();

      // Parse price and rating to int or double
      int price = int.tryParse(priceController.text) ?? 0;
      int rating = int.tryParse(ratingController.text) ?? 0;

      await FirebaseFirestore.instance.collection("Images").add({
        'url': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'price': price,
        'rating': rating,
        'description': descriptionController.text,
        'title': titleController.text,
      });

      print("Upload successful: $downloadUrl");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: getImageGallery,
              child: SizedBox(
                height: 60,
                child: Center(
                  child: CircleAvatar(
                    radius: 100,
                    child: _image != null
                        ? ClipOval(
                      child: Image.file(
                        _image!.absolute,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Text("Select Image"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFieldWidget(controller: priceController, hint: "Price"),
          SizedBox(height: 20),
          TextFieldWidget(controller: ratingController, hint: "Rating"),
          SizedBox(height: 20),
          TextFieldWidget(controller: descriptionController, hint: "Description"),
          SizedBox(height: 20),
          TextFieldWidget(controller: titleController, hint: "Title"),
          SizedBox(height: 20),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextButton(
              onPressed: uploadImage,
              child: Text("Upload Image"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirebaseData()));
              },
              child: Text("getData"),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  TextFieldWidget({Key? key, required this.controller, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
