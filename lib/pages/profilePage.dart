import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/authPages/forgotPassword.dart';
import 'package:flutterapp/pages/myCart.dart';
import 'package:flutterapp/pages/profile.dart';
import '../utils/colors.dart';
import 'tramAndCondition.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    // Simulate a delay for loading
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Change loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height; // Fixed the casing

    return Scaffold(
      backgroundColor: appColors.secondry,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Dynamic padding
        child: isLoading ? _buildShimmerEffect() : _buildProfileContent(screenWidth, screenHeight), // Pass dimensions
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80),
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            width: 150,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 30,
            width: 250,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        for (int i = 0; i < 5; i++)
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 40,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 15),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileContent(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02, top: screenHeight * 0.05),
          child: Row(
            children: [
              Text(
                "It's Great",
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
              Text(
                " Day for ",
                style: TextStyle(fontSize: 23, color: appColors.primary),
              ),
            ],
          ),
        ),
        Text(
          "Coffee",
          style: TextStyle(fontSize: 23, color: appColors.primary),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          children: [
            Text(
              "Welcome, ",
              style: TextStyle(fontSize: 23, color: appColors.primary),
            ),
          ],
        ),
        Text(
          user?.displayName ?? "",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        SizedBox(height: screenHeight * 0.02),
        _buildMenuItem("Change Password", "assets/changepass.png", () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword(word: "RESEND")));
        }),
        SizedBox(height: screenHeight * 0.02),
        _buildMenuItem("Profile Page", "assets/account.png", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
        }),
        SizedBox(height: screenHeight * 0.02),
        _buildMenuItem("Terms & Conditions", "assets/tram.png", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Tramandcondition()));
        }),
        SizedBox(height: screenHeight * 0.02),
        _buildMenuItem("Cart", "assets/cart.png", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
        }),
        SizedBox(height: screenHeight * 0.02),
        _buildLogoutMenuItem(),
      ],
    );
  }

  Widget _buildMenuItem(String title, String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imageUrl, color: appColors.primary, height: 30),
          SizedBox(width: 15),
          Text(title, style: TextStyle(fontSize: 16, color: appColors.primary)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: appColors.primary),
        ],
      ),
    );
  }

  Widget _buildLogoutMenuItem() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.grey[900],
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.primary)),
                  SizedBox(height: 10),
                  Text("Are you sure you want to log out?", style: TextStyle(color: appColors.primary)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: Text("Logout", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[600]),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel", style: TextStyle(color: appColors.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Image.asset(
            "assets/logout.png",
            color: appColors.primary,
            height: 30,
          ),
          SizedBox(width: 15),
          Text("Logout", style: TextStyle(fontSize: 16, color: appColors.primary)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: appColors.primary),
        ],
      ),
    );
  }
}
