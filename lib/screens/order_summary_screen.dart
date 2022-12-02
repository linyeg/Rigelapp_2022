import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myorders extends StatelessWidget {
  const Myorders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: const [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Icon(CupertinoIcons.list_bullet_below_rectangle, size: 18,),
            ),
            title: Text("Order Status", style: TextStyle( fontSize: 12, color: Colors.black),),

            subtitle: Text("on: March 20, 2022"),
            trailing: Text("Amount: \$"),
          ),
          ExpansionTile(title: Text("Order Details"))
        ]),

      ),
      
    );
  }
}