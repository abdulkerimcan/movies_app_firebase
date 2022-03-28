import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Categories.dart';

import 'MoviesPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var refCategory = FirebaseDatabase.instance.ref().child("kategoriler");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        leading: Icon(Icons.movie_sharp),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refCategory.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var categoryList = <Categories>[];
            var datas = event.data!.snapshot.value as dynamic;
            if(datas != null) {
              datas.forEach((key,object) {
                var category = Categories.fromJson(key, object);
                categoryList.add(category);
              });
            }
            return ListView.builder(
              itemCount: categoryList!.length,
              itemBuilder: (context, index) {
                var category = categoryList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MoviesPage(categories: category)));
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${category.category_name}",
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );},
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
