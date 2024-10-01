//
// import 'package:flutter/material.dart';
// import 'package:flutterapp/utils/colors.dart';
//
// import '../utils/dbHelper.dart';
// import 'models.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   List<AddToCart> cartItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCartItems();
//   }
//
//   Future<void> _loadCartItems() async {
//     cartItems = await DatabaseHelper().getCartItems();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appColors.secondry,
//       appBar: AppBar(
//         backgroundColor: appColors.secondry, // Change to your color
//         title: Text("My Cart", style: TextStyle(color: Colors.white)),
//       ),
//       body: cartItems.isEmpty
//           ? Center(child: Text('No items in cart.', style: TextStyle(color: Colors.white)))
//           : ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           final item = cartItems[index];
//           return Container(
//             height: 120,
//             margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[800],
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue, // Change to your color
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: NetworkImage(item.img),
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
//                       Text(item.titel, style: TextStyle(color: Colors.white, fontSize: 18)),
//                       Text(item.sub,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(color: Colors.white, fontSize: 11)),
//                       SizedBox(height: 8),
//                       Text("₹${item.price}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.amber, size: 16),
//                           Text("${item.reting}", style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AddToCart {
//   final String titel;
//   final String sub;
//   final int price;
//   final int reting;
//   final String img;
//
//   const AddToCart({
//     required this.titel,
//     required this.sub,
//     required this.price,
//    required this.reting,
//     required this.img,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'title': titel,
//       'sub': sub,
//       'price': price,
//       'rating': reting,
//       'img': img,
//     };
//   }
// }
//
// class MyListData {
//   final String title;
//   final String sub;
//   final int rating;
//   final int id;
//   final int price;
//   final String img;
//
//   const MyListData({
//     required this.id,
//     required this.rating,
//     required this.sub,
//     required this.title,
//     required this.price,
//     required this.img,
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutterapp/utils/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../utils/dbHelper.dart';
import 'models.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<AddToCart> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    cartItems = await DatabaseHelper().getCartItems();
    setState(() {});
  }

  void _addItem(AddToCart item) {
    final existingItemIndex = cartItems.indexWhere((cartItem) => cartItem.titel == item.titel);

    if (existingItemIndex != -1) {
      setState(() {
        cartItems[existingItemIndex] = AddToCart(
          titel: item.titel,
          sub: item.sub,
          price: item.price,
          reting: item.reting,
          img: item.img,
          itemCount: cartItems[existingItemIndex].itemCount + 1,
        );
      });
      DatabaseHelper().updateCart(cartItems[existingItemIndex]);
    } else {
      setState(() {
        cartItems.add(item);
      });
      DatabaseHelper().insertCart(item);
    }
  }

  void _removeItem(int index) {
    final itemToRemove = cartItems[index];
    setState(() {
      cartItems.removeAt(index);
    });
    DatabaseHelper().deleteCartItem(itemToRemove.titel);
  }

  int _calculateTotalPrice() {
    return cartItems.fold(0, (total, item) => total + (item.price * item.itemCount));
  }

  void _incrementCount(int index) {
    setState(() {
      cartItems[index] = AddToCart(
        titel: cartItems[index].titel,
        sub: cartItems[index].sub,
        price: cartItems[index].price,
        reting: cartItems[index].reting,
        img: cartItems[index].img,
        itemCount: cartItems[index].itemCount + 1,
      );
      DatabaseHelper().updateCart(cartItems[index]);
    });
  }

  void _decrementCount(int index) {
    if (cartItems[index].itemCount > 1) {
      setState(() {
        cartItems[index] = AddToCart(
          titel: cartItems[index].titel,
          sub: cartItems[index].sub,
          price: cartItems[index].price,
          reting: cartItems[index].reting,
          img: cartItems[index].img,
          itemCount: cartItems[index].itemCount - 1,
        );
        DatabaseHelper().updateCart(cartItems[index]);
      });
    } else {
      _removeItem(index);
    }
  }

  Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    response.paymentId;
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); 
  }

  @override
  Widget build(BuildContext context) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    return Scaffold(
      backgroundColor: appColors.secondry,
      appBar: AppBar(
        backgroundColor: appColors.secondry,
        title: Text("My Cart", style: TextStyle(color: Colors.white)),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in cart.', style: TextStyle(color: Colors.white)))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(item.img),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 100,
                        width: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.titel, style: TextStyle(color: Colors.white, fontSize: 18)),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeItem(index),
                                  ),
                                ],
                              ),
                              Text(item.sub,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white, fontSize: 11)),
                              SizedBox(height: 8),
                              Text("₹${item.price}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text("${item.reting}", style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 33),
                                  SizedBox(
                                    height: 27,
                                    width: 55,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(appColors.primary),
                                      ),
                                      onPressed: () => _decrementCount(index),
                                      child: Text("-", style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text("${item.itemCount}", style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 27,
                                    width: 55,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(appColors.primary),
                                      ),
                                      onPressed: () => _incrementCount(index),
                                      child: Center(child: Text("+", style: TextStyle(color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ₹${_calculateTotalPrice()}", style: TextStyle(color: Colors.white, fontSize: 20)),
                ElevatedButton(
                  onPressed: () {
                    // Handle the buy now action
                    var options = {
                      // SjO9amQjy3H2ctzbc7dZmqRo
                      'key': 'rzp_test_NnwHzEjUGkWpnS',
                      'amount': 100*_calculateTotalPrice(),
                      'currency': 'USD',
                      'name': 'CoffeeDay',
                      'description': 'Fine T-Shirt',
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      }
                    };
                    _razorpay.open(options);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(appColors.primary),
                  ),
                  child: Text("Buy Now", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddToCart {
  final String titel;
  final String sub;
  final int price;
  final int reting;
  final String img;
   int itemCount;

   AddToCart({
    required this.titel,
    required this.sub,
    required this.price,
    required this.reting,
    required this.img,
    required this.itemCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': titel,
      'sub': sub,
      'price': price,
      'rating': reting,
      'img': img,
      'itemCount': itemCount,
    };
  }
}
