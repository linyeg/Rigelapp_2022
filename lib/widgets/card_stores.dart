import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/international_screen.dart';

class StoreCard extends StatelessWidget {
  final docs;
  final collection;

  const StoreCard({Key? key, this.docs, this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic direction = '/stores/' + docs;
    final db = FirebaseFirestore.instance.doc(direction);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: db.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final docsnap = snapshot.data!;
          return SizedBox(
            width: 400,
            height: 150,
            child: Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color.fromRGBO(255, 183, 77, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: 
              
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: NetworkImage(docsnap['image']),
                                width: 150,
                                height: 100,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 150,
                              child: Column(
                                children: [
                                  Text(docsnap['name'],
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(
                                    "Country: " + docsnap['country'],
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class FutureBuilderForStores extends StatelessWidget {
  final method;
  final listdocs;
  final db;
  const FutureBuilderForStores({Key? key, this.method, this.listdocs, this.db})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: method,
        builder: ((context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height/1.2,
            child: ListView.builder(
              itemCount: listdocs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return StoreCard(
                  docs: listdocs[index],
                  collection: db,
                );
              },
            ),
          );
        }));
  }
}

class StoresDrawer extends StatelessWidget {
  const StoresDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
          const DrawerHeader(
              child: Text("Filters",
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            title: const Text("México"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MexicoStores()));
            },
          ),
          ListTile(
            title: const Text("Canada"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CanadaStores()));
            },
          ),
          ListTile(
            title: const Text("Korea"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SpainStores()));
            },
          ),
          ListTile(
            title: const Text("Thailand"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChinaStores()));
            },
          ),
          ListTile(
            title: const Text("See All"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InternationalScreen()));
            })]));
  }
}

PreferredSizeWidget header() {
  return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        backgroundColor: const Color.fromRGBO(255, 183, 77, 1),
        title: const Text("Stores"),
        toolbarHeight: 75,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
     ),
      ));
}
