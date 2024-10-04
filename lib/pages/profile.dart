import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterapp/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool _obscured = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController NumberController = TextEditingController();
  TextEditingController PassController = TextEditingController();

  bool isLoading = true; // Initially set to true for shimmer effect
  String? profilePhotoUrl;

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await usersCollection.doc(user.uid).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          NameController.text = data['name'] ?? '';
          EmailController.text = data['email'] ?? '';
          NumberController.text = data['phoneNumber'] ?? '';
          profilePhotoUrl = data['profilePhotoUrl'] ?? '';
          isLoading = false; // Set to false after loading data
        });
      }
    }
  }

  Future<void> updateProfile() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;

        // Update Firebase Auth profile
        await user?.updateProfile(displayName: NameController.text);
        await user?.updateEmail(EmailController.text);

        // Update password if it's provided
        if (PassController.text.isNotEmpty) {
          await user?.updatePassword(PassController.text);
        }

        // Update Firestore user data
        await updateUserData();

        await user?.reload(); // Reload to get updated info
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    }
  }

  Future<void> updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await usersCollection.doc(user.uid).set({
        'name': NameController.text,
        'email': EmailController.text,
        'phoneNumber': NumberController.text,
        'profilePhotoUrl': profilePhotoUrl ?? user.photoURL ?? 'default_profile_image_url',
      }, SetOptions(merge: true));
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    setState(() {
      isLoading = true;
    });

    try {
      String fileName = 'profile_photos/${FirebaseAuth.instance.currentUser!.uid}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

      // Upload the file to Firebase Storage
      var snapshot = await storageRef.putFile(imageFile);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        profilePhotoUrl = downloadUrl; // Update the profile photo URL
        isLoading = false;
      });

      // Update Firestore with new profile photo URL
      await updateUserData();
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image $e')));
    }
  }

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
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04).copyWith(top: screenHeight * 0.09),
          child: SingleChildScrollView(
            child: isLoading ? _buildShimmerEffect(screenHeight, screenWidth) : _buildProfileContent(screenHeight, screenWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 24,
            width: screenWidth * 0.5,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        ...List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[500]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                width: screenWidth * 0.8,
                color: Colors.white,
              ),
            ),
          );
        }),
        SizedBox(height: screenHeight * 0.03),
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: screenHeight * 0.06,
            width: screenWidth * 0.5,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 78),
              child: Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, color: appColors.primary, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        Center(
          child: Text(
            "My Account",
            style: TextStyle(fontSize: 24, color: appColors.primary),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        _buildTextFormField(NameController, "Enter your name", Icons.account_circle_rounded),
        SizedBox(height: screenHeight * 0.015),
        _buildTextFormField(EmailController, "Enter your email", Icons.email),
        SizedBox(height: screenHeight * 0.015),
        _buildTextFormField(NumberController, "Enter your mobile number", Icons.phone, keyboardType: TextInputType.number),
        SizedBox(height: screenHeight * 0.015),
        _buildPasswordField(),
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
              onPressed: updateProfile,
              child: isLoading
                  ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text("SAVE CHANGES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }

  TextFormField _buildTextFormField(TextEditingController controller, String hintText, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter Your $hintText";
        }
        if (controller == EmailController && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return "Enter a valid Email!";
        }
        if (controller == NumberController && value.length != 10) {
          return 'Mobile Number must be of 10 digits';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: appColors.primary),
        hintText: hintText,
        hintStyle: TextStyle(color: appColors.primary),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.primary),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: PassController,
      obscureText: _obscured,
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
        hintText: "Enter new password (optional)",
        hintStyle: TextStyle(color: appColors.primary),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.primary),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
}
