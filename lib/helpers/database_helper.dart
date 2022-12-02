import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_products_flutter/models/product_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database ? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database>_initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join (documentDirectory.path, 'dbproducts.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY,
          category TEXT,
          price  INTEGER,
          ranking INTEGER,
          title TEXT,
          description TEXT,
          calories TEXT,
          aditives TEXT,
          vitamines TEXT,
          imagepath TEXT
        )
      '''
    );
  }

  Future<List<Product>> getProducts() async {
    Database db = await instance.database;
    var products = await db.query('products', orderBy: 'id');

    List<Product> productsList = products.isNotEmpty ? products.map((e) => Product.fromMap(e)).toList() : [];
    return productsList;
  }

  Future<List<Product>> getOneProduct(int productId) async {
    Database db = await instance.database;
    var products = await db.query('products', where: 'id = ?', whereArgs: [productId]);

    List<Product> productsList = products.isNotEmpty ? products.map((e) => Product.fromMap(e)).toList() : [];
    return productsList;
  }

  Future<int> update(Product product) async {
    Database db = await instance.database;
    return db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> add(Product product) async {
    Database db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getProductsCategory(String selectedCategory) async {
    Database db = await instance.database;
    var products = await db.query('products', orderBy:'category', where: 'category = ?', whereArgs: [selectedCategory]);

    List<Product> productsList = products.isNotEmpty ? products.map((e) => Product.fromMap(e)).toList() : [];
    return productsList;
  }

  


}