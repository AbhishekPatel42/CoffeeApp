import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/authPages/forgotPassword.dart';
import 'package:flutterapp/pages/profile.dart';
import '../utils/colors.dart';
import 'tramAndCondition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.secondry,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 50),
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
            SizedBox(height: 10),
            // Center(
            //   child: CircleAvatar(
            //     radius: 50, // Adjust the radius as needed
            //     backgroundImage: NetworkImage(user?.photoURL ?? 'https://example.com/default-profile.png'), // Provide a default image URL if null
            //   ),
            // ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Welcome, ",
                  style: TextStyle(fontSize: 23, color: appColors.primary),
                ),
              ],
            ),
            Text(
              user?.displayName ?? "User",
              style: TextStyle(fontSize: 23, color: Colors.white),
            ),
           // SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(
            //       "Email: ",
            //       style: TextStyle(fontSize: 16, color: appColors.primary),
            //     ),
            //     Text(
            //       user?.email ?? "Not Available",
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ],
            // ),
            //SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(
            //       "Mobile: ",
            //       style: TextStyle(fontSize: 16, color: appColors.primary),
            //     ),
            //     Text(
            //       user?.phoneNumber ?? "Not Available",
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ],
            // ),
            SizedBox(height: 20),
            _buildMenuItem("Change Password", "assets/changepass.png", () {
              // Navigate to Change Password Page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword(word: "RESEND",)));
            }),
            SizedBox(height: 20),
            _buildMenuItem("Profile Page", "assets/account.png", () {
              // Navigate to Profile Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
            }),
            SizedBox(height: 20),
            _buildMenuItem("Terms & Conditions", "assets/tram.png", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Tramandcondition()));
            }),
            SizedBox(height: 20),
            _buildMenuItem("Cart", "assets/cart.png", () {
              // Navigate to Cart Page
            }),
            SizedBox(height: 15),
            _buildLogoutMenuItem(),
          ],
        ),
      ),
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
                          Navigator.pop(context); // Close the bottom sheet
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

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterapp/authPages/forgotPassword.dart';
// import 'package:flutterapp/pages/profile.dart';
// import '../utils/colors.dart';
// import 'tramAndCondition.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final User? user = FirebaseAuth.instance.currentUser;
//   UserModel? userData; // To hold user data from Firestore
//
//   @override
//   void initState() {
//     super.initState();
//     _getUserData(); // Fetch user data when the page is initialized
//   }
//
//   Future<void> _getUserData() async {
//     if (user != null) {
//       DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
//       if (doc.exists) {
//         setState(() {
//           userData = UserModel.fromMap(doc.data() as Map<String, dynamic>);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColors.secondry,
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, top: 50),
//               child: Row(
//                 children: [
//                   Text(
//                     "It's Great",
//                     style: TextStyle(fontSize: 23, color: Colors.white),
//                   ),
//                   Text(
//                     " Day for ",
//                     style: TextStyle(fontSize: 23, color: appColors.primary),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               "Coffee",
//               style: TextStyle(fontSize: 23, color: appColors.primary),
//             ),
//             SizedBox(height: 10),
//             Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(userData?.profilePhotoUrl ?? 'https://example.com/default-profile.png'),
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   "Welcome, ",
//                   style: TextStyle(fontSize: 23, color: appColors.primary),
//                 ),
//               ],
//             ),
//             Text(
//               userData?.name ?? "User",
//               style: TextStyle(fontSize: 23, color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   "Email: ",
//                   style: TextStyle(fontSize: 16, color: appColors.primary),
//                 ),
//                 Text(
//                   userData?.email ?? "Not Available",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   "Mobile: ",
//                   style: TextStyle(fontSize: 16, color: appColors.primary),
//                 ),
//                 Text(
//                   userData?.phoneNumber ?? "Not Available",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             _buildMenuItem("Change Password", "assets/changepass.png", () {
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword(word: "RESEND",)));
//             }),
//             SizedBox(height: 20),
//             _buildMenuItem("Profile Page", "assets/account.png", () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
//             }),
//             SizedBox(height: 20),
//             _buildMenuItem("Terms & Conditions", "assets/tram.png", () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Tramandcondition()));
//             }),
//             SizedBox(height: 20),
//             _buildMenuItem("Cart", "assets/cart.png", () {
//               // Navigate to Cart Page
//             }),
//             SizedBox(height: 15),
//             _buildLogoutMenuItem(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMenuItem(String title, String imageUrl, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Image.asset(imageUrl, color: appColors.primary, height: 30),
//           SizedBox(width: 15),
//           Text(title, style: TextStyle(fontSize: 16, color: appColors.primary)),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios, color: appColors.primary),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogoutMenuItem() {
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(
//           backgroundColor: Colors.grey[900],
//           context: context,
//           builder: (context) {
//             return Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appColors.primary)),
//                   SizedBox(height: 10),
//                   Text("Are you sure you want to log out?", style: TextStyle(color: appColors.primary)),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           await FirebaseAuth.instance.signOut();
//                           Navigator.pop(context); // Close the bottom sheet
//                         },
//                         child: Text("Logout", style: TextStyle(color: Colors.white)),
//                         style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[600]),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context); // Close the bottom sheet
//                         },
//                         child: Text("Cancel", style: TextStyle(color: appColors.primary)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//       child: Row(
//         children: [
//           Image.asset(
//             "assets/logout.png",
//             color: appColors.primary,
//             height: 30,
//           ),
//           SizedBox(width: 15),
//           Text("Logout", style: TextStyle(fontSize: 16, color: appColors.primary)),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios, color: appColors.primary),
//         ],
//       ),
//     );
//   }
// }
//
// class UserModel {
//   String id;
//   String name;
//   String profilePhotoUrl;
//   String phoneNumber;
//   String email;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.profilePhotoUrl,
//     required this.phoneNumber,
//     required this.email,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'profilePhotoUrl': profilePhotoUrl,
//       'phoneNumber': phoneNumber,
//       'email': email,
//     };
//   }
//
//   static UserModel fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'],
//       name: map['name'],
//       profilePhotoUrl: map['profilePhotoUrl'],
//       phoneNumber: map['phoneNumber'],
//       email: map['email'],
//     );
//   }
// }
