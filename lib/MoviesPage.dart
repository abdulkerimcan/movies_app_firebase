import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Categories.dart';
import 'Detail.dart';
import 'Movie.dart';

class MoviesPage extends StatefulWidget {
  Categories categories;

  MoviesPage({required this.categories});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  var refCategory = FirebaseDatabase.instance.ref().child("filmler");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories : ${widget.categories.category_name}"),
        leading: Icon(Icons.movie_sharp),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refCategory
            .orderByChild("kategori_ad")
            .equalTo(widget.categories.category_name)
            .onValue,
        builder: (context, event) {
          if (event.hasData) {
            var movieList = <Movie>[];
            var datas = event.data!.snapshot.value as dynamic;
            if (datas != null) {
              datas.forEach((key, object) {
                var movie = Movie.fromJson(key, object);
                movieList.add(movie);
              });
            }
            return GridView.builder(
              itemCount: movieList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3.5),
              itemBuilder: (context, index) {
                var movie = movieList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Detail(movie)));
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                "http://kasimadalan.pe.hu/filmler/resimler/${movie.movie_img}")),
                        Text("${movie.movie_name}",
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
