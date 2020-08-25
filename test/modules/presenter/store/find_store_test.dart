import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/app_modules.dart';
import 'package:movies_search/modules/search/presenter/states/find_state.dart';
import 'package:movies_search/modules/search/presenter/stores/find_store.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  initModule(AppModules(), changeBinds: [Bind<Dio>((i) => dio)]);

  test('deve trocar o estado para SuccessStateMovieDetail', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(responseMoveDetailsForTest), statusCode: 200));

    var store = Modular.get<FindStore>();
    final result = await store.makeSearchByImdbID("text");
    expect(result, isA<FindSuccessStateMovieDetails>());
  });
}

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