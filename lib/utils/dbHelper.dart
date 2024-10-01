
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../pages/myCart.dart';
// // import 'models.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;
//
//   factory DatabaseHelper() {
//     return _instance;
//   }
//
//   DatabaseHelper._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'cart.db');
//     return await openDatabase(
//       path,
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE cart(id INTEGER PRIMARY KEY, title TEXT, sub TEXT, price INTEGER, rating INTEGER, img TEXT)",
//         );
//       },
//       version: 1,
//     );
//   }
//
//   Future<void> insertCart(AddToCart item) async {
//     final db = await database;
//     await db.insert(
//       'cart',
//       item.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<AddToCart>> getCartItems() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('cart');
//
//     return List.generate(maps.length, (i) {
//       return AddToCart(
//         titel: maps[i]['title'],
//         sub: maps[i]['sub'],
//         price: maps[i]['price'],
//         reting: maps[i]['rating'],
//         img: maps[i]['img'],
//       );
//     });
//   }
// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../pages/myCart.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, sub TEXT, price INTEGER, rating INTEGER, img TEXT, itemCount INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertCart(AddToCart item) async {
    final db = await database;
    await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCart(AddToCart item) async {
    final db = await database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'title = ?',
      whereArgs: [item.titel],
    );
  }

  Future<List<AddToCart>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return AddToCart(
        itemCount: maps[i]['itemCount'],
        titel: maps[i]['title'],
        sub: maps[i]['sub'],
        price: maps[i]['price'],
        reting: maps[i]['rating'],
        img: maps[i]['img'],
      );
    });
  }

  Future<void> deleteCartItem(String title) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
