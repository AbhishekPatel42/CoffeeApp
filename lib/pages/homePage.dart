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
// import 'FirebaseDataClass.dart'; // Ensure this import path is correct
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
//   @override
//   void initState() {
//     super.initState();
//     _fetchImageUrl();
//   }
//
//   Future<void> _fetchImageUrl() async {
//     try {
//       // Reference to the image in Firebase Storage
//       final ref = FirebaseStorage.instance.ref('path/to/your/image.jpg');
//       // Get the download URL
//       String url = await ref.getDownloadURL();
//       setState(() {
//         profilePhotoUrl = url;
//         isLoading = false; // Set loading to false once URL is fetched
//       });
//     } catch (e) {
//       print('Error fetching image URL: $e');
//       setState(() {
//         isLoading = false; // Set loading to false even on error
//       });
//     }
//   }
//
//
//   String? profilePhotoUrl;
//   final List<String> myList = [
//     'Black Coffee',
//     'Tea',
//     'Coffee',
//   ];
//
//   final List<GridData> myGridData = [
//     GridData(rating: 3, sub: "Made by diluting water.", title: "Black Coffee", price: 300,img: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240,img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 340,img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
//     GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 440,img: "https://as2.ftcdn.net/v2/jpg/06/85/54/27/1000_F_685542763_MmepawqhoVhvsIVnAwMwTkgp25oJuB1b.jpg"),
//   ];
//
//   final List<myListData> myListString =[
//     myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300,img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
//     // myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300,img: "https://indianfoodfreak.com/wp-content/uploads/2023/05/IMG_20230521_162825.jpg"),
//     // myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300,img: "https://indianfoodfreak.com/wp-content/uploads/2023/05/IMG_20230521_162825.jpg"),
//   ];
//
//   final ref = FirebaseStorage.instance.ref('path/to/your/image.jpg');
//   //String url = await ref.getDownloadURL();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: appColors.secondry,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 22.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               _buildHeader(),
//               _buildSearchField(),
//               SizedBox(height: 20),
//               _buildCategorySelector(),
//               _buildSeeMoreLink(),
//               CoffeeListMain(myGridData),
//               SizedBox(height: 10),
//              _buildSpecialForYouTitle(),
//               _buildSeeMoreLink(),
//               specialForYou(myListString),
//             // BottomBar(),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// final User? user = FirebaseAuth.instance.currentUser;
//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 35),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseDataClass()));
//             },
//             child: Image.asset("assets/splashLogo.png", height: 60),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
//             },
//             child: Center(
//               child: CircleAvatar(
//                 backgroundImage: isLoading
//                     ? AssetImage("assets/loading_placeholder.png") // Add a loading placeholder image
//                     : NetworkImage(
//                     profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchField() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search, color: appColors.primary),
//               hintText: "Find your coffee...",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//             ),
//           ),
//         ),
//         Icon(Icons.filter_list, color: appColors.primary, size: 39),
//       ],
//     );
//   }
//
//   Widget _buildCategorySelector() {
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
//             padding: EdgeInsets.all(16.0),
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
// Widget CoffeeListMain(List<GridData> gridData) {
//   return Container(
//     child: GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: gridData.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
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
//
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
//                     SizedBox(height: 5),
//                     Center(
//                       child: Container(
//                         height: 87,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                                 gridData[index].img
//                                 //"https://img.freepik.com/free-photo/delicious-coffee-beans-cup_23-2150691429.jpg"),
//                             ),fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
// Widget specialForYou(List<myListData> myData) {
//   return Container(
//     height: 200,
//     child: ListView.builder(
//       // scrollDirection: Axis.horizontal,
//       itemCount: myData.length, // Set itemCount to myData.length
//       // physics: NeverScrollableScrollPhysics(),
//       // shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DetailPage(
//                   tetile  : myData[index].title,
//                   reting: myData[index].rating,
//                   disc: myData[index].sub,
//                   price: myData[index].price,
//                   img: myData[index].img,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             height: 120,
//             width: 120,
//             // width: double.infinity, // Set a fixed width
//             margin: EdgeInsets.only(right: 10), // Add margin for spacing
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
//                   height: 100,
//                   width: 120,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         myData[index].title,
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       Text(
//                         myData[index].sub, // Use the correct subtitle
//                         style: TextStyle(color: Colors.white, fontSize: 11),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 8),
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
//                               Text("4.3", style: TextStyle(color: Colors.white)), // Consider making this dynamic if ratings are available
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
//         );
//       },
//     ),
//   );
// }
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/DitailPage.dart';
import 'package:flutterapp/pages/profile.dart';
import 'package:flutterapp/pages/testingFile.dart';
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
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  bool isLoading = true;
  String? profilePhotoUrl;

  @override
  void initState() {
    super.initState();
    _fetchImageUrl();
  }

  Future<void> _fetchImageUrl() async {
    try {
      final ref = FirebaseStorage.instance.ref('path/to/your/image.jpg');
      String url = await ref.getDownloadURL();
      setState(() {
        profilePhotoUrl = url;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching image URL: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  final List<String> myList = ['Black Coffee', 'Tea', 'Coffee'];
  final List<GridData> myGridData = [
    GridData(rating: 3, sub: "Made by diluting water.", title: "Black Coffee", price: 300, img: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
    GridData(rating: 4, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240, img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
    GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 340, img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    GridData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 440, img: "https://as2.ftcdn.net/v2/jpg/06/85/54/27/1000_F_685542763_MmepawqhoVhvsIVnAwMwTkgp25oJuB1b.jpg"),
  ];

  final List<myListData> myListString = [
    myListData(rating: 3, sub: "Made by diluting.", title: "Cappuccino", price: 300, img: "https://images.unsplash.com/photo-1648192312898-838f9b322f47?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWFuJTIwdGVhfGVufDB8fDB8fHww"),
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
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: screenHeight * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseDataClass()));
            },
            child: Image.asset("assets/splashLogo.png", height: screenHeight * 0.08),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
            },
            child: Center(
              child: CircleAvatar(
                backgroundImage: isLoading
                    ? AssetImage("assets/loading_placeholder.png")
                    : NetworkImage(profilePhotoUrl ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
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
                borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.05)),
              ),
            ),
          ),
        ),
        Icon(Icons.filter_list, color: appColors.primary, size: screenWidth * 0.1),
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
              color: selectedIndex == index ? appColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              myList[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : appColors.primary,
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
      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.right,
    );
  }
}

Widget CoffeeListMain(List<GridData> gridData, double screenWidth, double screenHeight) {
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
            Navigator.push(context, MaterialPageRoute(
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
                    SizedBox(height: screenHeight * 0.01),
                    Center(
                      child: Container(
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.3,
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
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
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
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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

Widget specialForYou(List<myListData> myData, double screenWidth, double screenHeight) {
  return Container(
    height: screenHeight * 0.3,
    child: ListView.builder(
      itemCount: myData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  tetile: myData[index].title,
                  reting: myData[index].rating,
                  disc: myData[index].sub,
                  price: myData[index].price,
                  img: myData[index].img,
                ),
              ),
            );
          },
          child: Container(
            height: screenHeight * 0.15,
            width: screenWidth * 0.8,
            margin: EdgeInsets.only(right: screenWidth * 0.02),
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
                      image: NetworkImage(myData[index].img),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        myData[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        myData[index].sub,
                        style: TextStyle(color: Colors.white, fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹${myData[index].price}",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Text("4.3", style: TextStyle(color: Colors.white)),
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
      },
    ),
  );
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


