import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseData extends StatefulWidget {
  const FirebaseData({super.key});

  @override
  State<FirebaseData> createState() => _FirebaseDataState();
}

class _FirebaseDataState extends State<FirebaseData> {
  File? _image;
  final picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No file picked from the gallery");
      }
    });
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child("uploads/$fileName");
      await ref.putFile(_image!);
      String downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("Images").add({
        'url': downloadUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'title': 'Your Title', // Replace with actual input
        'description': 'Your Description', // Replace with actual input
        'price': 'Your Price', // Replace with actual input
      });

      print("Upload successful: $downloadUrl");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future deleteImage(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Images")
          .doc(documentId)
          .delete();
      print("Document ${documentId}deleted successfuly.");
    } catch (e) {
      print("Erorr deleting $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Image Upload"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              uploadImage();
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Images").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.active) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshots.data!.docs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc["url"] ?? ''),
                      ),
                      title: Text(doc["title"] ?? ''),
                      subtitle: Text(doc["description"] ?? ''),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteImage(doc.id);
                        },
                      ),
                    );
                  });
            } else if (snapshots.hasError) {
              return Center(
                child: Text("Error: ${snapshots.error}"),
              );
            } else {
              return Center(child: Text("No data available."));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImageFromGallery,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

