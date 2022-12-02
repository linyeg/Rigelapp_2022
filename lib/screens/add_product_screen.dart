

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/product_model.dart';
import 'home_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}





class _AddProductScreenState extends State<AddProductScreen> {
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null)  return;
    final imageTemporary  = File(image.path);
    
    setState(() {
      this.image = imageTemporary;
      print(" ${imageTemporary.path}");
      textControllerImagePath.text = imageTemporary.path;
      
    });
  }
  


  final textControllerTitle = TextEditingController();
  
 final textControllerCategory = TextEditingController();
  final textControllerPrice = TextEditingController();
  final textControllerDescription = TextEditingController();
  final textControllerCalories = TextEditingController();
  final textControllerAditives = TextEditingController();
  final textControllerVitaminas = TextEditingController();
  final textControllerImagePath = TextEditingController();









  @override
  Widget build(BuildContext context) {
   
   int ratingvalue = 5;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black,),
          iconSize: 30,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        title: const Text("New Product", style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
                controller: textControllerTitle,
                decoration: const InputDecoration(
                  
                    icon: Icon(Icons.title),
                    labelText: "Product Title")),
                    TextFormField(
                controller: textControllerDescription,
                decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    labelText: "Product description")),
             TextFormField(
              validator: (value) {
                if (value!="Nuts" || value!="Dried Nuts") {
                  return 'Write a valid category';
                }
                return null;
              },
                controller: textControllerCategory,
                decoration: const InputDecoration(
                    icon: Icon(Icons.category),
                    labelText: "Product Category: Nuts Or Dried nuts")),
              
              TextFormField(
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Price';
                }
                return null;
              },
              keyboardType: TextInputType.number,
                controller: textControllerPrice,
                decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: "Product price")),
              TextFormField(
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Calories';
                }
                return null;
              },
              keyboardType: TextInputType.number,
                controller: textControllerCalories,
                decoration: const InputDecoration(
                    icon: Icon(Icons.food_bank),
                    labelText: "Product calories")),
              TextFormField(
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Aditives';
                }
                return null;
              },
              keyboardType: TextInputType.number,
                controller: textControllerAditives,
                decoration: const InputDecoration(
                    icon: Icon(Icons.add),
                    labelText: "Product aditives")),
              TextFormField(
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Vitamines';
                }
                return null;
              },
              keyboardType: TextInputType.number,
                controller: textControllerVitaminas,
                decoration: const InputDecoration(
                    icon: Icon(Icons.check),
                    labelText: "Product vitamines")),
              
              FloatingActionButton.extended(
                elevation: 0,
                label: const Text("Image", 
                style: TextStyle(color: Colors.black, fontSize: 15,)),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.image_search, size: 30, color: Colors.black,),
                    heroTag: "photo", onPressed: () {
                    pickImage(); 
                  },),

          
          const SizedBox(height: 15,),
          
          FloatingActionButton.extended(
            elevation: 0,
            label: const Text("Save", 
            style: TextStyle(color: Colors.white, fontSize: 15,)),
            backgroundColor: Colors.orange,
            icon: const Icon(Icons.save, size: 30, color: Colors.white,),
            onPressed: () async {
              DatabaseHelper.instance.add(Product( category: textControllerCategory.text, price: double.parse(textControllerPrice.text), ranking: ratingvalue, title: textControllerTitle.text, description: textControllerDescription.text, calories: textControllerCalories.text, aditives: textControllerAditives.text, vitamines: textControllerVitaminas.text, imagepath: textControllerImagePath.text));
              setState(() {
                textControllerPrice.clear();
                textControllerCategory.clear();
                textControllerAditives.clear();
                textControllerCalories.clear();
                textControllerDescription.clear();
                textControllerImagePath.clear();
                textControllerTitle.clear();
                textControllerVitaminas.clear();
              });
              final snackBar = SnackBar(
                content: const Text('Product Added'),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {              
                  },
                ),
              );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          ),

            const SizedBox(height: 5),
            
            FutureBuilder<List<Product>>(
              future: DatabaseHelper.instance.getProducts(),
              builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
                if(!snapshot.hasData){
                  return Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(""),
                      ),
                    );
                } else {
                  return snapshot.data!.isEmpty 
                  ? const Center(
                    child: Text("No products"))
                  :  ListView(
                    
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data!.map((product) {
                      return Center(child: Card(child: ListTile(title: Text('Title: ${product.title}, Category: ${product.category}'),
                     
                      )),);
                    },
                  ).toList());
                }
              })
          ],
          
        ),
      ),
    );
  }
}
