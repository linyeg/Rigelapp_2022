import 'package:flutter/material.dart';

class ProductCardDetails extends StatelessWidget{
  final String detailItem;
  final String infoItem;

  const ProductCardDetails({Key? key, required this.detailItem, required this.infoItem}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return
    Container(
      padding: const EdgeInsets.only(right: 20),
      child: Card(
        color: Colors.orange[300],
        // ignore: prefer_const_constructors
        shape: Border.all(width: 0.5, color: Colors.white),
        child: SizedBox(
          height: 90,
          width: 90,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(
                detailItem, 
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              
              const SizedBox(height: 8),

              Text(
                infoItem,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
                  )
                )
            ]),
          ),
        ),
      ),
    );
  }
  
}