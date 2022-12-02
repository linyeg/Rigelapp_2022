import 'dart:io';

import 'package:app_products_flutter/screens/shopping_car.dart';
import 'package:app_products_flutter/screens/shopping_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_products_flutter/helpers/shopping_car_helper.dart';
import 'package:app_products_flutter/models/shopping_model.dart';
import 'package:app_products_flutter/screens/home_screen.dart';
import 'package:favorite_button/favorite_button.dart';
import '../helpers/database_helper.dart';
import '../models/product_model.dart';
import 'package:quantity_input/quantity_input.dart';
import '../widgets/product_details_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productIdCard;


  const ProductDetailsScreen({Key? key, required this.productIdCard}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  int newQuantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          iconSize: 30,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<List<Product>>(
              future:DatabaseHelper.instance.getOneProduct(widget.productIdCard),
              builder: (BuildContext context,
              AsyncSnapshot<List<Product>> snapshot) {
                if(!snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text("",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                    ),
                  );
                } else {
                  return snapshot.data!.isEmpty ? Center(
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
                  :Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map(
                        (product) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25),
                                child: Column(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(10.0),
                                        child:  Image.file(File(product.imagepath), width: 250,),
                                      ),
                                    ),
                                    const SizedBox(height: 15,),

                                    Text(product.title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [ 
                                        Flexible(
                                          child: Text(
                                            product.description,
                                            maxLines: 3,
                                            softWrap: false,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          )
                                        ),
                                        RatingBar.builder(
                                          itemSize: 15,
                                          initialRating: product.ranking.toDouble(),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemPadding:const EdgeInsets.symmetric(horizontal: 2.0),
                                          itemBuilder: (context, _) => const Icon(Icons.star,
                                            color:Colors.white
                                          ),
                                          onRatingUpdate:(rating) {}
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25,),

                                    const Text("Capacity",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight.bold
                                      )
                                    ),
                                    const SizedBox(height: 10,),

                                    Row(
                                      children: [
                                        ProductCardDetails(
                                          detailItem: "Calories",
                                          infoItem: product.calories
                                        ),
                                        ProductCardDetails(
                                          detailItem: "Vitamines",
                                          infoItem:product.vitamines
                                        ),
                                        ProductCardDetails(
                                          detailItem: "Aditives",
                                          infoItem: product.aditives
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              //SizedBox(height: 25,),
                              Card(
                                color: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                                child: SizedBox(
                                  height: 190,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        const Text("Quantity"),
                                        const SizedBox( height: 5,),

                                        Row(
                                          children: [
                                            QuantityInput(
                                              buttonColor: Colors.black,
                                              acceptsZero: false,
                                              minValue: 1,
                                              value: newQuantity,
                                              onChanged: (value) => setState(() => newQuantity = int.parse(value))),
                                            const Spacer(),
                                            Text("\$${product.price}",
                                              style: const TextStyle(fontSize: 20),
                                            )
                                          ]
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 300,
                                              child: FloatingActionButton.extended(
                                                elevation: 0,
                                                onPressed:()async {
                                                  DatabaseHelperShoppingCar.instance.addShoppingCar(
                                                    ShoppingCar(
                                                      price: product.price, 
                                                      title: product.title, 
                                                      quantity: newQuantity, 
                                                      imagepath: product.imagepath));

                                                  Navigator.push(context,
                                                    MaterialPageRoute(builder:(context) =>
                                                      ShoppingCarScreen(
                                                        productQuantity: newQuantity,
                                                        productName: product.title,
                                                        productPrice: product.price,
                                                        produtId: product.id!.toInt(),
                                                      )
                                                    )
                                                  );
                                                },
                                                label: const Text("Add to the car",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12
                                                  )
                                                ),
                                                backgroundColor:Colors.orange),
                                            ),
                                            const Spacer(),
                                            FavoriteButton(
                                              iconSize: 45,
                                              isFavorite: true,
                                              valueChanged: (isFavorite) {
                                                print('Is Favorite : $isFavorite');
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                              //const SizedBox(height: 25,),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: Card(
                                  color: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    )
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20, 
                                        right: 20
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.shopping_bag_outlined,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5,),
                                          const Text("Car",
                                            style: TextStyle(
                                              color: Colors.white
                                            ),
                                          ),
                                          const Spacer(),

                                          Image.file(File(product.imagepath), height: 30,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ).toList()
                    ),
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}