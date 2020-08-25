import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_search/modules/search/domain/entities/movie.dart';
import 'package:movies_search/modules/search/domain/entities/movie_detail.dart';
import 'package:movies_search/modules/search/domain/errors/search_errors.dart';
import 'package:movies_search/modules/search/domain/repositories/search_repository.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_imdbid.dart';
import 'package:movies_search/modules/search/domain/usecases/search_by_title.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByImdbIDImpl(repository);

  test('Deve retornar um MovieDetails', () async {

    when(repository.searchDetails(any)).thenAnswer((_) async => Right(MovieDetails()));
    final result = await usecase("tt123");
    expect(result | null, isA<MovieDetails>());
  });

  test('Deve retornar um erro caso o imdbID seja inválido', () async {

    when(repository.searchDetails(any)).thenAnswer((_) async => Right(MovieDetails()));
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}