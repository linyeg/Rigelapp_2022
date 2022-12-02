import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../screens/product_details_screen.dart';

class ProductDetailsCard extends StatelessWidget{
  final int p_id;
  final String imagePath;
  final String title;
  final double price;
  final int ranking;


  const ProductDetailsCard({Key? key, required this.imagePath, required this.title,
  required this.price, required this.ranking, required this.p_id, }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(File(imagePath), height: 120,),

            ),
              
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(title.replaceAll(" ", "\n"),
                    style: const TextStyle(
                      fontWeight:FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30
                    )
                  ),
                  const SizedBox(height: 20),
                  Text("\$${price.toString()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    )
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    itemSize: 18,
                    initialRating:
                    ranking.toDouble(),
                    minRating: 1,
                    direction:Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal:2.0),
                    itemBuilder: (context,_) =>
                    const Icon(
                      Icons.star,
                      color: Colors.white),
                    onRatingUpdate:(rating) {
                    print(rating);
                    }
                  ),
                  const SizedBox(height: 10,),
                  FloatingActionButton.extended(
                    elevation: 0,
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            productIdCard: p_id,
                          )
                        )
                      );
                    },
                    label: const Text("Add to cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      )
                    ),
                    backgroundColor:Colors.white,
                    icon: const Icon(Icons.shopping_cart,
                      size: 20.0,
                      color: Colors.black,
                    )
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
  
}