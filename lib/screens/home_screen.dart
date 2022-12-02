import 'dart:io';

import 'package:app_products_flutter/screens/product_details_screen.dart';
import 'package:app_products_flutter/widgets/product_details_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../helpers/database_helper.dart';
import '../models/product_model.dart';

import 'add_product_screen.dart';
import 'country_screen2.dart';
import 'currency_screen.dart';
import 'international_screen.dart';
import 'order_summary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "candy";
  int productId = 1;
  String productTitle = "";
  String noImage = "https://dues.com.mx/duesAdmin/assets/web-page/logos/defaultSF.png";
  @override
  Widget build(BuildContext context) {
    const textTitleStyle = TextStyle(fontSize: 18, color: Colors.brown);
    const textTitleBoldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.brown);
    const textSmallLetterStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.brown);


    return Scaffold(
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.orange[300],
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.shopping_cart),
            onPressed: () { 
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Myorders()));
            },)
          
        ],
      ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
              const DrawerHeader(
                child: Text("Menu", style: TextStyle(color: Colors.black, fontSize: 20))),
              ListTile(
                title: const Text("Countries"),
                onTap: () {
                  final route = MaterialPageRoute(
                    builder: (context) => const CountryScreen2());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                title: const Text("International Stores"),
                onTap: () {
                  final route = MaterialPageRoute(
                    builder: (context) => InternationalScreen());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                title: const Text("Currency"),
                onTap: () {
                  final route = MaterialPageRoute(builder: (context) => CurrencyScreen());
                  Navigator.push(context, route);
                },
              )
            ]
          )
        ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
           
            const Text("Hello"),
            const Text("What today's taste?", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = "Nuts";
                          print(selectedCategory);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.food_bank,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text("Nuts", style: textSmallLetterStyle,),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = "Dried nuts";
                          print(selectedCategory);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Icon(
                        Icons.food_bank_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    const Text("Dried nuts", style: textSmallLetterStyle,),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.search,
                  size: 30,
                )
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 275,
                  height: 275,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orangeAccent),
                  child: FutureBuilder<List<Product>>(
                    future: DatabaseHelper.instance.getOneProduct(productId),
                    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                      if (!snapshot.hasData) {
                        return 
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Text("",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20
                              )
                            ),
                          ),
                        );
                      } else {
                        return snapshot.data!.isEmpty ? 
                          Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: const Image(image: NetworkImage("https://dues.com.mx/duesAdmin/assets/web-page/logos/defaultSF.png"), height: 200,)),
                                ],
                              )
                            )
                          )
                        : ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.map((product) {
                              return GestureDetector(
                                onLongPress: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(productIdCard: productId)
                                    )
                                  );
                                },
                                child: ProductDetailsCard(
                                  p_id: product.id!.toInt(),
                                  imagePath: product.imagepath, 
                                  title: product.title, 
                                  price: product.price, 
                                  ranking: product.ranking),
                              );
                            },
                          ).toList()
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder<List<Product>>(
                    future: DatabaseHelper.instance.getProductsCategory(selectedCategory),
                    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
                      print("conect: ${snapshot.connectionState})");
                      if(!snapshot.hasData){
                        print(snapshot.data);
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Text("Loading...",style: TextStyle(
                              fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
                            )),
                          ),
                        );
                      }else{
                        return snapshot.data!.isEmpty ? 
                        Center(
                          child: Container(
                            child: const Text("No products", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20
                              )
                            )
                          )
                        )
                        :SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: snapshot.data!.map((product) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.orange[300]
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState((){
                                        productId= product.id!.toInt();
                                      });
                                      print(product.category);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(), backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image(image: FileImage(File(product.imagepath)), width: 110,)
                                    ),
                                  )
                                ),
                              );
                            },
                          ).toList()),
                        );
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProductScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      side: const BorderSide(width: 3.0, color: Colors.grey)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: 30,
                    ),
                  )
                ],
              ),
            )
          ]
        ),
      )
    );
  }
}