import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/authPages/LoginPage.dart';
import 'package:flutterapp/utils/colors.dart';

class ForgotPassword extends StatefulWidget {
  final String word;
  const ForgotPassword({super.key,required this.word});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await auth.sendPasswordResetEmail(email: _emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarAnimationStyle: AnimationStyle(),
          SnackBar(content: Text('Password reset link sent your email!')),
        );

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text("Alert Dialog"),
        //       content: Text("Dialog Content"),
        //       actions: [
        //         TextButton(
        //           child: Text("Close"),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         )
        //       ],
        //     );
        //   },
        // );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginpage()));
        // Optionally navigate back or to another page
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred ')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  var value;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appColors.secondry,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03)
              .copyWith(top: screenHeight * 0.04),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/splashLogo.png",
                      height: screenHeight * 0.298,
                    ),
                  ),
                  Center(
                    child: Text(
                      "${widget.word} PASSWORD",
                      style: TextStyle(fontSize: 24, color: appColors.primary),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "           We have sent you email to\n recover password, please check email",
                      style: TextStyle(
                        color: appColors.primary,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Enter a valid Email!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: appColors.primary,
                      ),
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(color: appColors.primary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appColors.primary),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: appColors.primary,
                      ),
                      child: TextButton(
                        onPressed: () {
                          //if (value == null || value.isEpty ){
                          _submit();
                          // }else{
                          //    Navigator.pop(context);
                          //  }
                        },

                        //_submit,
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Send OTP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
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
