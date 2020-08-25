import 'package:movies_search/modules/search/domain/entities/movie.dart';

class MovieModel implements Movie {
  @override
  String imdbID;

  @override
  String poster;

  @override
  String title;

  @override
  String type;

  @override
  String year;

  MovieModel({this.imdbID, this.poster, this.title, this.type, this.year});

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return new MovieModel(
      title: map['Title'] as String,
      year: map['Year'] as String,
      imdbID: map['imdbID'] as String,
      type: map['Type'] as String,
      poster: map['Poster'] as String,
    );
  }
}