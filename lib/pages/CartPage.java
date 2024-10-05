//import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart'; // Import the shimmer package
//import 'package:flutterapp/utils/colors.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
//import '../utils/dbHelper.dart';
//import 'models.dart';
//
//class CartPage extends StatefulWidget {
//  const CartPage({Key? key}) : super(key: key);
//
//  @override
//  State<CartPage> createState() => _CartPageState();
//}
//
//class _CartPageState extends State<CartPage> {
//  List<AddToCart> cartItems = [];
//  bool isLoading = true; // Add loading state
//
//  @override
//  void initState() {
//    super.initState();
//    _loadCartItems();
//  }
//
//  Future<void> _loadCartItems() async {
//    cartItems = await DatabaseHelper().getCartItems();
//    setState(() {
//      isLoading = false; // Set loading to false once data is fetched
//    });
//  }
//
//  void _addItem(AddToCart item) {
//    final existingItemIndex =
//        cartItems.indexWhere((cartItem) => cartItem.titel == item.titel);
//
//    if (existingItemIndex != -1) {
//      setState(() {
//        cartItems[existingItemIndex] = AddToCart(
//          titel: item.titel,
//          sub: item.sub,
//          price: item.price,
//          reting: item.reting,
//          img: item.img,
//          itemCount: cartItems[existingItemIndex].itemCount + 1,
//        );
//      });
//      DatabaseHelper().updateCart(cartItems[existingItemIndex]);
//    } else {
//      setState(() {
//        cartItems.add(item);
//      });
//      DatabaseHelper().insertCart(item);
//    }
//  }
//
//  void _removeItem(int index) {
//    final itemToRemove = cartItems[index];
//    setState(() {
//      cartItems.removeAt(index);
//    });
//    DatabaseHelper().deleteCartItem(itemToRemove.titel);
//  }
//
//  int _calculateTotalPrice() {
//    return cartItems.fold(
//        0, (total, item) => total + (item.price * item.itemCount));
//  }
//
//  void _incrementCount(int index) {
//    setState(() {
//      cartItems[index] = AddToCart(
//        titel: cartItems[index].titel,
//        sub: cartItems[index].sub,
//        price: cartItems[index].price,
//        reting: cartItems[index].reting,
//        img: cartItems[index].img,
//        itemCount: cartItems[index].itemCount + 1,
//      );
//      DatabaseHelper().updateCart(cartItems[index]);
//    });
//  }
//
//  void _decrementCount(int index) {
//    if (cartItems[index].itemCount > 1) {
//      setState(() {
//        cartItems[index] = AddToCart(
//          titel: cartItems[index].titel,
//          sub: cartItems[index].sub,
//          price: cartItems[index].price,
//          reting: cartItems[index].reting,
//          img: cartItems[index].img,
//          itemCount: cartItems[index].itemCount - 1,
//        );
//        DatabaseHelper().updateCart(cartItems[index]);
//      });
//    } else {
//      _removeItem(index);
//    }
//  }
//
//  Razorpay _razorpay = Razorpay();
//
//  void _handlePaymentSuccess(PaymentSuccessResponse response) {
//    // Do something when payment succeeds
//    response.paymentId;
//  }
//
//  void _handlePaymentError(PaymentFailureResponse response) {
//    // Do something when payment fails
//  }
//
//  void _handleExternalWallet(ExternalWalletResponse response) {
//    // Do something when an external wallet was selected
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _razorpay.clear();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//    final screenWidth = MediaQuery.of(context).size.width;
//    final screenHeight = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      backgroundColor: appColors.secondry,
//      appBar: AppBar(
//        backgroundColor: appColors.secondry,
//        title: Text("My Cart", style: TextStyle(color: Colors.white)),
//      ),
//      body: isLoading // Check if loading
//          ? _buildShimmerEffect(screenWidth, screenHeight) // Show shimmer effect
//          : cartItems.isEmpty
//              ? Center(
//                  child: Text('No items in cart.',
//                      style: TextStyle(color: Colors.white)))
//              : _buildCartList(screenWidth, screenHeight),
//    );
//  }
//
//  Widget _buildShimmerEffect(double screenWidth, double screenHeight) {
//    return ListView.builder(
//      itemCount: 3, // Show 3 shimmer items for example
//      itemBuilder: (context, index) {
//        return Shimmer.fromColors(
//          baseColor: Colors.grey[700]!,
//          highlightColor: Colors.grey[600]!,
//          child: Container(
//            height: screenHeight * 0.178,
//            margin: EdgeInsets.symmetric(
//                horizontal: screenWidth * 0.02,
//                vertical: screenHeight * 0.01),
//            decoration: BoxDecoration(
//              color: Colors.grey[800],
//              borderRadius: BorderRadius.circular(18),
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  Widget _buildCartList(double screenWidth, double screenHeight) {
//    return Column(
//      children: [
//        Expanded(
//          child: ListView.builder(
//            itemCount: cartItems.length,
//            itemBuilder: (context, index) {
//              final item = cartItems[index];
//              return Container(
//                height: screenHeight * 0.178, // Adjust height based on screen height
//                margin: EdgeInsets.symmetric(
//                    horizontal: screenWidth * 0.02,
//                    vertical: screenHeight * 0.01),
//                decoration: BoxDecoration(
//                  color: Colors.grey[800],
//                  borderRadius: BorderRadius.circular(18),
//                ),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Container(
//                      decoration: BoxDecoration(
//                        color: Colors.blue,
//                        borderRadius: BorderRadius.circular(20),
//                        image: DecorationImage(
//                          image: NetworkImage(item.img),
//                          fit: BoxFit.cover,
//                        ),
//                      ),
//                      height: screenHeight * 0.15, // Adjust height
//                      width: screenWidth * 0.350, // Adjust width
//                    ),
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Padding(
//                            padding: const EdgeInsets.only(left: 8.0),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: [
//                                Text(item.titel,
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 18)),
//                                IconButton(
//                                  icon: Icon(Icons.delete, color: Colors.red),
//                                  onPressed: () => _removeItem(index),
//                                ),
//                              ],
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 8.0),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Text(item.sub,
//                                    overflow: TextOverflow.ellipsis,
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 11)),
//                                SizedBox(height: 8),
//                                Text("₹${item.price}",
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 16)),
//                                Row(
//                                  children: [
//                                    Icon(Icons.star,
//                                        color: Colors.amber, size: 16),
//                                    Text("${item.reting}",
//                                        style: TextStyle(
//                                            color: Colors.white)),
//                                    SizedBox(width: 33),
//                                    SizedBox(
//                                      height: 27,
//                                      width: 55,
//                                      child: ElevatedButton(
//                                        style: ButtonStyle(
//                                          backgroundColor: MaterialStateProperty.all(
//                                              appColors.primary),
//                                        ),
//                                        onPressed: () => _decrementCount(index),
//                                        child: Text("-",
//                                            style: TextStyle(color: Colors.white)),
//                                      ),
//                                    ),
//                                    SizedBox(width: 10),
//                                    Text("${item.itemCount}",
//                                        style: TextStyle(color: Colors.white)),
//                                    SizedBox(width: 10),
//                                    SizedBox(
//                                      height: 27,
//                                      width: 55,
//                                      child: ElevatedButton(
//                                        style: ButtonStyle(
//                                          backgroundColor: MaterialStateProperty.all(
//                                              appColors.primary),
//                                        ),
//                                        onPressed: () => _incrementCount(index),
//                                        child: Center(
//                                            child: Text("+",
//                                                style: TextStyle(color: Colors.white))),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              );
//            },
//          ),
//        ),
//        Padding(
//          padding: EdgeInsets.all(screenWidth * 0.04),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Text("Total: ₹${_calculateTotalPrice()}",
//                  style: TextStyle(color: Colors.white, fontSize: 20)),
//              ElevatedButton(
//                onPressed: () {
//                  // Handle the buy now action
//                  var options = {
//                    'key': 'rzp_test_NnwHzEjUGkWpnS',
//                    'amount': 100 * _calculateTotalPrice(),
//                    'currency': 'USD',
//                    'name': 'CoffeeDay',
//                    'description': 'Fine T-Shirt',
//                    'prefill': {
//                      'contact': '8888888888',
//                      'email': 'test@razorpay.com'
//                    }
//                  };
//                  _razorpay.open(options);
//                },
//                style: ButtonStyle(
//                  backgroundColor: MaterialStateProperty.all(appColors.primary),
//                ),
//                child: Text("Buy Now",
//                    style: TextStyle(color: Colors.white)),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//}
