
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/DitailPage.dart';

import '../utils/colors.dart';
import 'homePage.dart';

class Fullblackcoffeescrreen extends StatefulWidget {
  const Fullblackcoffeescrreen({super.key});

  @override
  State<Fullblackcoffeescrreen> createState() => _FullblackcoffeescrreenState();
}

class _FullblackcoffeescrreenState extends State<Fullblackcoffeescrreen> {

 final  List<myListData> showFullData  =[
    //  ShowData(reting: 3, sub: "Made by diluting espresso with hot water.", titel: "Black Coffee", price: 300,image: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Cappuccino", price: 240,image: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Latte", price: 240,image: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
    // ShowData(reting: 4, sub: "With Oa 1 Milk", titel: "Latte", price: 240,image: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
  myListData(rating: 3, sub: "Made by water.", title: "Black Coffee", price: 300,img: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
   myListData(rating: 4, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240,img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),
   myListData(rating: 5, sub: "With Oa 1 Milk", title: "Latte", price: 240,img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
   myListData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 240,img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
   myListData(rating: 3, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240,img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),

   myListData(rating: 3, sub: "Made by hot water.", title: "Black Coffee", price: 300,img: "https://static.vecteezy.com/system/resources/thumbnails/023/010/450/small/the-cup-of-latte-coffee-with-heart-shaped-latte-art-and-ai-generated-free-photo.jpg"),
   myListData(rating: 4, sub: "With Oa 1 Milk", title: "Latte", price: 240,img: "https://static.vecteezy.com/system/resources/thumbnails/025/282/026/small/stock-of-mix-a-cup-coffee-latte-more-motive-top-view-foodgraphy-generative-ai-photo.jpg"),
   myListData(rating: 5, sub: "With Oa 1 Milk", title: "Cappuccino", price: 240,img: "https://t3.ftcdn.net/jpg/03/15/40/34/360_F_315403482_MVo1gSOOfvwCwhLZ9hfVSB4MZuQilNrx.jpg"),


 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.secondry,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text("Top Rating Coffess",style: TextStyle(color: appColors.primary,fontSize: 18,fontWeight: FontWeight.bold),),
              CoffeeList(showFullData)
            ],
          ),
        ),
      ),
    );
  }
}

CoffeeList(
    List<myListData>showdata
    ) {
  return Container(
    // color: Colors.amber,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(), // Prevent scrolling
      shrinkWrap: true, // Allows the GridView to take the height of its children
      itemCount: showdata.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8.0, // Horizontal space
        mainAxisSpacing: 8.0,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(reting: showdata[index].rating, disc: showdata[index].sub,img: showdata[index].img,price: showdata[index].price, tetile: showdata[index].title,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    Center(
                      child: Container(
                        height: 87,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: appColors.primary,
                          image: DecorationImage(
                            image: NetworkImage(
                               showdata[index].img,
                                //"https://img.freepik.com/free-photo/delicious-coffee-beans-cup_23-2150691429.jpg"
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                    //  "   Espresso",
                      showdata[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                    //  "    with Oa 1 Milk",
                      showdata[index].sub,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         // "   ₹400",
                          "₹${showdata[index].price}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),SizedBox(
                          width: 50,
                        ),
                        Icon(Icons.star,color: Colors.amber,size: 16,),
                        // Icon(Icons.star,color: Colors.amber,size: 16),
                        // Icon(Icons.star,color: Colors.amber,size: 16),
                        // Icon(Icons.star_border,color: Colors.amber,size: 16)
                        Text("4.3",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class ShowData{
  final int price;
  final String titel;
  final String image;
  final int reting;
  final String sub;

   ShowData({
    required this.titel,
    required this.image,
    required this.reting,
    required this.price,
    required this.sub,
});
}
