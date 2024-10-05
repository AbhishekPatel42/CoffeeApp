// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/colors.dart';
//
// class DetailPage extends StatefulWidget {
//   final tetile, disc, reating, price, img;
//   const DetailPage(
//       {super.key,
//       required this.tetile,
//       required this.disc,
//       this.reating,
//       this.price,
//       this.img});
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   int selectedSizeIndex = 0; // Track the selected size index
//   final List<String> sizes = ["S", "M", "L"];
//   int _count = 0;
//
//   void _increment() {
//     setState(() {
//       _count++;
//     });
//   }
//
//   void _dicrement() {
//     if (_count > 0) {
//       setState(() {
//         _count--;
//       });
//     }
//   }
//
//  final List<AddToCart> myCart =[
//
//  ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Container(
//         width: 330,
//         decoration: BoxDecoration(
//         //  color: Colors.pink
//         ),
//         child: FloatingActionButton(
//          backgroundColor: appColors.primary,
//           onPressed: () {},
//           child: Center(
//             child: Center(child: Text("Add to Cart",style: TextStyle(
//               fontSize: 18,
//               color: Colors.white
//             ),)),
//           ),
//         ),
//       ),
//       backgroundColor: appColors.secondry,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 30,
//                   )),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: appColors.primary,
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                   image: NetworkImage(
//                     widget.img.toString(),
//                     // "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               height: 400,
//               width: double.infinity,
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.tetile,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     widget.disc.toString(),
//                     // "A rich and bold coffee brewed by forcing hot water through finely-ground coffee beans. It’s the foundation for many coffee drinks and has a strong, concentrated flavor with a velvety crema on top.",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     "Size",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(sizes.length, (index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedSizeIndex = index; // Update selected index
//                           });
//                         },
//                         child: Container(
//                           height: 45,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[900],
//                             // color: selectedSizeIndex == index
//                             //     ? appColors.primary // Highlight selected
//                             //     : Colors.grey[800],
//                             border: Border.all(
//                                 color: selectedSizeIndex == index
//                                     ? appColors.primary
//                                     : Colors.black12),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Center(
//                             child: Text(
//                               sizes[index],
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 25,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("₹${widget.price.toString()}",
//                           //"₹400",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold)),
//                       SizedBox(
//                         width: 13,
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.amber, size: 16),
//                           Text("4.3", style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       SizedBox(
//                           height: 28,
//                           // width: 50,
//                           child: Container(
//                             decoration: BoxDecoration(color: Colors.grey[6]),
//                             child: Container(
//                               child: ElevatedButton(
// style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColors.primary),),
//                                   onPressed: _dicrement,
//                                   child: Center(
//                                       child: Text("-",
//                                           style: TextStyle(fontSize: 20,color: Colors.white)))),
//                             ),
//                           )),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "$_count",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       SizedBox(
//                           //width: 30,
//                           height: 30,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor:
//                               MaterialStateProperty.all(appColors.primary),
//                             ),
//                               onPressed: _increment,
//                               child: Center(
//                                   child: Text(
//                                 "+",
//                                 style: TextStyle(color: Colors.white, fontSize: 20),
//                               )))),
//                       SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     //width: 10,
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: Container(
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: appColors.primary,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Center(
//                           child: Text(
//                         "Buy Now",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       )),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   Row(
//                     children: [
//                       Text(
//                         "Additional Types",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   // Additional coffee types and their descriptions
//                   CoffeeTypeDetail(
//                     name: "Americano",
//                     description:
//                         "Made by diluting espresso with hot water, offering a similar strength to brewed coffee.",
//                   ),
//                   CoffeeTypeDetail(
//                     name: "Latte",
//                     description:
//                         "A creamy blend of espresso and steamed milk, topped with a light froth.",
//                   ),
//                   CoffeeTypeDetail(
//                     name: "Cappuccino",
//                     description:
//                         "A rich mix of espresso, steamed milk, and a thick layer of froth.",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CoffeeTypeDetail extends StatelessWidget {
//   final String name;
//   final String description;
//
//   const CoffeeTypeDetail(
//       {Key? key, required this.name, required this.description})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.grey[800],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             name,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             description,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class AddToCart {
//   final String titel;
//   final String sub;
//   final int price;
//   final int reting;
//
//   const AddToCart ({
//     required this.titel,
//     required this.sub,
//     required this.price,
//     required this.reting,
// });
// }
//

import 'package:flutter/material.dart';
import 'package:flutterapp/utils/colors.dart';
import '../utils/compontes.dart';
import '../utils/dbHelper.dart';
// import 'database_helper.dart';
import 'TopRatingPage.dart';
import 'homePage.dart';
import 'models.dart';
import 'myCart.dart';

class DetailPage extends StatefulWidget {
  final String tetile, disc;
  final int? reting;
  final int? price;
  final String img;

  const DetailPage({
    Key? key,
    required this.tetile,
    required this.disc,
//    this.reating,
    required this.reting,
    this.price,
    required this.img,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedSizeIndex = 0;
  final List<String> sizes = ["S", "M", "L"];
  int _count = 1;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _dicrement() {
    if (_count > 1) {
      setState(() {
        _count--;
      });
    }
  }

  final List< myListData> showFullData = [
    //  ShowData(reting: 3, sub: "Made by diluting espresso with hot water.", titel: "Black Coffee", price: 300,image: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Cappuccino", price: 240,image: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Latte", price: 240,image: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Latte", price: 240,image: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    myListData(
        rating: 3,
        sub: "Made by water.",
        title: "Black Coffee",
        price: 300,
        img:
            "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
    myListData(
        rating: 4,
        sub: "With Oa 1 Milk",
        title: "Cappuccino",
        price: 240,
        img:
            "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
    // myListData(
    //     rating: 5,
    //     sub: "With Oa 1 Milk",
    //     title: "Latte",
    //     price: 240,
    //     img:
    //         "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    // myListData(
    //     rating: 4,
    //     sub: "With Oa 1 Milk",
    //     title: "Latte",
    //     price: 240,
    //     img:
    //         "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    // myListData(
    //     rating: 3,
    //     sub: "With Oa 1 Milk",
    //     title: "Cappuccino",
    //     price: 240,
    //     img:
    //         "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),

    // myListData(
    //     rating: 3,
    //     sub: "Made by hot water.",
    //     title: "Black Coffee",
    //     price: 300,
    //     img:
    //         "https://t4.ftcdn.net/jpg/04/00/52/13/360_F_400521390_uWn8KdMCXK9V5Gkp3dVGOAyKsqQok03V.jpg"),
    // myListData(
    //     rating: 4,
    //     sub: "With Oa 1 Milk",
    //     title: "Latte",
    //     price: 240,
    //     img:
    //         "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    // myListData(
    //     rating: 5,
    //     sub: "With Oa 1 Milk",
    //     title: "Cappuccino",
    //     price: 240,
    //     img:
    //         "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   width: 330,
      //   child: FloatingActionButton(
      //     backgroundColor: appColors.primary, // Change to your color
      //     onPressed: () async {
      //       final newItem = AddToCart(
      //         itemCount: _count,
      //         titel: widget.tetile,
      //         sub: widget.disc,
      //         price: widget.price!,
      //         reting: widget.reting!,
      //         img: widget.img,
      //       );
      //       await DatabaseHelper().insertCart(newItem);
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Item added to cart!')),
      //       );
      //     },
      //     child: Center(
      //       child: Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
      //     ),
      //   ),
      // ),
      floatingActionButton: Container(
        width: 330,
        height: 45,
        child: FloatingActionButton(
          backgroundColor: appColors.primary,
          onPressed: () async {
            // Fetch current cart items
            List<AddToCart> currentCartItems =
                await DatabaseHelper().getCartItems();

            // Check if the item is already in the cart
            final existingItem = currentCartItems.firstWhere(
              (item) => item.titel == widget.tetile,
              orElse: () => AddToCart(
                  titel: '',
                  sub: '',
                  price: 0,
                  reting: 0,
                  img: '',
                  itemCount: 0),
            );

            if (existingItem.titel.isNotEmpty) {
              // Item already exists, update its count
              existingItem.itemCount += _count;
              await DatabaseHelper().updateCart(existingItem);
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item quantity updated in cart!')),
              );
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => CartPage()));
            } else {
              // Item doesn't exist, add new item
              final newItem = AddToCart(
                itemCount: _count,
                titel: widget.tetile,
                sub: widget.disc,
                price: widget.price!,
                reting: widget.reting!,
                img: widget.img,
              );
              await DatabaseHelper().insertCart(newItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added to cart!')),
              );
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => CartPage()));
            }
          },
          child: Center(
            child: Text("Add to Cart",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),

      backgroundColor: Colors.grey[900], // Change to your color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Change to your color
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
              height: 330,
              width: double.infinity,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tetile,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.disc,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 15),
                  Text("Size",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(sizes.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSizeIndex = index;
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            border: Border.all(
                                color: selectedSizeIndex == index
                                    ? Colors.brown
                                    : Colors.black12),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              sizes[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("₹${widget.price}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 13),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          // Text("${widget.reating}", style: TextStyle(color: Colors.white)),
                          Text("${widget.reting}",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(width: 10),
                      // Quantity buttons and counter
                      SizedBox(
                        height: 27,
                        width: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(appColors.primary),
                          ),
                          onPressed: _dicrement,
                          child:
                              Text("-", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("$_count", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 10),
                      SizedBox(
                        height: 27,
                        width: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(appColors.primary),
                          ),
                          onPressed: _increment,
                          child: Center(
                              child: Text("+",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(primary: Colors.blue),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(appColors.primary)),
                      onPressed: () async {
                        // Fetch current cart items
                        List<AddToCart> currentCartItems =
                            await DatabaseHelper().getCartItems();

                        // Check if the item is already in the cart
                        final existingItem = currentCartItems.firstWhere(
                          (item) => item.titel == widget.tetile,
                          orElse: () => AddToCart(
                              titel: '',
                              sub: '',
                              price: 0,
                              reting: 0,
                              img: '',
                              itemCount: 0),
                        );

                        if (existingItem.titel.isNotEmpty) {
                          // Item already exists, update its count
                          existingItem.itemCount += _count;
                          await DatabaseHelper().updateCart(existingItem);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Item quantity updated in cart!')),
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        } else {
                          // Item doesn't exist, add new item
                          final newItem = AddToCart(
                            itemCount: _count,
                            titel: widget.tetile,
                            sub: widget.disc,
                            price: widget.price!,
                            reting: widget.reting!,
                            img: widget.img,
                          );
                          await DatabaseHelper().insertCart(newItem);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Item added to cart!')),
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        }
                      },
                      child: Center(
                        child: Text("Buy Now",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "There is nothing better than sipping a good cup of coffee. On rainy days, a cup of Caramel Macchiato soothes and warms up my insides. On regularly hot days, a grande-sized (or maybe a venti) Caramel Frappuccino just beats the heat. Then on just plain old days, a bottle or two of iced coffee fills my energy up....",
                    style: TextStyle(color: Colors.white),
                  ),
                  CoffeeList(showFullData)
                  //specialForYou(myListString),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
