import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/card_stores.dart';
import 'add_store_screen.dart';
import 'countries_screen.dart';
import 'currency_screen.dart';
import 'home_screen.dart';

class InternationalScreen extends StatelessWidget {
  InternationalScreen({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(),
      drawer: const StoresDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddStore())); },
        backgroundColor: Colors.orange[300],
        child: const Icon(Icons.add),),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
              FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,),
          ],
        ),
      )      
    );
  }
}

class FavoriteStores extends StatelessWidget {
 FavoriteStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('favorite', isEqualTo: true).get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class MexicoStores extends StatelessWidget {
MexicoStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'México').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class UnitedStores extends StatelessWidget {
  UnitedStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'United States').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class ChinaStores extends StatelessWidget {
  ChinaStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'Thailand').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class CanadaStores extends StatelessWidget {
  CanadaStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'Canada').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}

class SpainStores extends StatelessWidget {
  SpainStores({Key? key}) : super(key: key);
List<String> docIDs = [];

 Future getDocId() async{
  await FirebaseFirestore.instance.collection('stores').where('country', isEqualTo: 'Korea').get().then((snapshot) => snapshot.docs.forEach((document) {
    docIDs.add(document.reference.id);})
  );
 }
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: header(),
      drawer: const StoresDrawer(),
      body: FutureBuilderForStores(method: getDocId(),listdocs: docIDs, db: db,)
    );
  }
}