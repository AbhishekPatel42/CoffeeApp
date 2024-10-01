import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutterapp/authPages/CreateAcount.dart';
import 'package:flutterapp/authPages/forgotPassword.dart';
import 'package:flutterapp/utils/colors.dart';
import 'package:flutterapp/utils/compontes.dart'; // Assuming you have this utility
import 'package:google_sign_in/google_sign_in.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscured = true;
  bool isLoading = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      await signInWithEmailAndPassword();
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      emailController.clear();
      passwordController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<User?> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        String message;
        switch (result.status) {
          case LoginStatus.cancelled:
            message = 'Login was cancelled. Please try again.';
            break;
          case LoginStatus.failed:
            message = 'Login failed. Please check your credentials.';
            break;
          default:
            message = 'An unknown error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error during Facebook login: ${e.toString()}')));
      return null;
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
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04).copyWith(top: screenHeight * 0.04),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                      "LOGIN",
                      style: TextStyle(fontSize: 24, color: appColors.primary),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded, color: appColors.primary),
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: _obscured,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          size: 24,
                          color: appColors.primary,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: appColors.primary),
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: SizedBox(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.5,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                            : Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: Text(
                      "--OR--",
                      style: TextStyle(color: appColors.primary, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            User? user = await _signInWithGoogle();
                            if (user != null) {
                              print("User signed in: ${user.displayName}");
                              // Navigate to your main app screen
                            }
                          },
                          child: Image.asset("assets/googleIcon.png", height: screenHeight * 0.04),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        GestureDetector(
                          onTap: () async {
                            User? user = await _signInWithFacebook();
                            if (user != null) {
                              print("User signed in: ${user.displayName}");
                              // Navigate to your main app screen
                            }
                          },
                          child: Image.asset("assets/facebookIcon.png", height: screenHeight * 0.05),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword(word: "FORGOT",)));
                          },
                          child: Text("Forgot Password", style: TextStyle(color: appColors.primary)),
                        ),
                        Text("|", style: TextStyle(color: appColors.primary, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAcount()));
                          },
                          child: Text("Create Account", style: TextStyle(color: appColors.primary)),
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
