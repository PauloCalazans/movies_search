import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/external/datasource/omdb_datasource.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = OmdbDatasource(dio);

  test('Deve retorna uma lista de MovieModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(responseMoviesForTest), statusCode: 200));

    final future = datasource.searchTitle("avengers", 1);

    expect(future, completes);

  });

  test('Deve retorna um erro se o statusCode não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.searchTitle("avengers", 1);
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('Deve retorna um MovieDetailModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(responseMoveDetailsForTest), statusCode: 200));

    final future = datasource.searchByimdbID("tt5848");

    expect(future, completes);

  });

  test('Deve retorna um erro se o statusCode não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future = datasource.searchByimdbID("tt451");
    expect(future, throwsA(isA<DataSourceError>()));
  });
}

const responseMoviesForTest = """
   {
    "Search": [
        {
          "Title": "Avengers: Age of Ultron - Bookending the Action",
          "Year": "2015",
          "imdbID": "tt6731268",
          "Type": "movie",
          "Poster": "N/A"
        },
        {
          "Title": "Crayola Color Alive Marvels Avengers Commercial",
          "Year": "2016",
          "imdbID": "tt6819950",
          "Type": "movie",
          "Poster": "N/A"
        },
        {
          "Title": "Avengers S.T.A.T.I.O.N.",
          "Year": "2014",
          "imdbID": "tt6331934",
          "Type": "movie",
          "Poster": "https://m.media-amazon.com/images/M/MV5BOTI0MDcxN2QtYzk3NS00YzQ4LWJhMDYtZTUyYmZmZDRlOGFjL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTgzNzUxMzE@._V1_SX300.jpg"
        },
        {
          "Title": "Marvel's Avengers",
          "Year": "2020",
          "imdbID": "tt6468680",
          "Type": "game",
          "Poster": "https://m.media-amazon.com/images/M/MV5BNWYyYjc0OWItNmVkOS00NDViLWE0MjAtNjg3NjNjZjQ1YTA2XkEyXkFqcGdeQXVyNjg2NjQwMDQ@._V1_SX300.jpg"
        },
        {
          "Title": "Avengers Labs: Mark 43 Armour Tech",
          "Year": "2015",
          "imdbID": "tt5377226",
          "Type": "movie",
          "Poster": "N/A"
        },
        {
          "Title": "Playmation Marvel's Avengers: How It Works",
          "Year": "2015",
          "imdbID": "tt5377260",
          "Type": "movie",
          "Poster": "N/A"
        }
    ],
  "totalResults": "106",
  "Response": "True"
  }
""";

const responseMoveDetailsForTest = """
    {
      "Title": "Bat*21",
      "Year": "1988",
      "Rated": "R",
      "Released": "21 Oct 1988",
      "Runtime": "105 min",
      "Genre": "Drama, War",
      "Director": "Peter Markle",
      "Writer": "William C. Anderson (book), William C. Anderson (screenplay), George Gordon (screenplay)",
      "Actors": "Gene Hackman, Danny Glover, Jerry Reed, David Marshall Grant",
      "Plot": "Lt. Col. Iceal Ham Hambleton is a weapons countermeasures expert and when his aircraft is shot over enemy territory the Air Force very much wants to get him back. Hambleton knows the area he's in is going to be carpet-bombed but a temporary shortage of helicopters causes a delay. Working with an Air Force reconnaissance pilot, Capt. Bartholomew Clark, he maps out an escape route based on golf courses he has played. Along the way however, he has to face enemy forces and the death of some of his fellow soldiers.",
      "Language": "English",
      "Country": "USA",
      "Awards": "1 nomination.",
      "Poster": "https://m.media-amazon.com/images/M/MV5BZDRmNjYwZDktOTYxZi00MTdlLWI5ZjYtYWU4MDE5MDc5NGM3L2ltYWdlXkEyXkFqcGdeQXVyNjQzNDI3NzY@._V1_SX300.jpg",
      "Ratings": [
        {
          "Source": "Internet Movie Database",
          "Value": "6.5/10"
        },
        {
          "Source": "Rotten Tomatoes",
          "Value": "81%"
        },
        {
          "Source": "Metacritic",
          "Value": "58/100"
        }
      ],
      "Metascore": "58",
      "imdbRating": "6.5",
      "imdbVotes": "7,758",
      "imdbID": "tt0094712",
      "Type": "movie",
      "DVD": "19 Dec 2000",
      "BoxOffice": "N/A",
      "Production": "Media Home Entertainment",
      "Website": "N/A",
      "Response": "True"
    }
""";