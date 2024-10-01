import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/authPages/LoginPage.dart';
import 'package:flutterapp/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateAcount extends StatefulWidget {
  const CreateAcount({Key? key}) : super(key: key);

  @override
  State<CreateAcount> createState() => _CreateAcountState();
}

class _CreateAcountState extends State<CreateAcount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscured = true;
  bool _isLoading = false;
  String? _profilePhotoUrl;
  final ImagePicker _picker = ImagePicker();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await _addUserData(userCredential.user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      } on FirebaseAuthException catch (e) {
        _handleFirebaseAuthError(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _addUserData(User? user) async {
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phoneNumber': _numberController.text,
        'profilePhotoUrl': _profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      });
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The account already exists for that email.';
    } else {
      message = 'An error occurred. Please try again.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Future<void> _pickImage() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     await _uploadImage(File(image.path));
  //   }
  // }

  // Future<void> _uploadImage(File imageFile) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     String fileName = 'profile_photos/${FirebaseAuth.instance.currentUser!.uid}.jpg';
  //     Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
  //     await storageRef.putFile(imageFile);
  //     _profilePhotoUrl = await storageRef.getDownloadURL();
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image')));
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appColors.secondry,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04).copyWith(top: screenHeight * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/splashLogo.png",
                      height: screenHeight * 0.25,
                    ),
                  ),

                  Center(
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(fontSize: 24, color: appColors.primary),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded, color: appColors.primary),
                      hintText: "Enter Your Full Name",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return "Enter a valid Email!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: appColors.primary),
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    controller: _numberController,
                    validator: (value) {
                      if (value == null || value.length != 10) {
                        return 'Mobile Number must be of 10 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: appColors.primary),
                      hintText: "Enter Your Number",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    obscureText: _obscured,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: appColors.primary),
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          size: 24,
                          color: appColors.primary,
                        ),
                      ),
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: appColors.primary,
                      ),
                      child: TextButton(
                        onPressed: _createUser,
                        child: _isLoading
                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                            : Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: Text("--OR--", style: TextStyle(color: appColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(height: screenHeight * 0.07),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You already have an account?", style: TextStyle(color: appColors.primary, fontWeight: FontWeight.w600)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Loginpage()),
                            );
                          },
                          child: Text("Sign In", style: TextStyle(color: appColors.primary)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
