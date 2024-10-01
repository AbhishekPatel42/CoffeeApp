import 'package:path/path.dart';

import 'localModel.dart';

class ProductModel extends Model {
  static String table= "product";

  int? id;
  int? categoryId;
  String productName;
  String? productDisc;
  String? productImg;
  double? price;
  double? rating;

  ProductModel({
 this.id,
 required this.productName,
    this.price,
 this.rating,
 this.categoryId,
 this.productDisc,
 this.productImg,
});

  static ProductModel fromMap(Map<String,dynamic> json) {
    return ProductModel(
        id: json["id"],
        productName: json["productName"].toString(),
        price: json["price"],
      rating: json["rating"],
      categoryId: json["categoryId"],
      productDisc: json["productDisc"],
      productImg: json["productImg"],

    );
  }

}