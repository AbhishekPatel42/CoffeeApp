// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterapp/pages/DitailPage.dart';
// import 'package:flutterapp/pages/profile.dart';
// import 'package:flutterapp/pages/testingFile.dart';
// import '../utils/colors.dart';
// import '../utils/compontes.dart';
// import 'TopRatingPage.dart';
// import 'FirebaseDataClass.dart';
//
// class Homepage extends StatefulWidget {
//   const Homepage({super.key});
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends State<Homepage> {
//   int selectedIndex = 0;
//   final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
//
//   bool isLoading = true;
//   String? profilePhotoUrl;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchImageUrl();
//   }
//
//   Future<void> _fetchImageUrl() async {
//     try {
//       final ref = FirebaseStorage.instance.ref('path/to/your/image.jpg');
//       String url = await ref.getDownloadURL();
//       setState(() {
//         profilePhotoUrl = url;
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching image URL: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   final List<String> myList = ['Black Coffee', 'Tea', 'Coffee'];
//   final List<GridData> myGridData = [
//     GridData(rating: 3, sub: "Made by diluting water.", title: "Black Coffee", price: 300, img: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240, img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 340, img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 440, img: "https://as2.ftcdn.net/v2/jpg/06/85/54/27/1000_F_685542763_MmepawqhoVhvsIVnAwMwTkgp25oJuB1b.jpg"),
//   ];
//
//   final List<myListData> myListString = [
//     myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300, img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
//     // myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300, img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
//     myListData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 340, img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
//     myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300, img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//
//     return Scaffold(
//       backgroundColor: appColors.secondry,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(screenHeight),
//               _buildSearchField(screenWidth),
//               SizedBox(height: screenHeight * 0.02),
//               _buildCategorySelector(screenWidth),
//               _buildSeeMoreLink(),
//               CoffeeListMain(myGridData, screenWidth, screenHeight),
//               SizedBox(height: screenHeight * 0.01),
//               _buildSpecialForYouTitle(),
//               _buildSeeMoreLink(),
//               specialForYou(myListString, screenWidth, screenHeight),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(double screenHeight) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: screenHeight * 0.05),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseDataClass()));
//             },
//             child: Image.asset("assets/splashLogo.png", height: screenHeight * 0.08),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
//             },
//             child: Center(
//               child: CircleAvatar(
//                 backgroundImage: isLoading
//                     ? AssetImage("assets/loading_placeholder.png")
//                     : NetworkImage(profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchField(double screenWidth) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search, color: appColors.primary),
//               hintText: "Find your coffee...",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.05)),
//               ),
//             ),
//           ),
//         ),
//         Icon(Icons.filter_list, color: appColors.primary, size: screenWidth * 0.1),
//       ],
//     );
//   }
//
//   Widget _buildCategorySelector(double screenWidth) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(myList.length, (index) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.all(screenWidth * 0.04),
//             decoration: BoxDecoration(
//               color: selectedIndex == index ? appColors.primary : Colors.transparent,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Text(
//               myList[index],
//               style: TextStyle(
//                 color: selectedIndex == index ? Colors.white : appColors.primary,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildSeeMoreLink() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Fullblackcoffeescrreen()),
//           );
//         },
//         child: Text(
//           "See more >>",
//           style: TextStyle(color: appColors.primary),
//           textAlign: TextAlign.right,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSpecialForYouTitle() {
//     return Text(
//       "Special for you",
//       style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       textAlign: TextAlign.right,
//     );
//   }
// }
//
// Widget CoffeeListMain(List<GridData> gridData, double screenWidth, double screenHeight) {
//   return Container(
//     child: GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: gridData.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisSpacing: screenWidth * 0.02,
//         mainAxisSpacing: screenWidth * 0.02,
//         crossAxisCount: 2,
//       ),
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) => DetailPage(
//                 tetile: gridData[index].title,
//                 disc: gridData[index].sub,
//                 reting: gridData[index].rating,
//                 price: gridData[index].price,
//                 img: gridData[index].img,
//               ),
//             ));
//           },
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[800],
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(height: screenHeight * 0.00),
//                     Center(
//                       child: Container(
//                         height: screenHeight * 0.12,
//                         width: screenWidth * 0.6,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                             image: NetworkImage(gridData[index].img),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             gridData[index].title,
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//                           ),
//                           Text(
//                             gridData[index].sub,
//                             style: TextStyle(color: Colors.white, fontSize: 12),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "₹${gridData[index].price}",
//                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(Icons.star, color: Colors.amber, size: 16),
//                                   Text(
//                                     gridData[index].rating.toString(),
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
//
// Widget specialForYou(List<myListData> myData, double screenWidth, double screenHeight) {
//   return Container(
//     child: ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.only(top: 10.0),
//       itemCount: myData.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DetailPage(
//                       tetile: myData[index].title,
//                       reting: myData[index].rating,
//                       disc: myData[index].sub,
//                       price: myData[index].price,
//                       img: myData[index].img,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 height: screenHeight * 0.15,
//                 width: screenWidth * 0.8,
//                 margin: EdgeInsets.only(right: screenWidth * 0.01),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[800],
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: appColors.primary,
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                           image: NetworkImage(myData[index].img),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       height: screenHeight * 0.15,
//                       width: screenWidth * 0.345,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             myData[index].title,
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                           Text(
//                             myData[index].sub,
//                             style: TextStyle(color: Colors.white, fontSize: 11),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: screenHeight * 0.01),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "₹${myData[index].price}",
//                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(Icons.star, color: Colors.amber, size: 16),
//                                   Text("4.3", style: TextStyle(color: Colors.white)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Add space between items
//           ],
//         );
//       },
//     ),
//   );
// }
//
//
// class myListData {
//   final String title;
//   final String sub;
//   final int rating;
//   final int price;
//   final String img;
//
//   const myListData({
//     required this.rating,
//     required this.sub,
//     required this.title,
//     required this.price,
//     required this.img,
//   });
// }
//
//
// class GridData {
//   final String title;
//   final String sub;
//   final int rating;
//   final int price;
//   final String img;
//
//   const GridData({
//     required this.rating,
//     required this.sub,
//     required this.title,
//     required this.price,
//     required this.img,
//   });
// }
//
//

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/DitailPage.dart';
import 'package:flutterapp/pages/profile.dart';
import 'package:flutterapp/pages/testingFile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/colors.dart';
import '../utils/compontes.dart';
import 'TopRatingPage.dart';
import 'FirebaseDataClass.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  bool isLoading = true;
  String? profilePhotoUrl;

  @override
  void initState() {
    super.initState();
    loadUserData();
    uploadNewImage(File('users'));
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await usersCollection.doc(user.uid).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          // NameController.text = data['name'] ?? '';
          // EmailController.text = data['email'] ?? '';
          // NumberController.text = data['phoneNumber'] ?? '';
          profilePhotoUrl = data['profilePhotoUrl'] ?? '';
          isLoading = false; // Set to false after loading data
        });
      }
    }
  }

  Future<void> uploadNewImage(File imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Upload the image to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_photos/${user.uid}');
      UploadTask uploadTask = storageRef.putFile(imageFile);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the Firestore document with the new image URL
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'profilePhotoUrl': downloadUrl,
      });
    }
  }

  final List<String> myList = ['Black Coffee', 'Tea', 'Coffee'];
  final List<GridData> myGridData = [
    GridData(
        rating: 3,
        sub: "Made by diluting water.",
        title: "Black Coffee",
        price: 300,
        img:
            "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
    GridData(
        rating: 4,
        sub: "With Oa 1 Milk",
        title: "Cappuccino",
        price: 240,
        img:
            "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
    GridData(
        rating: 4,
        sub: "With Oa 1 Milk",
        title: "Latte",
        price: 340,
        img:
            "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    GridData(
        rating: 4,
        sub: "With Oa 1 Milk",
        title: "Latte",
        price: 440,
        img:
            "https://as2.ftcdn.net/v2/jpg/06/85/54/27/1000_F_685542763_MmepawqhoVhvsIVnAwMwTkgp25oJuB1b.jpg"),
  ];

  final List<myListData> myListString = [
    myListData(
        rating: 3,
        sub: "Made by diluting.",
        title: "Cappuccino",
        price: 300,
        img:
            "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
    // myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300, img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
    myListData(
        rating: 4,
        sub: "With Oa 1 Milk",
        title: "Latte",
        price: 340,
        img:
            "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    myListData(
        rating: 3,
        sub: "Made by diluting.",
        title: "Cappuccino",
        price: 300,
        img:
            "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: appColors.secondry,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(screenHeight),
              _buildSearchField(screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildCategorySelector(screenWidth),
              _buildSeeMoreLink(),
              CoffeeListMain(myGridData, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _buildSpecialForYouTitle(),
              _buildSeeMoreLink(),
              specialForYou(myListString, screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 15.0, vertical: screenHeight * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirebaseDataClass()));
            },
            child: Image.asset("assets/splashLogo.png",
                height: screenHeight * 0.08),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
            child: Center(
              child: CircleAvatar(
                //backgroundImage:
                backgroundImage: NetworkImage(profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                // isLoading
                //     ? AssetImage("assets/loading_placeholder.png")
                //     : NetworkImage(profilePhotoUrl ??
                //         'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: appColors.primary),
              hintText: "Find your coffee...",
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(screenWidth * 0.05)),
              ),
            ),
          ),
        ),
        Icon(Icons.filter_list,
            color: appColors.primary, size: screenWidth * 0.1),
      ],
    );
  }

  Widget _buildCategorySelector(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(myList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? appColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              myList[index],
              style: TextStyle(
                color:
                    selectedIndex == index ? Colors.white : appColors.primary,
                fontSize: 16,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSeeMoreLink() {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Fullblackcoffeescrreen()),
          );
        },
        child: Text(
          "See more >>",
          style: TextStyle(color: appColors.primary),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildSpecialForYouTitle() {
    return Text(
      "Special for you",
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.right,
    );
  }
}

Widget shimmerLoadingCoffeeItem(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[500]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: width * 0.6,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 4),
                Container(
                  height: 10,
                  width: width * 0.4,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: width * 0.3,
                      color: Colors.grey[400],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: Colors.grey[400],
                        ),
                        SizedBox(width: 4),
                        Container(
                          height: 10,
                          width: 10,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget CoffeeListMain(
    List<GridData> gridData, double screenWidth, double screenHeight) {
  if (gridData.isEmpty) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4, // Number of shimmer loading placeholders
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: screenWidth * 0.02,
        mainAxisSpacing: screenWidth * 0.02,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return shimmerLoadingCoffeeItem(screenWidth * 0.6, screenHeight * 0.15);
      },
    );
  }

  return Container(
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: gridData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: screenWidth * 0.02,
        mainAxisSpacing: screenWidth * 0.02,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    tetile: gridData[index].title,
                    disc: gridData[index].sub,
                    reting: gridData[index].rating,
                    price: gridData[index].price,
                    img: gridData[index].img,
                  ),
                ));
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.00),
                    Center(
                      child: Container(
                        height: screenHeight * 0.12,
                        width: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(gridData[index].img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gridData[index].title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            gridData[index].sub,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹${gridData[index].price}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text(
                                    gridData[index].rating.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget specialForYou(
    List<myListData> myData, double screenWidth, double screenHeight) {
  return Container(
    //color: Colors.tealAccent,
    child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Images").snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.active) {
          if (snapshots.hasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10.0),
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshots.data!.docs[index];
                return Container(
                 // color: Colors.amber,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                tetile: doc["title"] ?? '',
                                reting: doc["rating"] ?? 0.0,
                                disc: doc["description"] ?? '',
                                price: doc["price"] ?? 0,
                                img: doc["url"] ?? '',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.9,
                          margin: EdgeInsets.only(right: screenWidth * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: appColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(doc["url"] ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.345,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      doc["title"] ?? '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(

                                      doc["description"] ?? '',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₹${(doc["price"] ?? 0).toString()}",

                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),SizedBox(
                                          width: screenWidth*0.340,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            Text((doc["rating"] ?? 0).toString(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          }
        }

        // Show shimmer effect when loading
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5, // Number of shimmer loading placeholders
          itemBuilder: (context, index) {
            return shimmerLoadingContainer(screenWidth * 0.8, screenHeight * 0.15);
          },
        );
      },
    ),
  );
}


Widget shimmerLoadingContainer(double width, double height) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


class ItemCount extends StatefulWidget {
  const ItemCount({super.key});

  @override
  State<ItemCount> createState() => _ItemCountState();
}

class _ItemCountState extends State<ItemCount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          //deleteImage(doc.id);
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
    );
  }
}

class myListData {
  final String title;
  final String sub;
  final int rating;
  final int price;
  final String img;

  const myListData({
    required this.rating,
    required this.sub,
    required this.title,
    required this.price,
    required this.img,
  });
}

class GridData {
  final String title;
  final String sub;
  final int rating;
  final int price;
  final String img;

  const GridData({
    required this.rating,
    required this.sub,
    required this.title,
    required this.price,
    required this.img,
  });
}


// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   padding: EdgeInsets.only(top: 10.0),
//   itemCount: myData.length,
//   itemBuilder: (context, index) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DetailPage(
//                   tetile: myData[index].title,
//                   reting: myData[index].rating,
//                   disc: myData[index].sub,
//                   price: myData[index].price,
//                   img: myData[index].img,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             height: screenHeight * 0.15,
//             width: screenWidth * 0.8,
//             margin: EdgeInsets.only(right: screenWidth * 0.01),
//             decoration: BoxDecoration(
//               color: Colors.grey[800],
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: appColors.primary,
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: NetworkImage(myData[index].img),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   height: screenHeight * 0.15,
//                   width: screenWidth * 0.345,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         myData[index].title,
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       Text(
//                         myData[index].sub,
//                         style: TextStyle(color: Colors.white, fontSize: 11),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: screenHeight * 0.01),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "₹${myData[index].price}",
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.star, color: Colors.amber, size: 16),
//                               Text("4.3", style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 10), // Add space between items
//       ],
//     );
//   },
// ),