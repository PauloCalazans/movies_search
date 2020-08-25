import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';

class MovieDetailsModel implements MovieDetails {
  @override
  String actors;

  @override
  String country;

  @override
  String director;

  @override
  String genre;

  @override
  String imdbID;

  @override
  String plot;

  @override
  String poster;

  @override
  String production;

  @override
  String released;

  @override
  String runtime;

  @override
  String title;

  @override
  String type;

  @override
  String writter;

  @override
  String year;

  MovieDetailsModel({this.actors,this.country,this.director,this.genre,this.imdbID,this.plot,this.poster,
          this.production,this.released,this.runtime,this.title,this.type,this.writter,this.year});

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return new MovieDetailsModel(
      title: map['Title'] as String,
      year: map['Year'] as String,
      released: map['Released'] as String,
      runtime: map['Runtime'] as String,
      genre: map['Genre'] as String,
      director: map['Director'] as String,
      writter: map['Writter'] as String,
      actors: map['Actors'] as String,
      plot: map['Plot'] as String,
      country: map['Country'] as String,
      imdbID: map['imdbID'] as String,
      type: map['Type'] as String,
      poster: map['Poster'] as String,
      production: map['Production'] as String,
    );
  }
}