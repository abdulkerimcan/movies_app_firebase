# Movie App 

An app to watch movies!

## About The Project

In this project, the movies are shown in a list. When clicking a movie ,a detailed page of the movie is shown. And I pulled the directors and categories of the movies in this project from the database thanks to Firebase Realtime database. <br>

Thanks to the following code, I can access the table in the database by creating a reference.
```dart
var refWords = FirebaseDatabase.instance.ref().child("filmler");
```


<br> <br>
![image](https://user-images.githubusercontent.com/79968953/159549558-e09aca9a-73e3-456c-afbd-87a28512f16b.png) <br>
 <br> <br>
I use GridView.builder with FutureBuilder. <br>
```dart
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
            .
            .
            .
            .
            
```

If the data we have taken is empty, it will show a blank screen.<br>
![image](https://user-images.githubusercontent.com/79968953/159549389-e65a333f-c4ea-4a27-973f-e7907b8a55e6.png)
 <br> <br>
I created a class called Movie and kept the features(img url,name,imdb) of the movie in it. <br>

```dart
class Movie {
  String movie_id;
  String movie_name;
  int movie_year;
  String movie_img;
  String categories_name;
  String directors_name;

  Movie(this.movie_id, this.movie_name, this.movie_year, this.movie_img,
      this.categories_name, this.directors_name);

  factory Movie.fromJson(String key, Map<dynamic, dynamic> json) {
    return Movie(
        key,
        json["film_ad"] as String,
        json["film_yil"] as int,
        json["film_resim"] as String,
        json["kategori_ad"] as String,
        json["yonetmen_ad"] as String);
  }
}
```

![image](https://user-images.githubusercontent.com/79968953/159549621-701381eb-bd19-4f60-89b8-cc97f2e68e40.png)
