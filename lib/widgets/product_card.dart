import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String pathImage;

  const ProductCard(
      {Key? key,
      required this.pathImage,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    const fontStyle1 = TextStyle(
      fontWeight: FontWeight.bold,
    );
    const fontStyle2 = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12);
    */

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          width: 100.0,
          height: 100.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
          ),
        ),
        const Image(
          image: NetworkImage('https://www.pngmart.com/files/5/Hamburger-PNG-Free-Download.png',
          ),
          height: 60.0,
          alignment: Alignment.center,
        ),
      ]
    );
    
    /*Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150)),
      elevation: 25,
      child: const CircleAvatar(
        radius: 40.0,
        backgroundImage:
            NetworkImage('https://cdn.dsmcdn.com/ty158/product/media/images/20210809/12/117071800/224878258/1/1_org_zoom.jpg'),
        backgroundColor: Colors.transparent,
      )
    );*/
  }
}

