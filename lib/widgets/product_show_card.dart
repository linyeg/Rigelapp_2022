import 'package:flutter/material.dart';

class ProductShowCard extends StatelessWidget {
  final String name;
  final String position;

  const ProductShowCard(
      {Key? key,
      required this.name,
      required this.position,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fontStyle1 = TextStyle(
      fontWeight: FontWeight.bold,
    );
    const fontStyle2 = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12);

    return Column(
      children: [
        InkWell(
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Icon(Icons.share)))
          },
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150)),
              elevation: 25,
              child: SizedBox(
                height: 60,
                width: 190,
                child: Row(
                  children: [
                    Column(
                      children: [
                        ClipPath(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: const Icon(Icons.image),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(name, style: fontStyle1),
                          Text(
                            position,
                            style: fontStyle2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}