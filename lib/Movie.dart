import 'Categories.dart';
import 'Directors.dart';

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
