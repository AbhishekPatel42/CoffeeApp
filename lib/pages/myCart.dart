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

import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutterapp/pages/paymentSuccessfull.dart';
import 'package:flutterapp/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    loadUserData();
  }

  Future<void> _loadCartItems() async {
    cartItems = await DatabaseHelper().getCartItems();
    setState(() {});
  }

  void _addItem(AddToCart item) {
    final existingItemIndex =
    cartItems.indexWhere((cartItem) => cartItem.titel == item.titel);

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
    return cartItems.fold(
        0, (total, item) => total + (item.price * item.itemCount));
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


  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Abhishekkk${response.data}");
    try {
      String paymentId = response.paymentId!;
      String orderId = response.orderId??'';
      int amount = _calculateTotalPrice();

      // Retrieve user email (consider adding error handling for missing email)
      String customerEmail = "patelnikhil1833@gmail.com"; // Assuming EmailController holds user email

      // Generate PDF
      Uint8List pdfData = await generateInvoicePdf(paymentId, orderId, amount, customerEmail);

      // Send Invoice
      await sendInvoiceEmail(customerEmail, pdfData);

      // Navigate to the payment success page
      Navigator.push(context, MaterialPageRoute(builder: (context) => Paymentsuccessfull()));
    } catch (error) {
      // Handle errors during invoice generation or email sending
      print('Error sending invoice: $error');
      // Consider showing an error message to the user
    }
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print('Payment Error: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    print('External Wallet: ${response.walletName}');
  }

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  bool isLoading = true;
  String? profilePhotoUrl;

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await usersCollection.doc(user.uid).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          // NameController.text = data['name'] ?? '';
          //EmailController.text = data['email'] ?? '';
          // NumberController.text = data['phoneNumber'] ?? '';
          profilePhotoUrl = data['profilePhotoUrl'] ?? '';
          isLoading = false; // Set to false after loading data
        });
      }
    }
  }


  Future<Uint8List> generateInvoicePdf(String paymentId, String orderId, int amount, String customerEmail) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 25),
              pw.Text('Payment ID: $paymentId'),
              pw.SizedBox(height: 10),
              pw.Text('Order ID: $orderId'),
              pw.SizedBox(height: 10),
              pw.Text('Amount: ₹$amount'),
              pw.SizedBox(height: 10),
              pw.Text('Customer Email: $customerEmail'),
              pw.SizedBox(height: 10),
              pw.Text('Authour Name: Shubham'),
              pw.SizedBox(height: 10),
              pw.Text('Delivered Date: 10/10/2024'),
              pw.Text('Product Name: vijen'),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  Future<void> sendInvoiceEmail(String customerEmail, Uint8List pdfData) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/invoice.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdfData);

    final Email email = Email(
      body: 'Please find attached your invoice.',
      subject: 'Your Invoice',
      recipients: [customerEmail],
      attachmentPaths: [path],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  height: screenHeight * 0.178,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
                  decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: NetworkImage(item.img), fit: BoxFit.cover),
                        ),
                        height: screenHeight * 0.15,
                        width: screenWidth * 0.350,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.titel, style: TextStyle(color: Colors.white, fontSize: 18)),
                                  IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _removeItem(index)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.sub, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 11)),
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
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColors.primary)),
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
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColors.primary)),
                                          onPressed: () => _incrementCount(index),
                                          child: Center(child: Text("+", style: TextStyle(color: Colors.white))),
                                        ),
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
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ₹${_calculateTotalPrice()}", style: TextStyle(color: Colors.white, fontSize: 20)),
                ElevatedButton(
                  onPressed: () {
                    var options = {
                      'key': 'rzp_test_NnwHzEjUGkWpnS',
                      'amount': 100 * _calculateTotalPrice(),
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
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColors.primary)),
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
